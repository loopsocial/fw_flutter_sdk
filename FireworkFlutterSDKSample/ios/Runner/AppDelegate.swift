import UIKit
import Flutter
import FireworkVideoIVSSupport
import FireworkVideo
import fw_flutter_sdk
import FirebaseCore
import AppTrackingTransparency

@UIApplicationMain
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.requestIDFAPermision()
        }
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func requestIDFAPermision() {
        if #available(iOS 14.5, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    debugPrint("ATT permission authorized")
                case .denied:
                    debugPrint("ATT permission denied")
                case .notDetermined:
                    debugPrint("ATT permission notDetermined")
                case .restricted:
                    debugPrint("ATT permission restricted")
                @unknown default:
                    break
                }
            }
        } else {}
    }
}

fileprivate extension String {
    var urlEncoded: String? {
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: "-._~/?")
        return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
    }
}
