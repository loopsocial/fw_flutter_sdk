package com.loopnow.fondor

import android.content.Context
import com.fireworksdk.bridge.flutter.FWFlutterSDK
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {

  override fun attachBaseContext(newBase: Context) {
    super.attachBaseContext(FWFlutterSDK.updateBaseContextLocale(newBase))
  }

  override fun onDestroy() {
    super.onDestroy()
    // for android 11
    FWFlutterSDK.closePip()
  }
}
