package com.loopnow.fondor

import android.content.Context
import android.os.Bundle
import com.fireworksdk.bridge.flutter.FireworkFlutterSdkPlugin
import com.fireworksdk.bridge.flutter.models.FWFlutterFragmentDelegate
import io.flutter.FlutterInjector
import io.flutter.embedding.android.FlutterFragment
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class MainActivity: FlutterFragmentActivity(), FWFlutterFragmentDelegate {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        preWarmedEngineCart(this)
        FireworkFlutterSdkPlugin.flutterFragmentDelegate = this
    }

    // create and run a FlutterEngine for embed cart page
    private fun preWarmedEngineCart(context: Context) {

        var flutterEngine = FlutterEngineCache.getInstance().get(FW_ENGINE_CACHE_CART)

        if (flutterEngine == null) {
            flutterEngine = FlutterEngine(context)
            // set custom initial route.
            flutterEngine.navigationChannel.setInitialRoute("embed_cart");
            flutterEngine.dartExecutor.executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
            )

            FlutterEngineCache
                .getInstance()
                .put(FW_ENGINE_CACHE_CART, flutterEngine)
        }
    }

    private fun createFragment(): FlutterFragment {
        return FlutterFragment
            .withCachedEngine(FW_ENGINE_CACHE_CART)
            .build<FlutterFragment>()
    }

    // return a FlutterFragment instance
    override val flutterFragment: FlutterFragment?
        get() = createFragment()

    companion object {
        const val FW_ENGINE_CACHE_CART = "fw.fondor_example.embed_cart_engine"
    }
}
