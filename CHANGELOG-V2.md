# CHANGELOG

## [2.0.2]

### Added

- Support configuring feed item spacing on the Android side

### Fixed

- Unable to start floating player programmatically in some cases

## [2.0.1]

### Changed

- Upgrade Firework Android SDK version to 6.3.1

## [2.0.0]

### Added

- Support Picture in Picture for video feed on the Android side(already supported on iOS)
- Support floating player for video feed on the Android side(already supported on iOS)
- Add the ability to programmatically start or stop the floating player
- Support app-level language setting
- Support hashtag playlist
- Support customizing shopping CTA button text to "Add to cart" or "Shop now"
- Support configuring the width of the CTA button
- Support play and pause function on `StoryBlock` widget
- Support story block configuration on the Android side
- Support hiding link button next to shopping CTA button
- Support customizing click handler of link button next to shopping CTA button
- Support passing `videoLaunchBehavior` in `FireworkSDK` class `init` method

### Changed

- Upgrade Firework Android SDK from V5 to V6
- Upgrade Firework iOS SDK to V1.10

### Breaking Changes

- Remove `launchBehavior` in `VideoPlayerConfiguration` class
- Remove `pushNativeContainer` method in `FWNavigator` class
- Remove `canPopNativeContainer` method in `FWNavigator` class
- Change `onAddToCart` callback to `onShoppingCTA` callback
- Remove `onWillDisplayProduct` callback in `VideoShopping` class

## [2.0.0-beta.1]

- Firework Flutter SDK beta release

## [1.5.0]

### Added

- Support Picture in Picture for story block(only supported on iOS)
- Support floating player(only supported on iOS)
- Support sharing and opening universal links(only supported on iOS)

## [1.4.1]

### Fixed

- The users are navigated to the trailer video when opening the share link of the active live stream on the Android side.
- Clicking the cart icon doesn't close the player when enabling the custom click cart icon callback on the iOS side

## [1.4.0]

### Added

- Multiple product pinning(only supported on iOS)
- Picture In Picture functionality(only supported on iOS)
- Purchase sale tracking API(only supported on iOS)
- Custom VAST attributes support(only supported on iOS)
- In feed ad support(only supported on iOS)
- Support for story block(only supported on iOS)

## [1.3.0]

### Added

- Support for Flutter 3

### Fixed

- Hydration API doesn't work in the release package when setting `minifyEnabled` to `true`


## [1.2.0]

### Added

- Support for RTL and Arabic translations
- Support for autoplay video in thumbnails
- Add `imageUrl` and `options` to `ProductUnit` class
- Add `gridColumns` to `VideoFeedConfiguration` class
- Add `onCustomClickCartIcon` callback in `VideoShopping` class

## [1.2.0-beta.5]

- Firework Flutter SDK beta release

## [1.2.0-beta.4]

- Firework Flutter SDK beta release

## [1.2.0-beta.3]

- Firework Flutter SDK beta release

## [1.2.0-beta.2]

- Firework Flutter SDK beta release

## [1.2.0-beta.1]

- Firework Flutter SDK beta release

## [1.1.3]

### Added

- Add `showBranding` property in `VideoPlayerConfiguration` class

## [1.1.2]

### Added

- Add new properties in `VideoFeedConfiguration` class

## [1.1.1]

### Added

- Add `canPopNativeContainer` method in `FWNavigator` class
- Add new properties in `FeedItemDetails` class

### Changed

- `popNativeContainer` method also can pop the video or live stream player

## [1.1.0]

### Added

- Add a new video feed source: `dynamicContent`
- Support for navigating from native page to Flutter page

### Breaking Changes

- Remove `AdConfig` class 
- Remove `adConfig` parameter from `init` method of `FireworkSDK` class
- Remove `exitCartPage` method from `VideoShopping` classs

## [1.1.0-beta.1]

- Firework Flutter SDK beta release

## [1.0.0]

### Added

- Support SDK initialization and global configuration
- Add `VideoFeed` widget
- Support video and live stream playback
- Support video and live stream event callbacks
- Support video and live stream shopping
- Ad support

## [1.0.0-beta.1]

- Firework Flutter SDK beta release
