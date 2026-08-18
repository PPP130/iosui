//
//  AppImages.swift
//  HI - Emotion Social App
//
//  Centralized image resource names. Each constant maps to a PNG file
//  in `app/Resources/Images/`. When you integrate this project into
//  Xcode, drag the `Resources/Images/` folder into the project's Asset
//  Catalog (`Assets.xcassets`) so `UIImage(named:)` can resolve them.
//
//  After adding to Assets.xcassets, each name in this file corresponds
//  to the asset name in the catalog.
//

import Foundation

public enum AppImages {

    // MARK: - Onboarding / Auth

    public static let splash             = "splash"
    public static let onboarding1        = "onboarding_1"
    public static let onboarding2        = "onboarding_2"
    public static let onboarding3        = "onboarding_3"
    public static let login              = "login"
    public static let logo               = "logo"

    // MARK: - Main

    public static let home               = "home"
    public static let communityFeed      = "community_feed"
    public static let communityFeedAlt   = "community_feed_alt"
    public static let postDetail         = "post_detail"
    public static let publish            = "publish"
    public static let myPosts            = "my_posts"
    public static let messages           = "messages"
    public static let chat               = "chat"
    public static let aiChat             = "ai_chat"
    public static let aiCharacter        = "ai_character"
    public static let video              = "video"
    public static let videoAlt           = "video_alt"
    public static let videoCall          = "video_call"
    public static let groupList          = "group_list"
    public static let groupDetail        = "group_detail"
    public static let following          = "following"

    // MARK: - Profile

    public static let myProfile          = "my_profile"
    public static let userProfile        = "user_profile"
    public static let userProfileAlt     = "user_profile_alt"
    public static let userProfileAlt2    = "user_profile_alt2"
    public static let userProfileAlt3    = "user_profile_alt3"
    public static let editProfile        = "edit_profile"
    public static let wallet             = "wallet"
    public static let settings           = "settings"
    public static let blacklist          = "blacklist"
    public static let reportBlock        = "report_block"

    // MARK: - Mood Match / Bottle

    public static let moodMatch          = "mood_match"
    public static let moodMatching       = "mood_matching"
    public static let moodMatchResult    = "mood_match_result"
    public static let moodBottle         = "mood_bottle"

    // MARK: - Drawing / Dialog / Empty

    public static let drawingEmoji       = "drawing_emoji"
    public static let drawingCanvas      = "drawing_canvas"
    public static let drawingOptions     = "drawing_options"
    public static let dialog             = "dialog"
    public static let dialogAlt          = "dialog_alt"
    public static let empty              = "empty"

    // MARK: - Lookup table

    /// All image names. Used by tooling / sample previews to validate
    /// that every constant resolves to a file.
    public static let all: [String] = [
        splash, onboarding1, onboarding2, onboarding3, login, logo,
        home, communityFeed, communityFeedAlt, postDetail, publish, myPosts,
        messages, chat, aiChat, aiCharacter, video, videoAlt, videoCall,
        groupList, groupDetail, following,
        myProfile, userProfile, userProfileAlt, userProfileAlt2, userProfileAlt3,
        editProfile, wallet, settings, blacklist, reportBlock,
        moodMatch, moodMatching, moodMatchResult, moodBottle,
        drawingEmoji, drawingCanvas, drawingOptions,
        dialog, dialogAlt, empty
    ]
}
