//
//  DrawingCanvasView.swift
//  HI - Emotion Social App
//
//  Full drawing canvas for designing a custom emoji. Companion to
//  `DrawingBoardView`. Finger-drawing on a Canvas with pen / eraser,
//  undo, redo, and save. Black background.
//

import SwiftUI

// MARK: - DrawingCanvasView

public struct DrawingCanvasView: View {

    // Public API
    public let onSave: ([DrawingStroke]) -> Void
    public let onClose: () -> Void

    public init(
        onSave: @escaping ([DrawingStroke]) -> Void = { _ in },
        onClose: @escaping () -> Void = {}
    ) {
        self.onSave = onSave
        self.onClose = onClose
    }

    // Drawing state
    @State private var strokes: [DrawingStroke] = []
    @State private var redoStack: [DrawingStroke] = []
    @State private var currentStroke: DrawingStroke?
    @State private var selectedTool: DrawingTool = .pen
    @State private var selectedSticker: StickerKind = .face

    public var body: some View {
        ZStack {
            // PURE BLACK background
            Color.brandBlack
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Top bar
                topBar
                    .padding(.horizontal, 16)
                    .padding(.top, 12)

                Spacer().frame(height: 14)

                // Sticker shortcut row
                stickerRow
                    .padding(.horizontal, 16)

                Spacer().frame(height: 14)

                // Drawing canvas
                drawingSurface
                    .padding(.horizontal, 16)

                Spacer().frame(height: 18)

                // Tool palette
                toolPalette
                    .padding(.horizontal, 16)
                    .padding(.bottom, 18)
            }
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - Top bar

    private var topBar: some View {
        HStack {
            Button(action: onClose) {
                Image(systemName: "xmark")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(
                        Circle().fill(Color.white.opacity(0.10))
                    )
            }
            .buttonStyle(.plain)

            Spacer()

            Text("Draw for \(selectedSticker.label)")
                .font(.brandHeadline)
                .foregroundColor(.white)

            Spacer()

            // Placeholder to keep title centered
            Color.clear.frame(width: 40, height: 40)
        }
    }

    // MARK: - Sticker row

    private var stickerRow: some View {
        HStack(spacing: 10) {
            ForEach(StickerKind.allCases) { sticker in
                Button {
                    selectedSticker = sticker
                } label: {
                    VStack(spacing: 2) {
                        Text(sticker.emoji)
                            .font(.system(size: 22))
                        Text(sticker.label)
                            .font(.system(size: 10, weight: .semibold, design: .rounded))
                            .foregroundColor(
                                selectedSticker == sticker
                                ? Color.brandPrimary
                                : Color.white.opacity(0.55)
                            )
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(
                                selectedSticker == sticker
                                ? Color.brandPrimary.opacity(0.18)
                                : Color.white.opacity(0.06)
                            )
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }

    // MARK: - Drawing surface

    private var drawingSurface: some View {
        GeometryReader { proxy in
            let size = proxy.size
            ZStack {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(Color(white: 0.04))

                // Faint inner border
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(Color.white.opacity(0.08), lineWidth: 1)

                Canvas { context, _ in
                    // Existing strokes
                    for stroke in strokes {
                        drawStroke(stroke, in: &context)
                    }
                    // Live stroke while dragging
                    if let live = currentStroke {
                        drawStroke(live, in: &context)
                    }
                }
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            handleDragChanged(value, canvasSize: size)
                        }
                        .onEnded { value in
                            handleDragEnded(value, canvasSize: size)
                        }
                )
            }
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 360)
    }

    private func drawStroke(_ stroke: DrawingStroke, in context: inout GraphicsContext) {
        guard stroke.points.count > 0 else { return }

        var path = Path()
        path.move(to: stroke.points[0])

        if stroke.points.count == 1 {
            // Single tap — render a small dot so the mark is still visible.
            let p = stroke.points[0]
            let dotRadius = stroke.width / 2
            let dotRect = CGRect(
                x: p.x - dotRadius,
                y: p.y - dotRadius,
                width: stroke.width,
                height: stroke.width
            )
            context.fill(
                Path(ellipseIn: dotRect),
                with: .color(stroke.color)
            )
            return
        }

        for i in 1..<stroke.points.count {
            path.addLine(to: stroke.points[i])
        }

        if stroke.tool == .eraser {
            context.stroke(
                path,
                with: .color(.white),
                style: StrokeStyle(lineWidth: stroke.width, lineCap: .round, lineJoin: .round)
            )
        } else {
            context.stroke(
                path,
                with: .color(stroke.color),
                style: StrokeStyle(lineWidth: stroke.width, lineCap: .round, lineJoin: .round)
            )
        }
    }

    private func handleDragChanged(_ value: DragGesture.Value, canvasSize: CGSize) {
        let location = clamp(value.location, to: canvasSize)

        if currentStroke == nil {
            currentStroke = DrawingStroke(
                tool: selectedTool,
                color: selectedTool == .eraser ? .white : .cyan,
                width: selectedTool == .pen ? 6 : 18,
                points: [location]
            )
        } else {
            currentStroke?.points.append(location)
        }
    }

    private func handleDragEnded(_ value: DragGesture.Value, canvasSize: CGSize) {
        if let stroke = currentStroke, !stroke.points.isEmpty {
            strokes.append(stroke)
            redoStack.removeAll()
        }
        currentStroke = nil
    }

    private func clamp(_ point: CGPoint, to size: CGSize) -> CGPoint {
        CGPoint(
            x: min(max(point.x, 0), size.width),
            y: min(max(point.y, 0), size.height)
        )
    }

    // MARK: - Tool palette

    private var toolPalette: some View {
        HStack(spacing: 10) {
            toolButton(
                icon: "pencil.tip",
                label: "Pen",
                isActive: selectedTool == .pen
            ) {
                selectedTool = .pen
            }

            toolButton(
                icon: "eraser.fill",
                label: "Eraser",
                isActive: selectedTool == .eraser
            ) {
                selectedTool = .eraser
            }

            toolButton(
                icon: "arrow.uturn.backward",
                label: "Undo",
                isActive: false
            ) {
                undo()
            }
            .disabled(strokes.isEmpty)
            .opacity(strokes.isEmpty ? 0.4 : 1)

            toolButton(
                icon: "arrow.uturn.forward",
                label: "Redo",
                isActive: false
            ) {
                redo()
            }
            .disabled(redoStack.isEmpty)
            .opacity(redoStack.isEmpty ? 0.4 : 1)

            toolButton(
                icon: "checkmark.circle.fill",
                label: "Save",
                isActive: false
            ) {
                onSave(strokes)
            }
        }
    }

    private func toolButton(
        icon: String,
        label: String,
        isActive: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(isActive ? .black : .white)
                Text(label)
                    .font(.system(size: 10, weight: .semibold, design: .rounded))
                    .foregroundColor(isActive ? .black : .white.opacity(0.7))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(
                        isActive
                        ? Color.brandPrimary
                        : Color.white.opacity(0.08)
                    )
            )
        }
        .buttonStyle(.plain)
    }

    // MARK: - Actions

    private func undo() {
        guard let last = strokes.popLast() else { return }
        redoStack.append(last)
    }

    private func redo() {
        guard let last = redoStack.popLast() else { return }
        strokes.append(last)
    }
}

// MARK: - Models

public enum DrawingTool: Equatable {
    case pen
    case eraser
}

public struct DrawingStroke: Equatable {
    public var tool: DrawingTool
    public var color: Color
    public var width: CGFloat
    public var points: [CGPoint]

    public init(
        tool: DrawingTool,
        color: Color,
        width: CGFloat,
        points: [CGPoint] = []
    ) {
        self.tool = tool
        self.color = color
        self.width = width
        self.points = points
    }
}

// MARK: - Sticker shortcut

public enum StickerKind: String, CaseIterable, Identifiable {
    case face
    case sad
    case frown
    case smile

    public var id: String { rawValue }

    public var emoji: String {
        switch self {
        case .face:  return "😐"
        case .sad:   return "😢"
        case .frown: return "🙁"
        case .smile: return "🙂"
        }
    }

    public var label: String {
        switch self {
        case .face:  return "Face"
        case .sad:   return "Sad"
        case .frown: return "Frown"
        case .smile: return "Smile"
        }
    }
}

// MARK: - Preview

#Preview("DrawingCanvasView") {
    DrawingCanvasView(
        onSave: { strokes in
            print("Saved \(strokes.count) strokes")
        },
        onClose: {
            print("Close tapped")
        }
    )
}
