import Flutter
import UIKit

public class SwiftFireworktvLibAndroidPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.exemplo.app_flutter/firework_ios", binaryMessenger: registrar.messenger())
    let instance = SwiftFireworktvLibAndroidPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
