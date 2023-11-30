import UIKit
import Flutter
// import FireworkVideoIVSSupport
import FireworkVideo
import fw_flutter_sdk

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
//        FireworkVideoSDK.enableIVSPlayback()
        // Used to connect plugins
        GeneratedPluginRegistrant.register(with: self)
        FWFlutterSDK.initializeSDK(SDKInitOptions(videoLaunchBehavior: .muteOnFirstLaunch))
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
