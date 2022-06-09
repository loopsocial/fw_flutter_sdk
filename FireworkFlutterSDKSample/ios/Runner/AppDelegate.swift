import UIKit
import Flutter
import fw_flutter_sdk

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    lazy var engineGroup = FlutterEngineGroup(name: "fw.fondor_example.engine_group", project: nil)

    // The flutter engine for embed cart page
    lazy var embedCartEngine: FlutterEngine = {
        // make a flutter engine with custom initial route
        let engine = engineGroup.makeEngine(
            withEntrypoint: nil,
            libraryURI: nil,
            // Adding new_native_container(or any other custom prefix without "/") could avoid rendering the screen whose route name is "/" in the new engine.
            initialRoute: "new_native_container/cart"
        )
        return engine
    }()

    override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Used to connect plugins
        GeneratedPluginRegistrant.register(with: self)

        // Used to connect plugins
        GeneratedPluginRegistrant.register(with: self.embedCartEngine)
        SwiftFireworkFlutterSdkPlugin.customCartPageProvider = {
            // return a FlutterViewController instance
            return FlutterViewController(engine: self.embedCartEngine, nibName: nil, bundle: nil)
        }

        SwiftFireworkFlutterSdkPlugin.navigatorPageProvider = {
            [weak self] arguments in
            guard let self = self else {
                return nil
            }

            guard let args = arguments,
               let pageName = args["pageName"] as? String else {
                return nil
            }
            var initialRoute = pageName
            if let parameters = args["parameters"] as? Dictionary<String, Any>,
               let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted),
               let jsonString = String(data: jsonData, encoding: .utf8),
               let encodedJsonString = jsonString.urlEncoded {
                initialRoute = "\(pageName)?parameters=\(encodedJsonString)"
            }
            // make a flutter engine with custom initial route
            let engine = self.engineGroup.makeEngine(withEntrypoint: nil, libraryURI: nil, initialRoute: initialRoute)
            // Used to connect plugins
            GeneratedPluginRegistrant.register(with: engine)
            let flutterVC = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
            return flutterVC
        }

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
