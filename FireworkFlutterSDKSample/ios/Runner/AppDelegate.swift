import UIKit
import Flutter
import FireworkVideoIVSSupport
import FireworkVideo
import fw_flutter_sdk
import FirebaseCore
import AppTrackingTransparency

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
    override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()
        FireworkVideoSDK.enableIVSPlayback()
        // Debug-only: swizzles UIViewController lifecycle methods to log when
        // Firework-related view controllers appear/disappear. This is purely a
        // debugging aid for the example app — host apps do NOT need to call this.
        UIViewController.swizzleFireworkLifecycleLogging()
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
        GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
        FWFlutterSDK.initializeSDK(SDKInitOptions(videoLaunchBehavior: .muteOnFirstLaunch))
    }
}

fileprivate extension String {
    var urlEncoded: String? {
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: "-._~/?")
        return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
    }
}
