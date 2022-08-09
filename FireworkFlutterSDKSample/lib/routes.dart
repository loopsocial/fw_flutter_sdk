import 'package:fw_flutter_sdk_example/screens/cart/cart_screen.dart';
import 'package:fw_flutter_sdk_example/screens/cart/check_out_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/ad_badge_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/cart_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/channel_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/dynamic_content_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/feed_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/player_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/playlist_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/playlist_group_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/cta_link_content/cta_link_content_screen.dart';
import 'package:fw_flutter_sdk_example/screens/feed/feed_screen.dart';
import 'package:fw_flutter_sdk_example/screens/more/circle_thumbnails.dart';
import 'package:fw_flutter_sdk_example/screens/more/enable_custom_click_cart_icon_callback_screen.dart';
import 'package:fw_flutter_sdk_example/screens/more/enable_custom_cta_click_callback_screen.dart';
import 'package:fw_flutter_sdk_example/screens/more/open_video_screen.dart';
import 'package:fw_flutter_sdk_example/screens/more/set_share_base_url_screen.dart';
import 'package:fw_flutter_sdk_example/screens/tab/tab_screen.dart';
import 'package:flutter/material.dart';

typedef FWRouteFactory = Route<dynamic>? Function(
    RouteSettings settings, bool isNewContainer);

final routeMap = <String, FWRouteFactory>{
  '/': (settings, isNewContainer) {
    return MaterialPageRoute(
      builder: (context) => const TabScreen(),
    );
  },
  '/feed': (settings, isNewContainer) {
    return MaterialPageRoute(
      builder: (context) => FeedScreen(
        settings: settings,
      ),
    );
  },
  '/feed_configuration': (settings, isNewContainer) {
    return MaterialPageRoute(
      builder: (context) => const FeedConfigurationScreen(),
    );
  },
  '/player_configuration': (settings, isNewContainer) {
    return MaterialPageRoute(
      builder: (context) => const PlayerConfigurationScreen(),
    );
  },
  '/channel_configuration': (settings, isNewContainer) {
    return MaterialPageRoute(
      builder: (context) => const ChannelConfigurationScreen(),
    );
  },
  '/playlist_configuration': (settings, isNewContainer) {
    return MaterialPageRoute(
      builder: (context) => const PlaylistConfigurationScreen(),
    );
  },
  '/playlist_group_configuration': (settings, isNewContainer) {
    return MaterialPageRoute(
      builder: (context) => const PlaylistGroupConfigurationScreen(),
    );
  },
  '/dynamic_content_configuration': (settings, isNewContainer) {
    return MaterialPageRoute(
      builder: (context) => const DynamicContentConfigurationScreen(),
    );
  },
  '/open_video_url': (settings, isNewContainer) {
    return MaterialPageRoute(
      builder: (context) => const OpenVideoScreen(),
    );
  },
  '/set_share_base_url': (settings, isNewContainer) {
    return MaterialPageRoute(
      builder: (context) => const SetShareBaseURLScreen(),
    );
  },
  '/cart_configuration': (settings, isNewContainer) {
    return MaterialPageRoute(
      builder: (context) => const CartConfigurationScreen(),
    );
  },
  '/checkout': (settings, isNewContainer) {
    return MaterialPageRoute(
      builder: (context) => const CheckoutScreen(),
    );
  },
  '/set_ad_badge_configuration': (settings, isNewContainer) {
    return MaterialPageRoute(
      builder: (context) => const AdBadgeConfigurationScreen(),
    );
  },
  '/enable_custom_cta_click_callback': (settings, isNewContainer) {
    return MaterialPageRoute(
      builder: (context) => const EnableCustomCTAClickCallbackScreen(),
    );
  },
  '/cart': (settings, isNewContainer) {
    return MaterialPageRoute(
      builder: (context) => CartScreen(
        isNewContainer:
            isNewContainer, // we need to handle isNewContainer if the screen can be embeded in new container
      ),
    );
  },
  '/cta_link_content': (settings, isNewContainer) {
    return MaterialPageRoute(
      builder: (context) => CTALinkContentScreen(
        settings: settings,
        isNewContainer:
            isNewContainer, // we need to handle isNewContainer if the screen can be embeded in new container
      ),
    );
  },
  '/circle_thumbnails': (settings, isNewContainer) {
    return MaterialPageRoute(
      builder: (context) => const CircleThumbnails(),
    );
  },
  '/enable_custom_click_cart_icon_callback_screen': (settings, isNewContainer) {
    return MaterialPageRoute(
      builder: (context) => const EnableCustomClickCartIconCallbackScreen(),
    );
  },
};
