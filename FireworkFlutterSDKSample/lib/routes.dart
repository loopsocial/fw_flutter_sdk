import 'package:flutter/material.dart';
import 'package:fw_flutter_sdk_example/screens/cart/cart_screen.dart';
import 'package:fw_flutter_sdk_example/screens/cart/check_out_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/ad_badge_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/channel_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/dynamic_content_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/feed_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/hashtag_playlist_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/player_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/playlist_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/playlist_group_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/shopping_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/single_content_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/sku_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/configuration/story_block_configuration_screen.dart';
import 'package:fw_flutter_sdk_example/screens/link_content/link_content_screen.dart';
import 'package:fw_flutter_sdk_example/screens/feed/feed_screen.dart';
import 'package:fw_flutter_sdk_example/screens/log/log_screen.dart';
import 'package:fw_flutter_sdk_example/screens/more/circle_thumbnails.dart';
import 'package:fw_flutter_sdk_example/screens/more/enable_custom_cta_click_callback_screen.dart';
import 'package:fw_flutter_sdk_example/screens/more/enable_custom_share_url_callback_screen.dart';
import 'package:fw_flutter_sdk_example/screens/more/enable_custom_share_url_screen.dart';
import 'package:fw_flutter_sdk_example/screens/more/enable_link_interaction_click_callback_screen.dart';
import 'package:fw_flutter_sdk_example/screens/more/enable_giveaway_terms_click_callback_screen.dart';
import 'package:fw_flutter_sdk_example/screens/more/enable_on_video_playback_log.dart';
import 'package:fw_flutter_sdk_example/screens/more/enter_video_id_screen.dart';
import 'package:fw_flutter_sdk_example/screens/more/open_video_screen.dart';
import 'package:fw_flutter_sdk_example/screens/more/set_share_base_url_screen.dart';
import 'package:fw_flutter_sdk_example/screens/more/open_story_block_video_screen.dart';
import 'package:fw_flutter_sdk_example/screens/tab/tab_screen.dart';

typedef FWRouteFactory = Route<dynamic>? Function(RouteSettings settings);

final routeMap = <String, FWRouteFactory>{
  '/': (settings) {
    return MaterialPageRoute(
      builder: (context) => const TabScreen(),
    );
  },
  '/feed': (settings) {
    return MaterialPageRoute(
      builder: (context) => FeedScreen(
        settings: settings,
      ),
    );
  },
  '/feed_configuration': (settings) {
    return MaterialPageRoute(
      builder: (context) => const FeedConfigurationScreen(),
    );
  },
  '/player_configuration': (settings) {
    return MaterialPageRoute(
      builder: (context) => const PlayerConfigurationScreen(),
    );
  },
  '/channel_configuration': (settings) {
    return MaterialPageRoute(
      builder: (context) => const ChannelConfigurationScreen(),
    );
  },
  '/playlist_configuration': (settings) {
    return MaterialPageRoute(
      builder: (context) => const PlaylistConfigurationScreen(),
    );
  },
  '/playlist_group_configuration': (settings) {
    return MaterialPageRoute(
      builder: (context) => const PlaylistGroupConfigurationScreen(),
    );
  },
  '/dynamic_content_configuration': (settings) {
    return MaterialPageRoute(
      builder: (context) => const DynamicContentConfigurationScreen(),
    );
  },
  '/open_video_url': (settings) {
    return MaterialPageRoute(
      builder: (context) => const OpenVideoScreen(),
    );
  },
  '/set_share_base_url': (settings) {
    return MaterialPageRoute(
      builder: (context) => const SetShareBaseURLScreen(),
    );
  },
  '/shopping_configuration': (settings) {
    return MaterialPageRoute(
      builder: (context) => const ShoppingConfigurationScreen(),
    );
  },
  '/checkout': (settings) {
    return MaterialPageRoute(
      builder: (context) => const CheckoutScreen(),
    );
  },
  '/set_ad_badge_configuration': (settings) {
    return MaterialPageRoute(
      builder: (context) => const AdBadgeConfigurationScreen(),
    );
  },
  '/enable_custom_cta_click_callback': (settings) {
    return MaterialPageRoute(
      builder: (context) => const EnableCustomCTAClickCallbackScreen(),
    );
  },
  '/cart': (settings) {
    return MaterialPageRoute(
      builder: (context) => const CartScreen(),
    );
  },
  '/link_content': (settings) {
    return MaterialPageRoute(
      builder: (context) => LinkContentScreen(settings: settings),
    );
  },
  '/circle_thumbnails': (settings) {
    return MaterialPageRoute(
      builder: (context) => const CircleThumbnails(),
    );
  },
  '/hashtag_playlist_configuration': (settings) {
    return MaterialPageRoute(
      builder: (context) => const HashtagPlaylistConfigurationScreen(),
    );
  },
  '/sku_configuration': (settings) {
    return MaterialPageRoute(
      builder: (context) => const SkuConfigurationScreen(),
    );
  },
  '/story_block_configuration': (settings) {
    return MaterialPageRoute(
      builder: (context) => const StoryBlockConfigurationScreen(),
    );
  },
  '/single_content_configuration': (settings) {
    return MaterialPageRoute(
      builder: (context) => const SingleContentConfigurationScreen(),
    );
  },
  '/log': (settings) {
    return MaterialPageRoute(
      builder: (context) => const LogScreen(),
    );
  },
  '/enable_on_video_playback_log': (settings) {
    return MaterialPageRoute(
      builder: (context) => const EnableOnVideoPlaybackLogScreen(),
    );
  },
  '/enable_custom_share_url_callback': (settings) {
    return MaterialPageRoute(
      builder: (context) => const EnableCustomShareUrlCallbackScreen(),
    );
  },
  '/enable_custom_share_url': (settings) {
    return MaterialPageRoute(
      builder: (context) => const EnableCustomShareUrlScreen(),
    );
  },
  '/enable_link_interaction_click_callback': (settings) {
    return MaterialPageRoute(
      builder: (context) => const EnableLinkInteractionClickCallbackScreen(),
    );
  },
  '/enable_giveaway_terms_click_callback': (settings) {
    return MaterialPageRoute(
      builder: (context) => const EnableGiveawayTermsClickCallbackScreen(),
    );
  },
  '/enter_video_id': (settings) {
    return MaterialPageRoute(
      builder: (context) => const EnterVideoIdScreen(),
    );
  },
  '/story_block_video': (settings) {
    return MaterialPageRoute(
      builder: (context) => OpenStoryBlockVideoScreen(settings: settings),
    );
  },
};
