import 'dart:ui';

import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/routes.dart';
import 'package:fw_flutter_sdk_example/states/feed_configuration_state.dart';
import 'package:fw_flutter_sdk_example/states/player_configuration_state.dart';
import 'package:fw_flutter_sdk_example/states/tab_index_state.dart';
import 'package:fw_flutter_sdk_example/utils/fw_example_logger_util.dart';
import 'package:fw_flutter_sdk_example/utils/host_app_shopping_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'extensions/fw_events_extensions.dart';
import 'generated/l10n.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    _registerCallbacks();
    FWExampleLoggerUtil.log(
        "window.defaultRouteName ${window.defaultRouteName}");
    if (window.defaultRouteName == "/") {
      FireworkSDK.getInstance().init();
    }
  }

  void _registerCallbacks() {
    FireworkSDK.getInstance().onSDKInit = (event) {
      event.logMessage();
    };

    // FireworkSDK.getInstance().onCustomCTAClick = (event) {
    //   event?.logMessage();
    // };

    // FireworkSDK.getInstance().onVideoPlayback = (event) {
    //   event?.logMessage();
    // };

    FireworkSDK.getInstance().onVideoFeedClick = (event) {
      event?.logMessage();
    };

    FireworkSDK.getInstance().shopping.onAddToCart =
        HostAppShoppingService.getInstance().onAddToCart;
    FireworkSDK.getInstance().shopping.onUpdateProductDetails =
        HostAppShoppingService.getInstance().onUpdateProductDetails;
    FireworkSDK.getInstance().shopping.onWillDisplayProduct =
        HostAppShoppingService.getInstance().onWillDisplayProduct;

    FireworkSDK.getInstance().liveStream.onLiveStreamEvent = (event) {
      event?.logMessage();
    };

    FireworkSDK.getInstance().liveStream.onLiveStreamChatEvent = (event) {
      event?.logMessage();
    };
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FeedConfigurationState(),
        ),
        ChangeNotifierProvider(
          create: (_) => PlayerConfigurationState(),
        ),
        ChangeNotifierProvider.value(
          value: HostAppShoppingService.getInstance().configState,
        ),
        ChangeNotifierProvider(
          create: (_) => TabIndexState(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        onGenerateRoute: (RouteSettings settings) {
          final factory = routeMap[settings.name];
          return factory?.call(settings);
        },
        builder: EasyLoading.init(),
      ),
    );
  }
}
