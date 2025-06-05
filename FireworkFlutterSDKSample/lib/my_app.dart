import 'dart:async';

import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/models/app_language_info.dart';
import 'package:fw_flutter_sdk_example/routes.dart';
import 'package:fw_flutter_sdk_example/states/feed_configuration_state.dart';
import 'package:fw_flutter_sdk_example/states/player_configuration_state.dart';
import 'package:fw_flutter_sdk_example/states/story_block_configuration_state.dart';
import 'package:fw_flutter_sdk_example/utils/fw_example_logger_util.dart';
import 'package:fw_flutter_sdk_example/utils/host_app_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'constants/fw_example_event_name.dart';
import 'extensions/fw_events_extensions.dart';
import 'generated/l10n.dart';

final GlobalKey<NavigatorState> globalNavigatorKey =
    GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppLanguageInfo? _appLanguageInfo;
  StreamSubscription? _appLanguageUpdateEventSubscription;

  @override
  void dispose() {
    _appLanguageUpdateEventSubscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _registerCallbacks();
    FireworkSDK.getInstance().adBadgeConfiguration =
        AdBadgeConfiguration(badgeTextType: AdBadgeTextType.ad);
    FireworkSDK.getInstance().shopping.cartIconVisible = true;
    FireworkSDK.getInstance().markInitCalled();

    _appLanguageUpdateEventSubscription =
        FWEventBus.getInstance().on().listen((event) {
      FWExampleLoggerUtil.log(
          "_MyAppState eventName ${event.eventName} event.arguments ${event.arguments}");
      if (event.eventName == FWExampleEventName.appLanguageUpdateEvent &&
          event.arguments is Map<dynamic, dynamic> &&
          mounted) {
        final appLanguageInfoJson =
            Map<String, dynamic>.from(event.arguments as Map<dynamic, dynamic>);
        setState(() {
          _appLanguageInfo = AppLanguageInfo.fromJson(appLanguageInfoJson);
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      HostAppService.getInstance()
          .getCacheAppLanguageInfo()
          .then((appLanguageInfo) {
        if (mounted) {
          setState(() {
            _appLanguageInfo = appLanguageInfo;
          });
          FireworkSDK.getInstance().changeAppLanguage(
            appLanguageInfo.languageCode,
          );
        }
      });
      HostAppService.getInstance().getCacheDataTrackingLevel().then((value) {
        if (value != null) {
          FireworkSDK.getInstance().dataTrackingLevel = value;
        }
      });
      HostAppService.getInstance().getLivestreamPlayerVersion().then((value) {
        if (value != null) {
          FireworkSDK.getInstance().livestreamPlayerDesignVersion = value;
        }
      });
    });
  }

  void _registerCallbacks() {
    FireworkSDK.getInstance().debugLogsEnabled = true;

    FireworkSDK.getInstance().onSDKInit = (event) {
      event.logMessage();
    };
    FireworkSDK.getInstance().onCustomCTAClick =
        HostAppService.getInstance().onCustomCTAClick;

    FireworkSDK.getInstance().onVideoPlayback =
        HostAppService.getInstance().onVideoPlayback;

    FireworkSDK.getInstance().onInteractableEngagement =
        HostAppService.getInstance().onInteractableEngagement;

    // FireworkSDK.getInstance().onVideoFeedClick =
    //     HostAppService.getInstance().onVideoFeedClick;

    FireworkSDK.getInstance().shopping.onShoppingCTA =
        HostAppService.getInstance().onShopNow;
    FireworkSDK.getInstance().shopping.onUpdateProductDetails =
        HostAppService.getInstance().onUpdateProductDetails;
    FireworkSDK.getInstance().shopping.onCustomClickCartIcon =
        HostAppService.getInstance().onCustomClickCartIcon;
    FireworkSDK.getInstance().shopping.onClickProduct =
        HostAppService.getInstance().onClickProduct;
    FireworkSDK.getInstance().shopping.productInfoViewConfiguration =
        ProductInfoViewConfiguration(
      ctaButton: ShoppingCTAButtonConfiguration(
        text: ShoppingCTAButtonText.shopNow,
      ),
    );

    FireworkSDK.getInstance().liveStream.onLiveStreamEvent =
        HostAppService.getInstance().onLiveStreamEvent;

    FireworkSDK.getInstance().liveStream.onLiveStreamChatEvent =
        HostAppService.getInstance().onLiveStreamChatEvent;

    FireworkSDK.getInstance().shopping.onCustomClickLinkButton =
        HostAppService.getInstance().onCustomClickLinkButton;
    FireworkSDK.getInstance().onCustomShareUrl =
        HostAppService.getInstance().onCustomShareUrl;
  }

  @override
  Widget build(BuildContext context) {
    final langauge = _appLanguageInfo?.languageCode;
    Locale? locale;
    if (langauge != null) {
      final languageComponents = langauge.split("-");
      FWExampleLoggerUtil.log("languageComponents $languageComponents");
      if (languageComponents.length > 1) {
        locale = Locale(languageComponents[0], languageComponents[1]);
      } else if (languageComponents.isNotEmpty) {
        locale = Locale(languageComponents[0]);
      }
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FeedConfigurationState(),
        ),
        ChangeNotifierProvider(
          create: (_) => PlayerConfigurationState(),
        ),
        ChangeNotifierProvider(
          create: (_) => StoryBlockConfigurationState(),
        ),
      ],
      child: MaterialApp(
        locale: locale,
        navigatorKey: globalNavigatorKey,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        onGenerateRoute: (RouteSettings settings) {
          if (settings.name != null) {
            FWExampleLoggerUtil.log(
                "onGenerateRoute settings.name ${settings.name}");
            final uri = Uri.parse(settings.name!);
            final pageName = uri.path;
            FWExampleLoggerUtil.log("pageName $pageName");
            final factory = routeMap[pageName];
            return factory?.call(settings);
          }

          return null;
        },
        builder: EasyLoading.init(),
      ),
    );
  }
}
