# HI - 情绪社交 App

> iOS 原生 SwiftUI 实现的情绪社交 App，UI **严格使用真实设计图**还原。

## 📁 目录结构

```
app/
├── HISocialApp.swift            # @main 入口
├── ContentView.swift             # 顶层路由
│
├── Theme/                       # 颜色/字体
│   ├── AppColors.swift
│   ├── AppFonts.swift
│   ├── Color+Brand.swift
│   └── Font+Brand.swift
│
├── Components/                  # 11 个可复用组件
│   ├── GridBackground.swift
│   ├── GradientBackground.swift
│   ├── PrimaryButton.swift
│   ├── InputField.swift
│   ├── AvatarView.swift
│   ├── MessageBubble.swift
│   ├── TabBarView.swift
│   ├── TopBarView.swift
│   ├── EmojiCard.swift
│   ├── SectionTitle.swift
│   └── DialogOverlay.swift
│
├── Models/                      # 数据模型
│   ├── User.swift
│   ├── Post.swift
│   ├── Message.swift
│   ├── AICharacter.swift
│   ├── MoodGroup.swift
│   ├── MoodTag.swift
│   └── SampleData.swift
│
├── Resources/                   # 图片资源
│   ├── AppImages.swift           # 图片名常量
│   ├── ImageLoader.swift         # 加载辅助
│   └── Images/                   # 42 张设计图 PNG
│       ├── splash.png
│       ├── home.png
│       ├── login.png
│       └── ... (共 42 张)
│
└── Views/                       # 32 个页面
    ├── Splash/
    ├── Onboarding/
    ├── Login/
    ├── Home/
    ├── Community/
    ├── Publish/
    ├── Message/
    ├── AI/
    ├── Video/
    ├── Group/
    ├── MoodMatch/
    ├── MoodBottle/
    ├── Profile/
    ├── Common/
    ├── Dialog/
    └── Drawing/
```

---

## 🚀 Xcode 集成步骤

### 1. 创建 Xcode 项目
- 打开 Xcode → File → New → Project → **iOS App**
- Product Name: `HI`
- Interface: **SwiftUI**
- Language: **Swift**
- 选 iOS 16.0+

### 2. 导入源文件
- 在 Finder 中打开 `app/` 目录
- 拖拽以下子目录到 Xcode 项目（**Copy items if needed** 勾选）：
  - `Theme/`
  - `Components/`
  - `Models/`
  - `Resources/AppImages.swift` 和 `ImageLoader.swift`
  - `Views/`
  - 根目录的 `HISocialApp.swift` 和 `ContentView.swift`

### 3. 添加图片资源
**方法 A：使用 Asset Catalog（推荐）**
- 在项目中创建 `Assets.xcassets`
- 把 `app/Resources/Images/` 中的所有 PNG 拖到 Assets.xcassets
- 资源名 = 文件名（无扩展名），如 `splash.png` → 资产名 `splash`

**方法 B：直接放进 Bundle**
- 在 Xcode 中右键项目 → Add Files to "HI"
- 选择 `app/Resources/Images/` 文件夹
- 选 **Create folder references**（蓝色文件夹）
- 运行时 `Bundle.main` 可以通过 `url(forResource:withExtension:)` 找到

### 4. 配置启动图
- 打开 `Assets.xcassets` → AppIcon & LaunchScreen
- 启动图可用 `splash.png`（直接拉伸到全屏）
- 或者创建 `LaunchScreen.storyboard` 引用 `logo.png`

### 5. 运行
- 选择 iPhone 模拟器 → Cmd+R
- 启动 → 引导 → 登录 → 首页

---

## 🖼️ 图片资源清单（42 张）

| 文件名 | 用途 |
|--------|------|
| `splash.png` | 启动页 |
| `onboarding_1/2/3.png` | 引导 3 页 |
| `login.png` | 登录页 |
| `home.png` | 首页 |
| `community_feed.png` | 社区动态 |
| `post_detail.png` | 动态详情 |
| `publish.png` | 发布 |
| `messages.png` | 消息列表 |
| `chat.png` | 聊天 |
| `ai_chat.png` | AI 聊天 |
| `ai_character.png` | AI 角色 |
| `video.png` / `video_alt.png` | 视频 |
| `video_call.png` | 视频通话 |
| `group_list.png` | 小组列表 |
| `group_detail.png` | 小组详情 |
| `following.png` | 关注 |
| `my_profile.png` | 我的 |
| `my_posts.png` | 我的发布 |
| `edit_profile.png` | 编辑资料 |
| `user_profile.png` (+ alt/alt2/alt3) | 用户主页 |
| `wallet.png` | 钱包 |
| `settings.png` | 设置 |
| `blacklist.png` | 黑名单 |
| `report_block.png` | 举报&拉黑 |
| `mood_match.png` | 情绪匹配输入 |
| `mood_matching.png` | 情绪匹配中 |
| `mood_match_result.png` | 情绪匹配结果 |
| `mood_bottle.png` | 情绪瓶子 |
| `drawing_emoji.png` / `drawing_canvas.png` / `drawing_options.png` | 画板 |
| `dialog.png` / `dialog_alt.png` | 弹窗 |
| `empty.png` | 缺省页 |
| `logo.png` | Logo |

---

## 🎨 架构

### 路由（ContentView.swift）
```
Splash (1.5s) → Onboarding (3页) → Login → MainTabView
                                              ↓
                                  Home / AI / Favorites / Me
```

由 `AppRouter: ObservableObject` 管理。

### 加载图片
```swift
// 整图背景
ZStack {
    ImageLoader.background(AppImages.home)
    // 浮动按钮...
}

// 可缩放图片
ImageLoader.resizable(AppImages.logo)
    .frame(width: 100, height: 100)
    .clipShape(Circle())

// 原始 Image
ImageLoader.image(AppImages.splash)
```

### 浮动交互
- 在每张图上用 `ZStack(alignment: .topLeading)` 叠加返回按钮
- 用 `safeAreaInset(edge: .bottom)` 叠加底部按钮
- 用 `GeometryReader` 在图片上定位可点击区域

---

## 🔧 兼容性

- **iOS 16+ / SwiftUI 4.0+**
- **Xcode 14+**
- 支持 iPhone / iPad（自适应布局）

## 📝 注意事项

- 图片按 `app/Resources/Images/` 目录组织，与 `AppImages` 常量一一对应
- 如果图片加载失败，会回退到 SF Symbol 占位（不会崩溃）
- 所有页面都有 `#Preview` 块，可在 Xcode 中独立预览
- 路由状态机基于 `AppRouter`，可独立测试每个 View

## 🎯 后续优化

- [ ] 加入网络层（替换 `SampleData` mock）
- [ ] 加入 WebSocket 实现真实聊天
- [ ] 加入 WebRTC 实现真实视频通话
- [ ] 加入 iOS 17 `@Observable` 优化状态管理
- [ ] 加入深色模式适配
- [ ] 加入国际化（Localizable.strings）
