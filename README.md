# Firework Flutter SDK

The integration guide is https://docs.firework.tv/flutter-sdk/integration-guide-v2

## How to run sample app

### Set up Firework app Id

 1. Get the Firework app ID from our business team.
 2. In `./FireworkFlutterSDKSample/ios/Runner/Info-Debug.plist` and `./FireworkFlutterSDKSample/ios/Runner/Info.plist`, set the value of `FireworkVideoAppID` key to the Firework app ID.
 3. In `./FireworkFlutterSDKSample/android/app/build.gradle`, set the value of `fw_appid_production` to the Firework app ID.

### Install dependencies

 1. `cd FireworkFlutterSDKSample`
 2. `flutter pub get`
 3. `pod install --project-directory=ios`

### Set up default shopping playlist(optional)
 1. Get the channel id and playlist id for the shopping playlist.
 2. In `./FireworkFlutterSDKSample/lib/assets/feed.json`, use the channel id and playlist id to update the value of `defaultShoppingPlaylist`
Besides that, you could also configure shopping playlist info by clicking the setting icon on the right side of the shopping page navigation bar.

### Run iOS sample app
 1. `cd FireworkFlutterSDKSample`
 2. open the iOS simulator and execute `flutter run` in terminal

### Run Android sample app
 1. `cd FireworkFlutterSDKSample`
 2. open the Android simulator and execute `flutter run` in terminal
