import UIKit
import Flutter
import FireworkVideoIVSSupport
import FireworkVideo
import fw_flutter_sdk
import FirebaseCore
import AppTrackingTransparency

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()
        FireworkVideoSDK.enableIVSPlayback()
        // Used to connect plugins
        GeneratedPluginRegistrant.register(with: self)
        FWFlutterSDK.initializeSDK(SDKInitOptions(videoLaunchBehavior: .muteOnFirstLaunch))
        // Debug-only: swizzles UIViewController lifecycle methods to log when
        // Firework-related view controllers appear/disappear. This is purely a
        // debugging aid for the example app — host apps do NOT need to call this.
        UIViewController.swizzleFireworkLifecycleLogging()
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

fileprivate extension String {
    var urlEncoded: String? {
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: "-._~/?")
        return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
    }
}
