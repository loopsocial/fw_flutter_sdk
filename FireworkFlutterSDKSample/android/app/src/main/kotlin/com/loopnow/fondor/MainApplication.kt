package com.loopnow.fondor

import com.firework.livestream.multihost.MultiHostLivestreamPlayerInitializer
import com.firework.livestream.singlehost.SingleHostLivestreamPlayerInitializer
import com.fireworksdk.bridge.flutter.FWFlutterSDK
import com.fireworksdk.bridge.models.FWSDKInitOptionsModel
import com.fireworksdk.bridge.models.enums.FWPlayerLaunchBehavior
import io.flutter.app.FlutterApplication

class MainApplication: FlutterApplication() {

  override fun onCreate() {
    super.onCreate()

    FWFlutterSDK.addLivestreamPlayerInitializer(SingleHostLivestreamPlayerInitializer())
    FWFlutterSDK.addLivestreamPlayerInitializer(MultiHostLivestreamPlayerInitializer())

    FWFlutterSDK.init(
      this,
      FWSDKInitOptionsModel(videoLaunchBehavior = FWPlayerLaunchBehavior.MuteOnFirstLaunch)
    )
  }
}