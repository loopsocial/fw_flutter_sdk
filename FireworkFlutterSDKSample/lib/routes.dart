import 'package:fw_flutter_sdk_example/screens/cart/check_out_screen.dart';
import 'package:fw_flutter_sdk_example/screens/cart/embed_cart_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/ad_badge_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/cart_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/channel_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/feed_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/player_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/playlist_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/playlist_group_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/feed/feed_screen.dart';
import 'package:fw_flutter_sdk_example/screens/more/open_video_screen.dart';
import 'package:fw_flutter_sdk_example/screens/more/set_share_base_url_screen.dart';
import 'package:fw_flutter_sdk_example/screens/tab/tab_screen.dart';
import 'package:flutter/material.dart';

final routeMap = <String, RouteFactory>{
  '/': (setting) {
    return MaterialPageRoute(
      builder: (context) => const TabScreen(),
    );
  },
  '/feed': (setting) {
    return MaterialPageRoute(
      builder: (context) => FeedScreen(
        settings: setting,
      ),
    );
  },
  '/feed_configuration': (setting) {
    return MaterialPageRoute(
      builder: (context) => const FeedConfigurationScreen(),
    );
  },
  '/player_configuration': (setting) {
    return MaterialPageRoute(
      builder: (context) => const PlayerConfigurationScreen(),
    );
  },
  '/channel_configuration': (setting) {
    return MaterialPageRoute(
      builder: (context) => const ChannelConfigurationScreen(),
    );
  },
  '/playlist_configuration': (setting) {
    return MaterialPageRoute(
      builder: (context) => const PlaylistConfigurationScreen(),
    );
  },
  '/playlist_group_configuration': (setting) {
    return MaterialPageRoute(
      builder: (context) => const PlaylistGroupConfigurationScreen(),
    );
  },
  '/open_video_url': (setting) {
    return MaterialPageRoute(
      builder: (context) => const OpenVideoScreen(),
    );
  },
  '/set_share_base_url': (setting) {
    return MaterialPageRoute(
      builder: (context) => const SetShareBaseURLScreen(),
    );
  },
  '/cart_configuration': (setting) {
    return MaterialPageRoute(
      builder: (context) => const CartConfigurationScreen(),
    );
  },
  '/checkout': (setting) {
    return MaterialPageRoute(
      builder: (context) => const CheckoutScreen(),
    );
  },
  '/set_ad_badge_configuration': (setting) {
    return MaterialPageRoute(
      builder: (context) => const AdBadgeConfigurationScreen(),
    );
  },
  'embed_cart': (setting) {
    return MaterialPageRoute(
      builder: (context) => const EmbedCartScreen(),
    );
  },
};
