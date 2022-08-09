package com.loopnow.fondor

import android.app.Activity
import android.content.Context
import android.os.Bundle
import com.fireworksdk.bridge.flutter.FireworkFlutterSdkPlugin
import com.fireworksdk.bridge.flutter.models.FWFlutterFragmentDelegate
import com.fireworksdk.bridge.utils.FWGsonUtil
import io.flutter.embedding.android.FlutterFragment
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.FlutterEngineGroup
import java.net.URLEncoder

class MainActivity: FlutterFragmentActivity() {
    lateinit var engines: FlutterEngineGroup

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        engines = FlutterEngineGroup(this)

        // cart page
        preWarmedEngineCart(this)
        setCartFragment()

        // container page
        setContainerFragment()
    }

    // create and run a FlutterEngine for embed cart page
    private fun preWarmedEngineCart(context: Context) {

        var flutterEngine = FlutterEngineCache.getInstance().get(FW_ENGINE_CACHE_CART)

        if (flutterEngine == null) {
            // Adding new_native_container(or any other custom prefix without "/") could avoid rendering the screen whose route name is "/" in the new engine.
            val link = "new_native_container/cart"
            flutterEngine = engines.createAndRunEngine(context, null, link)

            FlutterEngineCache
                .getInstance()
                .put(FW_ENGINE_CACHE_CART, flutterEngine)
        }
    }

    private fun setCartFragment() {
        FireworkFlutterSdkPlugin.cartFragmentDelegate = object : FWFlutterFragmentDelegate {

            override fun getFragment(activity: Activity, map: Map<String, Any?>?): FlutterFragment {

                return FlutterFragment
                    .withCachedEngine(FW_ENGINE_CACHE_CART)
                    .build<FlutterFragment>()
            }
        }
    }

    // create and run a FlutterEngine for container page
    private fun createEngineContainer(activity: Activity, initialRoute: String) {

        // create engine
//        val flutterEngine = FlutterEngine(activity)
//
//        flutterEngine.navigationChannel.setInitialRoute(link);
//        flutterEngine.dartExecutor.executeDartEntrypoint(
//            DartExecutor.DartEntrypoint.createDefault()
//        )

        //  FlutterEngineGroup
        val flutterEngine = engines.createAndRunEngine(activity, null, initialRoute)

        FlutterEngineCache
            .getInstance()
            .put(FW_ENGINE_CACHE_CONTAINER, flutterEngine)
    }

    private fun setContainerFragment() {

        FireworkFlutterSdkPlugin.containerFragmentDelegate = object : FWFlutterFragmentDelegate {

            override fun getFragment(
                activity: Activity,
                map: Map<String, Any?>?
            ): FlutterFragment? {

                if (map.isNullOrEmpty()) {
                    return null
                }

                val pageName = map["pageName"] as String
                val parameters = map["parameters"] as Map<String, String>
                val encodeParameters = URLEncoder.encode(FWGsonUtil.toJson(parameters), "UTF-8")
                val initialRoute = "${pageName}?parameters=${encodeParameters}"

                createEngineContainer(activity, initialRoute)

                return FlutterFragment
                    .withCachedEngine(FW_ENGINE_CACHE_CONTAINER)
                    .build()
            }
        }
    }

    companion object {
        const val FW_ENGINE_CACHE_CART = "fw.fondor_example.cart_engine"

        const val FW_ENGINE_CACHE_CONTAINER = "fw.fondor_example.container_engine"
    }
}
