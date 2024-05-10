package com.loopnow.fondor

import android.content.Context
import com.firework.imageloading.glide.GlideImageLoaderFactory
import com.firework.livestream.multihost.MultiHostLivestreamPlayerInitializer
import com.firework.livestream.singlehost.SingleHostLivestreamPlayerInitializer
import com.fireworksdk.bridge.flutter.FWFlutterSDK
import com.fireworksdk.bridge.models.FWSDKInitOptionsModel
import com.fireworksdk.bridge.models.enums.FWPlayerLaunchBehavior
import com.fireworksdk.bridge.models.enums.FWSwitchLanguageBehavior
import io.flutter.app.FlutterApplication

class MainApplication: FlutterApplication() {

  override fun onCreate() {
    super.onCreate()

    FWFlutterSDK.addLivestreamPlayerInitializer(SingleHostLivestreamPlayerInitializer())
//    FWFlutterSDK.addLivestreamPlayerInitializer(MultiHostLivestreamPlayerInitializer())

    FWFlutterSDK.setImageLoader(GlideImageLoaderFactory.createInstance(this))
    FWFlutterSDK.setLanguageSwitchingBehavior(FWSwitchLanguageBehavior.NotRestartingActivity)
    FWFlutterSDK.init(
      this,
      FWSDKInitOptionsModel(videoLaunchBehavior = FWPlayerLaunchBehavior.MuteOnFirstLaunch)
    )
  }

  override fun attachBaseContext(base: Context) {
    super.attachBaseContext(FWFlutterSDK.updateBaseContextLocale(base))
  }
}