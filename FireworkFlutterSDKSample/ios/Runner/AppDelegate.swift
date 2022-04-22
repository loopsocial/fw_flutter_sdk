import UIKit
import Flutter
import fw_flutter_sdk

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    // The flutter engine for embed cart page
    lazy var embedCartEngine: FlutterEngine = {
        let engine = FlutterEngine(name: "fw.fondor_example.embed_cart_engine")
        return engine
    }()

    override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        // setup embed cart engine
        setupEmbedCartEngine()
        SwiftFireworkFlutterSdkPlugin.customCartPageProvdier = {
            // return a FlutterViewController instance
            return FlutterViewController(engine: self.embedCartEngine, nibName: nil, bundle: nil)
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func setupEmbedCartEngine() {
        // run flutter engine with custom initial route.
        self.embedCartEngine.run(withEntrypoint: nil, libraryURI: nil, initialRoute: "embed_cart")
        // Used to connect plugins
        GeneratedPluginRegistrant.register(with: self.embedCartEngine)
    }
}
