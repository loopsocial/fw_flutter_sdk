import UIKit
import Flutter
import FireworkVideo

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, FireworkVideoSDKDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let nav_controller: UINavigationController = window?.rootViewController as! UINavigationController
    let root_controller : FlutterViewController = nav_controller.viewControllers[0] as! FlutterViewController
    
    let channel = FlutterMethodChannel(name: "com.exemplo.app_flutter/firework_ios", binaryMessenger: root_controller.binaryMessenger)

    channel.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        // Note: this method is invoked on the UI thread.
        // Handle battery messages.
        FireworkVideoSDK.initializeSDK(delegate: self)
        result("1")
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
  func fireworkVideoDidLoadSuccessfully() {
    print("FireworkVideo loaded successfully.")
  }

  func fireworkVideoDidLoadWith(error: FireworkVideoSDKError) {
    switch error {
    case .missingAppID:
        print("FireworkVideo loaded with error due to missing app ID.")
    case .authenticationFailure:
        print("FireworkVideo loaded with error due to authentication failure.")
    default:
        break
    }
  }
}
