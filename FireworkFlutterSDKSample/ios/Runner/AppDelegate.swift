import UIKit
import Flutter
import fw_flutter_sdk

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Used to connect plugins
        GeneratedPluginRegistrant.register(with: self)
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
