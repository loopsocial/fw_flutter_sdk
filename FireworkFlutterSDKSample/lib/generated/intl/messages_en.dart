// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(language) => "Change App Langauge (${language})";

  static String m1(level) => "Change data tracking level(${level})";

  static String m2(value) => "CTA delay value: ${value}";

  static String m3(value) => "CTA highlight delay value: ${value}";

  static String m4(url) => "Current: ${url}";

  static String m5(version) => "Firework Android SDK version: ${version}";

  static String m6(min, max) => "Please enter height in [${min}, ${max}]";

  static String m7(url, iOSUrl, androidUrl) =>
      "The base url is ${url}.\nThe iOS url is ${iOSUrl}.\nThe Android url is ${androidUrl}.";

  static String m8(url) => "The page url is ${url}.";

  static String m9(title) => "The user comes from ${title}";

  static String m10(min, max) => "Please enter width in [${min}, ${max}]";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "CVC": MessageLookupByLibrary.simpleMessage("CVN"),
        "MM": MessageLookupByLibrary.simpleMessage("MM"),
        "YY": MessageLookupByLibrary.simpleMessage("YY"),
        "actionButtonBackgroundColor": MessageLookupByLibrary.simpleMessage(
            "Action button background color"),
        "actionButtonDividerLineColor": MessageLookupByLibrary.simpleMessage(
            "Action button divider line color"),
        "actionButtonShape":
            MessageLookupByLibrary.simpleMessage("Action button shape type"),
        "actionButtonTextColor":
            MessageLookupByLibrary.simpleMessage("Action button text color"),
        "ad": MessageLookupByLibrary.simpleMessage("ad"),
        "addToCart": MessageLookupByLibrary.simpleMessage("Add to cart"),
        "advanceToNext":
            MessageLookupByLibrary.simpleMessage("advance to next"),
        "backgroundColor":
            MessageLookupByLibrary.simpleMessage("Background Color"),
        "backgroundColorHint":
            MessageLookupByLibrary.simpleMessage("e.g. #c0c0c0"),
        "buyNow": MessageLookupByLibrary.simpleMessage("Buy now"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "cancelButtonBackgroundColor": MessageLookupByLibrary.simpleMessage(
            "Cancel button background color"),
        "cancelButtonShape":
            MessageLookupByLibrary.simpleMessage("Cancel button shape"),
        "cancelButtonTextColor":
            MessageLookupByLibrary.simpleMessage("Cancel button text color"),
        "cardNumber": MessageLookupByLibrary.simpleMessage("Card Number"),
        "cartPage": MessageLookupByLibrary.simpleMessage("Cart Page"),
        "changeAppLanguage": m0,
        "changeDataTrackingLevel": m1,
        "channelAggregator":
            MessageLookupByLibrary.simpleMessage("Channel Aggregator"),
        "channelFeed": MessageLookupByLibrary.simpleMessage("Channel Feed"),
        "channelId": MessageLookupByLibrary.simpleMessage("Channel Id"),
        "channelIdError": MessageLookupByLibrary.simpleMessage(
            "Please enter correct channel id"),
        "channelIdHint":
            MessageLookupByLibrary.simpleMessage("Enter channel id"),
        "channelIdRequiredError":
            MessageLookupByLibrary.simpleMessage("Please enter channel id"),
        "channelInfo": MessageLookupByLibrary.simpleMessage("Channel Info"),
        "checkout": MessageLookupByLibrary.simpleMessage("CHECKOUT"),
        "circleThumbnails":
            MessageLookupByLibrary.simpleMessage("Circle Thumbnails(iOS)"),
        "city": MessageLookupByLibrary.simpleMessage("City"),
        "clearLog": MessageLookupByLibrary.simpleMessage("Clear log"),
        "clearLogSuccessfully":
            MessageLookupByLibrary.simpleMessage("Clear log successfully"),
        "closePlayerToast": MessageLookupByLibrary.simpleMessage(
            "The player is closed. If PiP is disabled, it\'s expected. Otherwise, it\'s a bug."),
        "colorError":
            MessageLookupByLibrary.simpleMessage("Please enter correct color"),
        "column": MessageLookupByLibrary.simpleMessage("Column"),
        "compact": MessageLookupByLibrary.simpleMessage("Compact"),
        "constant": MessageLookupByLibrary.simpleMessage("constant"),
        "contentId": MessageLookupByLibrary.simpleMessage("Content id"),
        "contentIdError": MessageLookupByLibrary.simpleMessage(
            "Please enter correct content id"),
        "contentIdHint":
            MessageLookupByLibrary.simpleMessage("Enter content id"),
        "contentIdRequiredError":
            MessageLookupByLibrary.simpleMessage("Please enter content id"),
        "cornerRadius": MessageLookupByLibrary.simpleMessage("Corner radius"),
        "cornerRadiusError": MessageLookupByLibrary.simpleMessage(
            "Please enter correct corner radius"),
        "cornerRadiusHint": MessageLookupByLibrary.simpleMessage("e.g. 30"),
        "cornerRadiusRangeError": MessageLookupByLibrary.simpleMessage(
            "Please enter corner radius in [0, 50]"),
        "creator": MessageLookupByLibrary.simpleMessage("Creator"),
        "creditCardInfo":
            MessageLookupByLibrary.simpleMessage("Credit Card Info"),
        "ctaBackgroundColor":
            MessageLookupByLibrary.simpleMessage("CTA background color"),
        "ctaBackgroundColor2":
            MessageLookupByLibrary.simpleMessage("CTA background color"),
        "ctaBackgroundColorHint":
            MessageLookupByLibrary.simpleMessage("e.g. #c0c0c0"),
        "ctaDelayType": MessageLookupByLibrary.simpleMessage("CTA delay type"),
        "ctaDelayValue": m2,
        "ctaFontHint": MessageLookupByLibrary.simpleMessage("e.g. 14"),
        "ctaFontSize": MessageLookupByLibrary.simpleMessage("CTA font size"),
        "ctaFontSize2": MessageLookupByLibrary.simpleMessage("CTA font size"),
        "ctaHighlightDelayType":
            MessageLookupByLibrary.simpleMessage("CTA highlight delay type"),
        "ctaHighlightDelayValue": m3,
        "ctaLinkContentScreenTitle": MessageLookupByLibrary.simpleMessage(
            "CTA Link Content(Flutter page)"),
        "ctaShape": MessageLookupByLibrary.simpleMessage("CTA shape"),
        "ctaTextColor": MessageLookupByLibrary.simpleMessage("CTA text color"),
        "ctaTextColor2": MessageLookupByLibrary.simpleMessage("CTA text color"),
        "ctaTextColorHint":
            MessageLookupByLibrary.simpleMessage("e.g. #000000"),
        "ctaWidth": MessageLookupByLibrary.simpleMessage("CTA width"),
        "currentShareBaseURLTip": m4,
        "custom": MessageLookupByLibrary.simpleMessage("Custom"),
        "customizeLinkButtonHandler": MessageLookupByLibrary.simpleMessage(
            "Customize link button handler"),
        "dark": MessageLookupByLibrary.simpleMessage("Dark"),
        "defaultBehavior":
            MessageLookupByLibrary.simpleMessage("defaultBehavior"),
        "disableCustomCTAClickCallbackSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Disable custom CTA click callback successfully"),
        "disableCustomClickCartIconCallbackSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Disable custom click cart icon callback successfully"),
        "disableOnVideoPlaybackLogSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Disable onVideoPlayback log successfully"),
        "disabled": MessageLookupByLibrary.simpleMessage("Disabled"),
        "discoverFeed": MessageLookupByLibrary.simpleMessage("Discover Feed"),
        "dynamicContentFeed":
            MessageLookupByLibrary.simpleMessage("Dynamic Content Feed"),
        "dynamicContentInfo":
            MessageLookupByLibrary.simpleMessage("Dynamic Content Info"),
        "dynamicContentParameters":
            MessageLookupByLibrary.simpleMessage("Dynamic Content Parameters"),
        "dynamicContentParametersFormatError":
            MessageLookupByLibrary.simpleMessage(
                "Please enter correct dynamic content parameters"),
        "dynamicContentParametersHint": MessageLookupByLibrary.simpleMessage(
            "e.g. {\"key\": [\"value1\", \"value2\"]}"),
        "dynamicContentParametersRequiredError":
            MessageLookupByLibrary.simpleMessage(
                "Please enter dynamic content parameters"),
        "enableAutoplay":
            MessageLookupByLibrary.simpleMessage("Enable Autoplay"),
        "enableCustomButtons":
            MessageLookupByLibrary.simpleMessage("Enable custom buttons"),
        "enableCustomCTAClickCallback": MessageLookupByLibrary.simpleMessage(
            "Enable Custom CTA Click Callback"),
        "enableCustomCTAClickCallbackSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Enable custom CTA click callback successfully"),
        "enableCustomClickCartIconCallback":
            MessageLookupByLibrary.simpleMessage(
                "Enable Custom Click Cart Icon Callback"),
        "enableCustomClickCartIconCallbackSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Enable custom click cart icon callback successfully"),
        "enableCustomLayoutName": MessageLookupByLibrary.simpleMessage(
            "Enable Custom Layout Name(Android)"),
        "enableCustomTapProductCard": MessageLookupByLibrary.simpleMessage(
            "Enable custom tap product card"),
        "enableKeepingAlive":
            MessageLookupByLibrary.simpleMessage("Enable Keeping Alive"),
        "enableOnVideoPlaybackLog":
            MessageLookupByLibrary.simpleMessage("Enable onVideoPlayback log"),
        "enableOnVideoPlaybackLogSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Enable onVideoPlayback log successfully"),
        "enablePausePlayer":
            MessageLookupByLibrary.simpleMessage("Enable Pause Player"),
        "enablePictureInPicture":
            MessageLookupByLibrary.simpleMessage("Enable Picture In Picture"),
        "export": MessageLookupByLibrary.simpleMessage("Export"),
        "feed": MessageLookupByLibrary.simpleMessage("Feed"),
        "feedConfiguration":
            MessageLookupByLibrary.simpleMessage("Feed Configuration"),
        "feedLayouts": MessageLookupByLibrary.simpleMessage("Feed Layouts"),
        "fit": MessageLookupByLibrary.simpleMessage("fit"),
        "fontSizeError": MessageLookupByLibrary.simpleMessage(
            "Please enter correct font size"),
        "fontSizeRangeError": MessageLookupByLibrary.simpleMessage(
            "Please enter font size in [8, 30]"),
        "full": MessageLookupByLibrary.simpleMessage("full"),
        "fullWidth": MessageLookupByLibrary.simpleMessage("Full width"),
        "fwAndroidSdkVersion": m5,
        "grid": MessageLookupByLibrary.simpleMessage("Grid"),
        "gridColumns": MessageLookupByLibrary.simpleMessage("Grid Columns"),
        "gridColumnsError": MessageLookupByLibrary.simpleMessage(
            "Please enter correct grid columns"),
        "gridColumnsHint": MessageLookupByLibrary.simpleMessage("e.g. 3"),
        "gridColumnsRangeError": MessageLookupByLibrary.simpleMessage(
            "Please enter grid columns in [2, 8]"),
        "hashtagFilterExpression":
            MessageLookupByLibrary.simpleMessage("Hashtag filter expression"),
        "hashtagFilterExpressionHint": MessageLookupByLibrary.simpleMessage(
            "Enter hashtag filter expression"),
        "hashtagFilterExpressionRequiredError":
            MessageLookupByLibrary.simpleMessage(
                "Please enter hashtag filter expression"),
        "hashtagPlaylistFeed":
            MessageLookupByLibrary.simpleMessage("Hashtag Playlist Feed"),
        "hashtagPlaylistInfo":
            MessageLookupByLibrary.simpleMessage("Hashtag Playlist Info"),
        "heightError":
            MessageLookupByLibrary.simpleMessage("Please enter correct height"),
        "heightRangeError": m6,
        "hideCountdownTimer":
            MessageLookupByLibrary.simpleMessage("Hide countdown timer"),
        "hideLinkButton":
            MessageLookupByLibrary.simpleMessage("Hide link button"),
        "hidePlayIcon": MessageLookupByLibrary.simpleMessage("Hide Play Icon"),
        "hideProductCardCtaButton": MessageLookupByLibrary.simpleMessage(
            "Hide product card CTA Button"),
        "hideProductCardPrice":
            MessageLookupByLibrary.simpleMessage("Hide product card price"),
        "hideReplayBadge":
            MessageLookupByLibrary.simpleMessage("Hide replay badge"),
        "hideTitle": MessageLookupByLibrary.simpleMessage("Hide Title"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "integration": MessageLookupByLibrary.simpleMessage("Integration"),
        "light": MessageLookupByLibrary.simpleMessage("Light"),
        "linkContentScreenTitle":
            MessageLookupByLibrary.simpleMessage("Link Content(Flutter page)"),
        "livestreamCountdownTimerTheme": MessageLookupByLibrary.simpleMessage(
            "Livestream countdown timer theme"),
        "log": MessageLookupByLibrary.simpleMessage("Log"),
        "loop": MessageLookupByLibrary.simpleMessage("loop"),
        "more": MessageLookupByLibrary.simpleMessage("More"),
        "multiFeeds": MessageLookupByLibrary.simpleMessage("Multi-feeds"),
        "multiplePageUrlsToastText": m7,
        "muteOnFirstLaunch":
            MessageLookupByLibrary.simpleMessage("muteOnFirstLaunch"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "nameOnCard": MessageLookupByLibrary.simpleMessage("Name On Card"),
        "nested": MessageLookupByLibrary.simpleMessage("nested"),
        "numberOfTitleLines":
            MessageLookupByLibrary.simpleMessage("Number of title lines"),
        "numberOfTitleLinesError": MessageLookupByLibrary.simpleMessage(
            "Please enter correct grid columns"),
        "numberOfTitleLinesHint":
            MessageLookupByLibrary.simpleMessage("e.g. 1"),
        "numberOfTitleLinesRangeError": MessageLookupByLibrary.simpleMessage(
            "Please enter grid columns in [1, 5]"),
        "open": MessageLookupByLibrary.simpleMessage("Open"),
        "openVideoURL": MessageLookupByLibrary.simpleMessage("Open Video URL"),
        "oval": MessageLookupByLibrary.simpleMessage("Oval"),
        "pageUrlToastText": m8,
        "pause": MessageLookupByLibrary.simpleMessage("Pause"),
        "percentage": MessageLookupByLibrary.simpleMessage("percentage"),
        "play": MessageLookupByLibrary.simpleMessage("Play"),
        "playIconWidth":
            MessageLookupByLibrary.simpleMessage("Play icon width"),
        "playIconWidthError": MessageLookupByLibrary.simpleMessage(
            "Please enter correct play icon width"),
        "playIconWidthHint": MessageLookupByLibrary.simpleMessage("e.g. 36"),
        "playIconWidthRangeError": MessageLookupByLibrary.simpleMessage(
            "Please enter play icon width in [0, 100]"),
        "playerConfiguration":
            MessageLookupByLibrary.simpleMessage("Player Configuration"),
        "playerLogoClickable":
            MessageLookupByLibrary.simpleMessage("Player logo is clickable"),
        "playerLogoEncodedId":
            MessageLookupByLibrary.simpleMessage("Player logo encoded id"),
        "playerLogoOption":
            MessageLookupByLibrary.simpleMessage("Player logo option"),
        "playerStyle": MessageLookupByLibrary.simpleMessage("Player style"),
        "playlistFeed": MessageLookupByLibrary.simpleMessage("Playlist Feed"),
        "playlistGroupFeed":
            MessageLookupByLibrary.simpleMessage("Playlist Group Feed"),
        "playlistGroupId":
            MessageLookupByLibrary.simpleMessage("Playlist Group Id"),
        "playlistGroupIdError": MessageLookupByLibrary.simpleMessage(
            "Please enter correct playlist group id"),
        "playlistGroupIdHint":
            MessageLookupByLibrary.simpleMessage("Enter playlist group id"),
        "playlistGroupIdRequiredError": MessageLookupByLibrary.simpleMessage(
            "Please enter playlist group id"),
        "playlistGroupInfo":
            MessageLookupByLibrary.simpleMessage("Playlist Group Info"),
        "playlistId": MessageLookupByLibrary.simpleMessage("Playlist Id"),
        "playlistIdError": MessageLookupByLibrary.simpleMessage(
            "Please enter correct playlist id"),
        "playlistIdHint":
            MessageLookupByLibrary.simpleMessage("Enter playlist id"),
        "playlistIdRequiredError":
            MessageLookupByLibrary.simpleMessage("Please enter playlist id"),
        "playlistInfo": MessageLookupByLibrary.simpleMessage("Playlist Info"),
        "productCardBackgroundColor": MessageLookupByLibrary.simpleMessage(
            "Product card background color"),
        "productCardCTAButtonFontSize": MessageLookupByLibrary.simpleMessage(
            "Font size of product card CTA button(iOS)"),
        "productCardCTAButtonText": MessageLookupByLibrary.simpleMessage(
            "Product card CTA button text"),
        "productCardCTAButtonTextColor": MessageLookupByLibrary.simpleMessage(
            "Text color of product card CTA button(iOS)"),
        "productCardCTAButtonTextColorHint":
            MessageLookupByLibrary.simpleMessage("e.g. #ffffff"),
        "productCardCornerRadius":
            MessageLookupByLibrary.simpleMessage("Product card corner radius"),
        "productCardCornerRadiusHint": MessageLookupByLibrary.simpleMessage(
            "Enter product card corner radius"),
        "productCardHeight":
            MessageLookupByLibrary.simpleMessage("Product card height(iOS)"),
        "productCardHeightHint":
            MessageLookupByLibrary.simpleMessage("e.g. 88"),
        "productCardIconCornerRadius": MessageLookupByLibrary.simpleMessage(
            "Product card icon corner radius"),
        "productCardIconCornerRadiusHint": MessageLookupByLibrary.simpleMessage(
            "Enter product card icon corner radius"),
        "productCardIsPriceFirst": MessageLookupByLibrary.simpleMessage(
            "Product card is price first(iOS)"),
        "productCardNameLabelFontSize": MessageLookupByLibrary.simpleMessage(
            "Font size of product card name label(iOS)"),
        "productCardNameLabelLines": MessageLookupByLibrary.simpleMessage(
            "Number of lines for product card name label(iOS)"),
        "productCardNameLabelTextColor": MessageLookupByLibrary.simpleMessage(
            "Text color of product card name label(iOS)"),
        "productCardNameLabelTextColorHint":
            MessageLookupByLibrary.simpleMessage("e.g. #ffffff"),
        "productCardOriginalPriceLabelFontSize":
            MessageLookupByLibrary.simpleMessage(
                "Font size of product card original price label(iOS)"),
        "productCardOriginalPriceLabelLines":
            MessageLookupByLibrary.simpleMessage(
                "Number of lines for product card original price label(iOS)"),
        "productCardOriginalPriceLabelTextColor":
            MessageLookupByLibrary.simpleMessage(
                "Text color of product card original price label(iOS)"),
        "productCardOriginalPriceLabelTextColorHint":
            MessageLookupByLibrary.simpleMessage("e.g. #ffffff"),
        "productCardPriceLabelFontSize": MessageLookupByLibrary.simpleMessage(
            "Font size of product card price label(iOS)"),
        "productCardPriceLabelLines": MessageLookupByLibrary.simpleMessage(
            "Number of lines for product card price label(iOS)"),
        "productCardPriceLabelTextColor": MessageLookupByLibrary.simpleMessage(
            "Text color of product card price label(iOS)"),
        "productCardPriceLabelTextColorHint":
            MessageLookupByLibrary.simpleMessage("e.g. #ffffff"),
        "productCardTheme":
            MessageLookupByLibrary.simpleMessage("Product card theme"),
        "productCardWidth":
            MessageLookupByLibrary.simpleMessage("Product card width(iOS)"),
        "productCardWidthHint":
            MessageLookupByLibrary.simpleMessage("e.g. 218"),
        "productIds": MessageLookupByLibrary.simpleMessage("Product ids"),
        "productsIdsHint": MessageLookupByLibrary.simpleMessage(
            "e.g. product_id_1,product_id_2"),
        "productsIdsRequiredError":
            MessageLookupByLibrary.simpleMessage("Please enter product ids"),
        "refresh": MessageLookupByLibrary.simpleMessage("Refresh"),
        "requiresAds": MessageLookupByLibrary.simpleMessage("Requires Ads"),
        "reset": MessageLookupByLibrary.simpleMessage("Reset"),
        "resetTip": MessageLookupByLibrary.simpleMessage(
            "Do you want to reset to default configuration?"),
        "roundRectangle":
            MessageLookupByLibrary.simpleMessage("Round rectangle"),
        "row": MessageLookupByLibrary.simpleMessage("Row"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "selectChannelId":
            MessageLookupByLibrary.simpleMessage("Select Channel Id"),
        "selectDataTrackingLevel":
            MessageLookupByLibrary.simpleMessage("Select data tracking level"),
        "selectDynamicContentInfo":
            MessageLookupByLibrary.simpleMessage("Select Dynamic Content Info"),
        "selectLanguage":
            MessageLookupByLibrary.simpleMessage("Select language"),
        "selectPlaylistGroupId":
            MessageLookupByLibrary.simpleMessage("Select Playlist Group Id"),
        "selectPlaylistInfo":
            MessageLookupByLibrary.simpleMessage("Select Playlist Info"),
        "setAdBadgeConfiguration":
            MessageLookupByLibrary.simpleMessage("Set Ad Badge Configuration"),
        "setAdBadgeConfigurationSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Set Ad badge configuration successfully"),
        "setDefaultShoppingPlaylistTip": MessageLookupByLibrary.simpleMessage(
            "Please set up default shopping playlist info in \'./FireworkFlutterSDKSample/lib/assets/feed.json\'. Or you could also configure shopping playlist info by clicking the setting icon on the right side of the navigation bar."),
        "setShareBaseURL":
            MessageLookupByLibrary.simpleMessage("Set Share Base URL"),
        "setShareBaseURLSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Set share base URL successfully"),
        "shadowColor": MessageLookupByLibrary.simpleMessage("Shadow color"),
        "shadowColorHint": MessageLookupByLibrary.simpleMessage("e.g. #000000"),
        "shadowHeight": MessageLookupByLibrary.simpleMessage("Shadow height"),
        "shadowHeightError": MessageLookupByLibrary.simpleMessage(
            "Please enter correct shadow height"),
        "shadowHeightHint": MessageLookupByLibrary.simpleMessage("e.g. 0"),
        "shadowHeightRangeError": MessageLookupByLibrary.simpleMessage(
            "Please enter shadow height in [0, 100]"),
        "shadowOpacity": MessageLookupByLibrary.simpleMessage("Shadow opacity"),
        "shadowOpacityError": MessageLookupByLibrary.simpleMessage(
            "Please enter correct shadow opacity"),
        "shadowOpacityHint": MessageLookupByLibrary.simpleMessage("e.g. 0.6"),
        "shadowOpacityRangeError": MessageLookupByLibrary.simpleMessage(
            "Please enter opacity in [0, 1]"),
        "shadowWidth": MessageLookupByLibrary.simpleMessage("Shadow width"),
        "shadowWidthError": MessageLookupByLibrary.simpleMessage(
            "Please enter correct shadow width"),
        "shadowWidthHint": MessageLookupByLibrary.simpleMessage("e.g. 0"),
        "shadowWidthRangeError": MessageLookupByLibrary.simpleMessage(
            "Please enter shadow width in [0, 100]"),
        "shareBaseURL": MessageLookupByLibrary.simpleMessage("Share base URL"),
        "shippingInfo": MessageLookupByLibrary.simpleMessage("Shipping Info"),
        "shopNow": MessageLookupByLibrary.simpleMessage("Shop now"),
        "shopping": MessageLookupByLibrary.simpleMessage("Shopping"),
        "shoppingCTAButtonBackgroundColor":
            MessageLookupByLibrary.simpleMessage(
                "Background color of shopping CTA button"),
        "shoppingCTAButtonFontSize": MessageLookupByLibrary.simpleMessage(
            "Font size of shopping CTA button"),
        "shoppingCTAButtonText":
            MessageLookupByLibrary.simpleMessage("Shopping CTA button text"),
        "shoppingCTAButtonTextColor": MessageLookupByLibrary.simpleMessage(
            "Text color of shopping CTA button"),
        "shoppingCTAButtonTextColorHint":
            MessageLookupByLibrary.simpleMessage("e.g. #ffffff"),
        "shoppingConfiguration":
            MessageLookupByLibrary.simpleMessage("Shopping Configuration"),
        "showAdBadge": MessageLookupByLibrary.simpleMessage("Show Ad Badge"),
        "showCartIcon": MessageLookupByLibrary.simpleMessage("Show Cart Icon"),
        "showMuteButton":
            MessageLookupByLibrary.simpleMessage("Show mute button"),
        "showPlaybackButton":
            MessageLookupByLibrary.simpleMessage("Show playback button"),
        "showShareButton":
            MessageLookupByLibrary.simpleMessage("Show share button"),
        "showVideoDetailTitle":
            MessageLookupByLibrary.simpleMessage("Show video detail title"),
        "singleContentFeed":
            MessageLookupByLibrary.simpleMessage("Single Content Feed"),
        "singleContentFeedInfo":
            MessageLookupByLibrary.simpleMessage("Single Content Feed Info"),
        "sizeToFit": MessageLookupByLibrary.simpleMessage("Size to fit"),
        "skuFeed": MessageLookupByLibrary.simpleMessage("SKU Feed"),
        "skuFeedInfo": MessageLookupByLibrary.simpleMessage("SKU Info"),
        "sponsored": MessageLookupByLibrary.simpleMessage("sponsored"),
        "stacked": MessageLookupByLibrary.simpleMessage("stacked"),
        "state": MessageLookupByLibrary.simpleMessage("State"),
        "stopFloatingPlayer":
            MessageLookupByLibrary.simpleMessage("Stop floating player"),
        "storeDetails": MessageLookupByLibrary.simpleMessage("Store Details"),
        "storefront": MessageLookupByLibrary.simpleMessage("Storefront"),
        "storyBlock": MessageLookupByLibrary.simpleMessage("Story Block"),
        "storyBlockConfiguration":
            MessageLookupByLibrary.simpleMessage("Story block configuration"),
        "storyBlockLoadError":
            MessageLookupByLibrary.simpleMessage("Fail to load story block"),
        "street": MessageLookupByLibrary.simpleMessage("Street"),
        "theUserComesFromTitle": m9,
        "titleColor": MessageLookupByLibrary.simpleMessage("Title Color"),
        "titleColorHint": MessageLookupByLibrary.simpleMessage("e.g. #000000"),
        "titleFontSize":
            MessageLookupByLibrary.simpleMessage("Title font size"),
        "titleFontSizeHint": MessageLookupByLibrary.simpleMessage("e.g. 14"),
        "titleFontSizeHint1": MessageLookupByLibrary.simpleMessage("e.g. 12"),
        "titlePosition": MessageLookupByLibrary.simpleMessage("Title Position"),
        "total": MessageLookupByLibrary.simpleMessage("Total"),
        "urlError":
            MessageLookupByLibrary.simpleMessage("Please enter correct url"),
        "urlHint": MessageLookupByLibrary.simpleMessage("Enter url"),
        "urlRequiredError":
            MessageLookupByLibrary.simpleMessage("Please enter correct url"),
        "use": MessageLookupByLibrary.simpleMessage("Use"),
        "useAndroidFontInfoForTitle": MessageLookupByLibrary.simpleMessage(
            "Use Android font info for title"),
        "useAndroidGradientDrawableForTitle":
            MessageLookupByLibrary.simpleMessage(
                "Use Android gradient drawable for title"),
        "useIOSFontInfo": MessageLookupByLibrary.simpleMessage(
            "Use iOS font info(TimesNewRomanPS-ItalicMT)"),
        "useIOSFontInfoForCTA": MessageLookupByLibrary.simpleMessage(
            "Use iOS font info(TimesNewRomanPS-ItalicMT) for CTA"),
        "useIOSFontInfoForTitle": MessageLookupByLibrary.simpleMessage(
            "Use iOS font info(TimesNewRomanPS-ItalicMT) for title"),
        "vastAttributes":
            MessageLookupByLibrary.simpleMessage("Vast Attributes"),
        "vastAttributesFormatError": MessageLookupByLibrary.simpleMessage(
            "Please enter correct vast attributes"),
        "vastAttributesHint": MessageLookupByLibrary.simpleMessage(
            "e.g. {\"name1\": \"value1\", \"name2\": \"value2\"}"),
        "videoCompleteAction":
            MessageLookupByLibrary.simpleMessage("Video complete action"),
        "videoFeed": MessageLookupByLibrary.simpleMessage("Video Feed"),
        "videoFeedLoadError":
            MessageLookupByLibrary.simpleMessage("Fail to load video feed"),
        "videoPlayerCompleteAction": MessageLookupByLibrary.simpleMessage(
            "Video player complete action"),
        "videoPlayerCompleteAction2": MessageLookupByLibrary.simpleMessage(
            "Video player complete action(full-screen)"),
        "videoPlayerStyle":
            MessageLookupByLibrary.simpleMessage("Video player style"),
        "videoPlayerStyle2": MessageLookupByLibrary.simpleMessage(
            "Video player style(full-screen)"),
        "videoURL": MessageLookupByLibrary.simpleMessage("Video URL"),
        "videolaunchBehavior":
            MessageLookupByLibrary.simpleMessage("Video Launch Behavior"),
        "widthError":
            MessageLookupByLibrary.simpleMessage("Please enter correct width"),
        "widthRangeError": m10
      };
}
