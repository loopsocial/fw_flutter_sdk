# fireworktv_lib_android

A new flutter plugin project.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Configure Android Side
    * Follow this tutorial to get the Android SDK configuration: https://github.com/loopsocial/firework_sdk_official
    * Then create in your layout folder a file named firework.xml:

# Adding the layout
    ``` xml
        <?xml version="1.0" encoding="utf-8"?>
            <androidx.coordinatorlayout.widget.CoordinatorLayout xmlns:android="http://schemas.android.com/apk/res/android"
                xmlns:app="http://schemas.android.com/apk/res-auto"
                xmlns:tools="http://schemas.android.com/tools"
                android:layout_width="match_parent"
                android:layout_height="match_parent"
                tools:context=".MainActivity">

                <com.loopnow.fireworklibrary.views.VideoFeedView
                    android:layout_width="match_parent"
                    android:layout_height="match_parent"
                    app:showTitle="true"
                    app:feedLayout="grid"
                    app:columns="3"
                /> 
        </androidx.coordinatorlayout.widget.CoordinatorLayout>
    ```

# Main Activity Bind
    Add this in the MainActivity.kt

    ``` kotlin
        import androidx.annotation.NonNull
        import io.flutter.embedding.engine.plugins.FlutterPlugin
        import io.flutter.plugin.common.MethodCall
        import io.flutter.plugin.common.MethodChannel
        import io.flutter.plugin.common.MethodChannel.MethodCallHandler
        import io.flutter.plugin.common.MethodChannel.Result
        import io.flutter.plugin.common.PluginRegistry.Registrar
        import io.flutter.embedding.android.FlutterActivity
        import io.flutter.embedding.engine.FlutterEngine
        import android.content.Context
        import android.content.ContextWrapper
        import android.content.Intent
        import android.content.IntentFilter
        import android.os.BatteryManager
        import android.os.Build.VERSION
        import android.os.Build.VERSION_CODES

        private val CHANNEL = "com.exemplo.app_flutter/firework"

        override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
            super.configureFlutterEngine(flutterEngine)
            MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
                if (call.method == "getFirework") {
                    setContentView(R.layout.firework);
                }
            }
        }
    ```

# Configure iOS Side
    * Follow this tutorial to get the iOS SDK configuration: https://github.com/loopsocial/firework_ios_sdk
    * Then create in your App folder a file named ViewController.swift and add the following:

# Adding the layout
    Create a ViewController then add the following code:

    ``` swift
        import UIKit
        import FireworkVideo

        class ViewController: FlutterViewController {

            override func viewDidLoad() {
                super.viewDidLoad()
                pushFeedOnNavigationController()
            }

            func pushFeedOnNavigationController() {
                let gridVC = VideoFeedViewController()
                gridVC.view.backgroundColor = .systemBackground
                let layout = VideoFeedGridLayout()
                layout.numberOfColumns = 3
                layout.contentInsets = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
                gridVC.layout = layout
                var config = gridVC.viewConfiguration
                config.backgroundColor = .white
                gridVC.viewConfiguration.playerView.videoCompleteAction = .loop
                gridVC.viewConfiguration = config
                self.navigationController?.pushViewController(gridVC, animated: true)
            }

        }
    ```

# AppDelegate lib configuration
    Add this in the AppDelegate.swift

    ``` swift
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
    ```

# Dart code
    in your main.dart add this to run the SDK

    ```dart
        await FireworkLib.getFirework;
    ```
