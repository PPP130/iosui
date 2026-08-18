//
//  VideoCallView.swift
//  HI - Emotion Social App
//
//  "Connecting, please wait..." call screen. The design image
//  (`AppImages.videoCall`) already contains the cyan gradient, the
//  3D radar circles, the 200x200 avatar, and the "Connecting,
//  please wait..." text. This view overlays a top "lex" title with
//  a back chevron and a large red hang-up button at the bottom.
//

import SwiftUI

// MARK: - VideoCallView

public struct VideoCallView: View {

    // Dismiss
    @Environment(\.dismiss) private var dismiss

    public init() {}

    public var body: some View {
        ZStack(alignment: .top) {
            // Full-bleed design image
            ImageLoader.background(AppImages.videoCall)

            // Top bar: back chevron + "lex" title
            topBar

            // Hang-up button (centered near the bottom)
            VStack {
                Spacer()
                hangupButton
                    .padding(.bottom, 60)
            }
            .frame(maxWidth: .infinity)
        }
    }

    // MARK: - Top bar

    private var topBar: some View {
        HStack(spacing: 12) {
            Button {
                dismiss()
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 40, height: 40)
                        .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)

                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .heavy))
                        .foregroundColor(.black)
                }
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Back")

            Text("lex")
                .font(.system(size: 20, weight: .black, design: .rounded))
                .foregroundColor(.black)

            Spacer()
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .padding(.top, 12)
    }

    // MARK: - Hang-up button

    private var hangupButton: some View {
        Button {
            dismiss()
        } label: {
            ZStack {
                Circle()
                    .fill(Color.red)
                    .frame(width: 60, height: 60)
                    .shadow(color: .red.opacity(0.45), radius: 12, x: 0, y: 6)

                Image(systemName: "phone.down.fill")
                    .font(.system(size: 24, weight: .black))
                    .foregroundColor(.white)
                    .rotationEffect(.degrees(135))
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel("End call")
    }
}

// MARK: - Preview

#Preview("VideoCallView") {
    VideoCallView()
}
