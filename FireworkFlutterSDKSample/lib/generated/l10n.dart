// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Feed Layouts`
  String get feedLayouts {
    return Intl.message(
      'Feed Layouts',
      name: 'feedLayouts',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Discover Feed`
  String get discoverFeed {
    return Intl.message(
      'Discover Feed',
      name: 'discoverFeed',
      desc: '',
      args: [],
    );
  }

  /// `Channel Feed`
  String get channelFeed {
    return Intl.message(
      'Channel Feed',
      name: 'channelFeed',
      desc: '',
      args: [],
    );
  }

  /// `Playlist Feed`
  String get playlistFeed {
    return Intl.message(
      'Playlist Feed',
      name: 'playlistFeed',
      desc: '',
      args: [],
    );
  }

  /// `Playlist Group Feed`
  String get playlistGroupFeed {
    return Intl.message(
      'Playlist Group Feed',
      name: 'playlistGroupFeed',
      desc: '',
      args: [],
    );
  }

  /// `Feed`
  String get feed {
    return Intl.message(
      'Feed',
      name: 'feed',
      desc: '',
      args: [],
    );
  }

  /// `Row`
  String get row {
    return Intl.message(
      'Row',
      name: 'row',
      desc: '',
      args: [],
    );
  }

  /// `Column`
  String get column {
    return Intl.message(
      'Column',
      name: 'column',
      desc: '',
      args: [],
    );
  }

  /// `Grid`
  String get grid {
    return Intl.message(
      'Grid',
      name: 'grid',
      desc: '',
      args: [],
    );
  }

  /// `Feed Configuration`
  String get feedConfiguration {
    return Intl.message(
      'Feed Configuration',
      name: 'feedConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Player Configuration`
  String get playerConfiguration {
    return Intl.message(
      'Player Configuration',
      name: 'playerConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Background Color`
  String get backgroundColor {
    return Intl.message(
      'Background Color',
      name: 'backgroundColor',
      desc: '',
      args: [],
    );
  }

  /// `e.g. #c0c0c0`
  String get backgroundColorHint {
    return Intl.message(
      'e.g. #c0c0c0',
      name: 'backgroundColorHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct color`
  String get colorError {
    return Intl.message(
      'Please enter correct color',
      name: 'colorError',
      desc: '',
      args: [],
    );
  }

  /// `Corner radius`
  String get cornerRadius {
    return Intl.message(
      'Corner radius',
      name: 'cornerRadius',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 30`
  String get cornerRadiusHint {
    return Intl.message(
      'e.g. 30',
      name: 'cornerRadiusHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct corner radius`
  String get cornerRadiusError {
    return Intl.message(
      'Please enter correct corner radius',
      name: 'cornerRadiusError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter corner radius in [0, 50]`
  String get cornerRadiusRangeError {
    return Intl.message(
      'Please enter corner radius in [0, 50]',
      name: 'cornerRadiusRangeError',
      desc: '',
      args: [],
    );
  }

  /// `Hide Title`
  String get hideTitle {
    return Intl.message(
      'Hide Title',
      name: 'hideTitle',
      desc: '',
      args: [],
    );
  }

  /// `Title Color`
  String get titleColor {
    return Intl.message(
      'Title Color',
      name: 'titleColor',
      desc: '',
      args: [],
    );
  }

  /// `e.g. #000000`
  String get titleColorHint {
    return Intl.message(
      'e.g. #000000',
      name: 'titleColorHint',
      desc: '',
      args: [],
    );
  }

  /// `Title font size`
  String get titleFontSize {
    return Intl.message(
      'Title font size',
      name: 'titleFontSize',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 14`
  String get titleFontSizeHint {
    return Intl.message(
      'e.g. 14',
      name: 'titleFontSizeHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct font size`
  String get fontSizeError {
    return Intl.message(
      'Please enter correct font size',
      name: 'fontSizeError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter font size in [8, 30]`
  String get fontSizeRangeError {
    return Intl.message(
      'Please enter font size in [8, 30]',
      name: 'fontSizeRangeError',
      desc: '',
      args: [],
    );
  }

  /// `Title Position`
  String get titlePosition {
    return Intl.message(
      'Title Position',
      name: 'titlePosition',
      desc: '',
      args: [],
    );
  }

  /// `Hide Play Icon`
  String get hidePlayIcon {
    return Intl.message(
      'Hide Play Icon',
      name: 'hidePlayIcon',
      desc: '',
      args: [],
    );
  }

  /// `Play icon width`
  String get playIconWidth {
    return Intl.message(
      'Play icon width',
      name: 'playIconWidth',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 36`
  String get playIconWidthHint {
    return Intl.message(
      'e.g. 36',
      name: 'playIconWidthHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct play icon width`
  String get playIconWidthError {
    return Intl.message(
      'Please enter correct play icon width',
      name: 'playIconWidthError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter play icon width in [0, 100]`
  String get playIconWidthRangeError {
    return Intl.message(
      'Please enter play icon width in [0, 100]',
      name: 'playIconWidthRangeError',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to reset to default configuration?`
  String get resetTip {
    return Intl.message(
      'Do you want to reset to default configuration?',
      name: 'resetTip',
      desc: '',
      args: [],
    );
  }

  /// `nested`
  String get nested {
    return Intl.message(
      'nested',
      name: 'nested',
      desc: '',
      args: [],
    );
  }

  /// `stacked`
  String get stacked {
    return Intl.message(
      'stacked',
      name: 'stacked',
      desc: '',
      args: [],
    );
  }

  /// `Player style`
  String get playerStyle {
    return Intl.message(
      'Player style',
      name: 'playerStyle',
      desc: '',
      args: [],
    );
  }

  /// `full`
  String get full {
    return Intl.message(
      'full',
      name: 'full',
      desc: '',
      args: [],
    );
  }

  /// `fit`
  String get fit {
    return Intl.message(
      'fit',
      name: 'fit',
      desc: '',
      args: [],
    );
  }

  /// `Video complete action`
  String get videoCompleteAction {
    return Intl.message(
      'Video complete action',
      name: 'videoCompleteAction',
      desc: '',
      args: [],
    );
  }

  /// `Show share button`
  String get showShareButton {
    return Intl.message(
      'Show share button',
      name: 'showShareButton',
      desc: '',
      args: [],
    );
  }

  /// `CTA background color(iOS)`
  String get ctaBackgroundColor {
    return Intl.message(
      'CTA background color(iOS)',
      name: 'ctaBackgroundColor',
      desc: '',
      args: [],
    );
  }

  /// `e.g. #c0c0c0`
  String get ctaBackgroundColorHint {
    return Intl.message(
      'e.g. #c0c0c0',
      name: 'ctaBackgroundColorHint',
      desc: '',
      args: [],
    );
  }

  /// `CTA text color(iOS)`
  String get ctaTextColor {
    return Intl.message(
      'CTA text color(iOS)',
      name: 'ctaTextColor',
      desc: '',
      args: [],
    );
  }

  /// `e.g. #000000`
  String get ctaTextColorHint {
    return Intl.message(
      'e.g. #000000',
      name: 'ctaTextColorHint',
      desc: '',
      args: [],
    );
  }

  /// `CTA font size(iOS)`
  String get ctaFontSize {
    return Intl.message(
      'CTA font size(iOS)',
      name: 'ctaFontSize',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 14`
  String get ctaFontHint {
    return Intl.message(
      'e.g. 14',
      name: 'ctaFontHint',
      desc: '',
      args: [],
    );
  }

  /// `Show playback button`
  String get showPlaybackButton {
    return Intl.message(
      'Show playback button',
      name: 'showPlaybackButton',
      desc: '',
      args: [],
    );
  }

  /// `Show mute button`
  String get showMuteButton {
    return Intl.message(
      'Show mute button',
      name: 'showMuteButton',
      desc: '',
      args: [],
    );
  }

  /// `advanceToNext`
  String get advanceToNext {
    return Intl.message(
      'advanceToNext',
      name: 'advanceToNext',
      desc: '',
      args: [],
    );
  }

  /// `loop`
  String get loop {
    return Intl.message(
      'loop',
      name: 'loop',
      desc: '',
      args: [],
    );
  }

  /// `Custom`
  String get custom {
    return Intl.message(
      'Custom',
      name: 'custom',
      desc: '',
      args: [],
    );
  }

  /// `Channel Info`
  String get channelInfo {
    return Intl.message(
      'Channel Info',
      name: 'channelInfo',
      desc: '',
      args: [],
    );
  }

  /// `Playlist Info`
  String get playlistInfo {
    return Intl.message(
      'Playlist Info',
      name: 'playlistInfo',
      desc: '',
      args: [],
    );
  }

  /// `Playlist Group Info`
  String get playlistGroupInfo {
    return Intl.message(
      'Playlist Group Info',
      name: 'playlistGroupInfo',
      desc: '',
      args: [],
    );
  }

  /// `Use`
  String get use {
    return Intl.message(
      'Use',
      name: 'use',
      desc: '',
      args: [],
    );
  }

  /// `Channel Id`
  String get channelId {
    return Intl.message(
      'Channel Id',
      name: 'channelId',
      desc: '',
      args: [],
    );
  }

  /// `Enter channel id`
  String get channelIdHint {
    return Intl.message(
      'Enter channel id',
      name: 'channelIdHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct channel id`
  String get channelIdError {
    return Intl.message(
      'Please enter correct channel id',
      name: 'channelIdError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter channel id`
  String get channelIdRequiredError {
    return Intl.message(
      'Please enter channel id',
      name: 'channelIdRequiredError',
      desc: '',
      args: [],
    );
  }

  /// `Playlist Id`
  String get playlistId {
    return Intl.message(
      'Playlist Id',
      name: 'playlistId',
      desc: '',
      args: [],
    );
  }

  /// `Enter playlist id`
  String get playlistIdHint {
    return Intl.message(
      'Enter playlist id',
      name: 'playlistIdHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct playlist id`
  String get playlistIdError {
    return Intl.message(
      'Please enter correct playlist id',
      name: 'playlistIdError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter playlist id`
  String get playlistIdRequiredError {
    return Intl.message(
      'Please enter playlist id',
      name: 'playlistIdRequiredError',
      desc: '',
      args: [],
    );
  }

  /// `Playlist Group Id`
  String get playlistGroupId {
    return Intl.message(
      'Playlist Group Id',
      name: 'playlistGroupId',
      desc: '',
      args: [],
    );
  }

  /// `Enter playlist group id`
  String get playlistGroupIdHint {
    return Intl.message(
      'Enter playlist group id',
      name: 'playlistGroupIdHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct playlist group id`
  String get playlistGroupIdError {
    return Intl.message(
      'Please enter correct playlist group id',
      name: 'playlistGroupIdError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter playlist group id`
  String get playlistGroupIdRequiredError {
    return Intl.message(
      'Please enter playlist group id',
      name: 'playlistGroupIdRequiredError',
      desc: '',
      args: [],
    );
  }

  /// `Open Video URL`
  String get openVideoURL {
    return Intl.message(
      'Open Video URL',
      name: 'openVideoURL',
      desc: '',
      args: [],
    );
  }

  /// `Set Share Base URL`
  String get setShareBaseURL {
    return Intl.message(
      'Set Share Base URL',
      name: 'setShareBaseURL',
      desc: '',
      args: [],
    );
  }

  /// `Enter url`
  String get urlHint {
    return Intl.message(
      'Enter url',
      name: 'urlHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct url`
  String get urlError {
    return Intl.message(
      'Please enter correct url',
      name: 'urlError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct url`
  String get urlRequiredError {
    return Intl.message(
      'Please enter correct url',
      name: 'urlRequiredError',
      desc: '',
      args: [],
    );
  }

  /// `Video URL`
  String get videoURL {
    return Intl.message(
      'Video URL',
      name: 'videoURL',
      desc: '',
      args: [],
    );
  }

  /// `Open`
  String get open {
    return Intl.message(
      'Open',
      name: 'open',
      desc: '',
      args: [],
    );
  }

  /// `Current: {url}`
  String currentShareBaseURLTip(Object url) {
    return Intl.message(
      'Current: $url',
      name: 'currentShareBaseURLTip',
      desc: '',
      args: [url],
    );
  }

  /// `Shopping`
  String get shopping {
    return Intl.message(
      'Shopping',
      name: 'shopping',
      desc: '',
      args: [],
    );
  }

  /// `Store Details`
  String get storeDetails {
    return Intl.message(
      'Store Details',
      name: 'storeDetails',
      desc: '',
      args: [],
    );
  }

  /// `Integration`
  String get integration {
    return Intl.message(
      'Integration',
      name: 'integration',
      desc: '',
      args: [],
    );
  }

  /// `Storefront`
  String get storefront {
    return Intl.message(
      'Storefront',
      name: 'storefront',
      desc: '',
      args: [],
    );
  }

  /// `Shopping Configuration`
  String get shoppingConfiguration {
    return Intl.message(
      'Shopping Configuration',
      name: 'shoppingConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Background color of shopping CTA button`
  String get shoppingCTAButtonBackgroundColor {
    return Intl.message(
      'Background color of shopping CTA button',
      name: 'shoppingCTAButtonBackgroundColor',
      desc: '',
      args: [],
    );
  }

  /// `Text color of shopping CTA button`
  String get shoppingCTAButtonTextColor {
    return Intl.message(
      'Text color of shopping CTA button',
      name: 'shoppingCTAButtonTextColor',
      desc: '',
      args: [],
    );
  }

  /// `Font size of shopping CTA button`
  String get shoppingCTAButtonFontSize {
    return Intl.message(
      'Font size of shopping CTA button',
      name: 'shoppingCTAButtonFontSize',
      desc: '',
      args: [],
    );
  }

  /// `e.g. #ffffff`
  String get shoppingCTAButtonTextColorHint {
    return Intl.message(
      'e.g. #ffffff',
      name: 'shoppingCTAButtonTextColorHint',
      desc: '',
      args: [],
    );
  }

  /// `Set share base URL successfully`
  String get setShareBaseURLSuccessfully {
    return Intl.message(
      'Set share base URL successfully',
      name: 'setShareBaseURLSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Cart Page`
  String get cartPage {
    return Intl.message(
      'Cart Page',
      name: 'cartPage',
      desc: '',
      args: [],
    );
  }

  /// `CHECKOUT`
  String get checkout {
    return Intl.message(
      'CHECKOUT',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Buy now`
  String get buyNow {
    return Intl.message(
      'Buy now',
      name: 'buyNow',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Credit Card Info`
  String get creditCardInfo {
    return Intl.message(
      'Credit Card Info',
      name: 'creditCardInfo',
      desc: '',
      args: [],
    );
  }

  /// `Card Number`
  String get cardNumber {
    return Intl.message(
      'Card Number',
      name: 'cardNumber',
      desc: '',
      args: [],
    );
  }

  /// `MM`
  String get MM {
    return Intl.message(
      'MM',
      name: 'MM',
      desc: '',
      args: [],
    );
  }

  /// `YY`
  String get YY {
    return Intl.message(
      'YY',
      name: 'YY',
      desc: '',
      args: [],
    );
  }

  /// `CVN`
  String get CVC {
    return Intl.message(
      'CVN',
      name: 'CVC',
      desc: '',
      args: [],
    );
  }

  /// `Name On Card`
  String get nameOnCard {
    return Intl.message(
      'Name On Card',
      name: 'nameOnCard',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Info`
  String get shippingInfo {
    return Intl.message(
      'Shipping Info',
      name: 'shippingInfo',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Street`
  String get street {
    return Intl.message(
      'Street',
      name: 'street',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get state {
    return Intl.message(
      'State',
      name: 'state',
      desc: '',
      args: [],
    );
  }

  /// `Show Cart Icon`
  String get showCartIcon {
    return Intl.message(
      'Show Cart Icon',
      name: 'showCartIcon',
      desc: '',
      args: [],
    );
  }

  /// `Show Ad Badge`
  String get showAdBadge {
    return Intl.message(
      'Show Ad Badge',
      name: 'showAdBadge',
      desc: '',
      args: [],
    );
  }

  /// `ad`
  String get ad {
    return Intl.message(
      'ad',
      name: 'ad',
      desc: '',
      args: [],
    );
  }

  /// `sponsored`
  String get sponsored {
    return Intl.message(
      'sponsored',
      name: 'sponsored',
      desc: '',
      args: [],
    );
  }

  /// `Set Ad badge configuration successfully`
  String get setAdBadgeConfigurationSuccessfully {
    return Intl.message(
      'Set Ad badge configuration successfully',
      name: 'setAdBadgeConfigurationSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Set Ad Badge Configuration`
  String get setAdBadgeConfiguration {
    return Intl.message(
      'Set Ad Badge Configuration',
      name: 'setAdBadgeConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Video Launch Behavior`
  String get videolaunchBehavior {
    return Intl.message(
      'Video Launch Behavior',
      name: 'videolaunchBehavior',
      desc: '',
      args: [],
    );
  }

  /// `defaultBehavior`
  String get defaultBehavior {
    return Intl.message(
      'defaultBehavior',
      name: 'defaultBehavior',
      desc: '',
      args: [],
    );
  }

  /// `muteOnFirstLaunch`
  String get muteOnFirstLaunch {
    return Intl.message(
      'muteOnFirstLaunch',
      name: 'muteOnFirstLaunch',
      desc: '',
      args: [],
    );
  }

  /// `Video player style`
  String get videoPlayerStyle {
    return Intl.message(
      'Video player style',
      name: 'videoPlayerStyle',
      desc: '',
      args: [],
    );
  }

  /// `Video player complete action`
  String get videoPlayerCompleteAction {
    return Intl.message(
      'Video player complete action',
      name: 'videoPlayerCompleteAction',
      desc: '',
      args: [],
    );
  }

  /// `Fail to load video feed`
  String get videoFeedLoadError {
    return Intl.message(
      'Fail to load video feed',
      name: 'videoFeedLoadError',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message(
      'Refresh',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `CTA Link Content(Flutter page)`
  String get ctaLinkContentScreenTitle {
    return Intl.message(
      'CTA Link Content(Flutter page)',
      name: 'ctaLinkContentScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enable Custom CTA Click Callback`
  String get enableCustomCTAClickCallback {
    return Intl.message(
      'Enable Custom CTA Click Callback',
      name: 'enableCustomCTAClickCallback',
      desc: '',
      args: [],
    );
  }

  /// `Enable custom CTA click callback successfully`
  String get enableCustomCTAClickCallbackSuccessfully {
    return Intl.message(
      'Enable custom CTA click callback successfully',
      name: 'enableCustomCTAClickCallbackSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Disable custom CTA click callback successfully`
  String get disableCustomCTAClickCallbackSuccessfully {
    return Intl.message(
      'Disable custom CTA click callback successfully',
      name: 'disableCustomCTAClickCallbackSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Dynamic Content Feed`
  String get dynamicContentFeed {
    return Intl.message(
      'Dynamic Content Feed',
      name: 'dynamicContentFeed',
      desc: '',
      args: [],
    );
  }

  /// `Dynamic Content Info`
  String get dynamicContentInfo {
    return Intl.message(
      'Dynamic Content Info',
      name: 'dynamicContentInfo',
      desc: '',
      args: [],
    );
  }

  /// `Dynamic Content Parameters`
  String get dynamicContentParameters {
    return Intl.message(
      'Dynamic Content Parameters',
      name: 'dynamicContentParameters',
      desc: '',
      args: [],
    );
  }

  /// `e.g. {"key": ["value1", "value2"]}`
  String get dynamicContentParametersHint {
    return Intl.message(
      'e.g. {"key": ["value1", "value2"]}',
      name: 'dynamicContentParametersHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter dynamic content parameters`
  String get dynamicContentParametersRequiredError {
    return Intl.message(
      'Please enter dynamic content parameters',
      name: 'dynamicContentParametersRequiredError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct dynamic content parameters`
  String get dynamicContentParametersFormatError {
    return Intl.message(
      'Please enter correct dynamic content parameters',
      name: 'dynamicContentParametersFormatError',
      desc: '',
      args: [],
    );
  }

  /// `Select Channel Id`
  String get selectChannelId {
    return Intl.message(
      'Select Channel Id',
      name: 'selectChannelId',
      desc: '',
      args: [],
    );
  }

  /// `Select Playlist Info`
  String get selectPlaylistInfo {
    return Intl.message(
      'Select Playlist Info',
      name: 'selectPlaylistInfo',
      desc: '',
      args: [],
    );
  }

  /// `Select Playlist Group Id`
  String get selectPlaylistGroupId {
    return Intl.message(
      'Select Playlist Group Id',
      name: 'selectPlaylistGroupId',
      desc: '',
      args: [],
    );
  }

  /// `Select Dynamic Content Info`
  String get selectDynamicContentInfo {
    return Intl.message(
      'Select Dynamic Content Info',
      name: 'selectDynamicContentInfo',
      desc: '',
      args: [],
    );
  }

  /// `Enable Custom Layout Name(Android)`
  String get enableCustomLayoutName {
    return Intl.message(
      'Enable Custom Layout Name(Android)',
      name: 'enableCustomLayoutName',
      desc: '',
      args: [],
    );
  }

  /// `Circle Thumbnails(iOS)`
  String get circleThumbnails {
    return Intl.message(
      'Circle Thumbnails(iOS)',
      name: 'circleThumbnails',
      desc: '',
      args: [],
    );
  }

  /// `Enable Autoplay`
  String get enableAutoplay {
    return Intl.message(
      'Enable Autoplay',
      name: 'enableAutoplay',
      desc: '',
      args: [],
    );
  }

  /// `Enable Custom Click Cart Icon Callback`
  String get enableCustomClickCartIconCallback {
    return Intl.message(
      'Enable Custom Click Cart Icon Callback',
      name: 'enableCustomClickCartIconCallback',
      desc: '',
      args: [],
    );
  }

  /// `Enable custom click cart icon callback successfully`
  String get enableCustomClickCartIconCallbackSuccessfully {
    return Intl.message(
      'Enable custom click cart icon callback successfully',
      name: 'enableCustomClickCartIconCallbackSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Disable custom click cart icon callback successfully`
  String get disableCustomClickCartIconCallbackSuccessfully {
    return Intl.message(
      'Disable custom click cart icon callback successfully',
      name: 'disableCustomClickCartIconCallbackSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Video Feed`
  String get videoFeed {
    return Intl.message(
      'Video Feed',
      name: 'videoFeed',
      desc: '',
      args: [],
    );
  }

  /// `Story Block`
  String get storyBlock {
    return Intl.message(
      'Story Block',
      name: 'storyBlock',
      desc: '',
      args: [],
    );
  }

  /// `Fail to load story block`
  String get storyBlockLoadError {
    return Intl.message(
      'Fail to load story block',
      name: 'storyBlockLoadError',
      desc: '',
      args: [],
    );
  }

  /// `Requires Ads`
  String get requiresAds {
    return Intl.message(
      'Requires Ads',
      name: 'requiresAds',
      desc: '',
      args: [],
    );
  }

  /// `Vast Attributes`
  String get vastAttributes {
    return Intl.message(
      'Vast Attributes',
      name: 'vastAttributes',
      desc: '',
      args: [],
    );
  }

  /// `e.g. {"name1": "value1", "name2": "value2"}`
  String get vastAttributesHint {
    return Intl.message(
      'e.g. {"name1": "value1", "name2": "value2"}',
      name: 'vastAttributesHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct vast attributes`
  String get vastAttributesFormatError {
    return Intl.message(
      'Please enter correct vast attributes',
      name: 'vastAttributesFormatError',
      desc: '',
      args: [],
    );
  }

  /// `Enable Picture In Picture`
  String get enablePictureInPicture {
    return Intl.message(
      'Enable Picture In Picture',
      name: 'enablePictureInPicture',
      desc: '',
      args: [],
    );
  }

  /// `Grid Columns`
  String get gridColumns {
    return Intl.message(
      'Grid Columns',
      name: 'gridColumns',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 3`
  String get gridColumnsHint {
    return Intl.message(
      'e.g. 3',
      name: 'gridColumnsHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct grid columns`
  String get gridColumnsError {
    return Intl.message(
      'Please enter correct grid columns',
      name: 'gridColumnsError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter grid columns in [2, 8]`
  String get gridColumnsRangeError {
    return Intl.message(
      'Please enter grid columns in [2, 8]',
      name: 'gridColumnsRangeError',
      desc: '',
      args: [],
    );
  }

  /// `Add to cart`
  String get addToCart {
    return Intl.message(
      'Add to cart',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  /// `Shop now`
  String get shopNow {
    return Intl.message(
      'Shop now',
      name: 'shopNow',
      desc: '',
      args: [],
    );
  }

  /// `Use iOS font info(TimesNewRomanPS-ItalicMT)`
  String get useIOSFontInfo {
    return Intl.message(
      'Use iOS font info(TimesNewRomanPS-ItalicMT)',
      name: 'useIOSFontInfo',
      desc: '',
      args: [],
    );
  }

  /// `Hide link button`
  String get hideLinkButton {
    return Intl.message(
      'Hide link button',
      name: 'hideLinkButton',
      desc: '',
      args: [],
    );
  }

  /// `Customize link button handler`
  String get customizeLinkButtonHandler {
    return Intl.message(
      'Customize link button handler',
      name: 'customizeLinkButtonHandler',
      desc: '',
      args: [],
    );
  }

  /// `Use iOS font info(TimesNewRomanPS-ItalicMT) for title`
  String get useIOSFontInfoForTitle {
    return Intl.message(
      'Use iOS font info(TimesNewRomanPS-ItalicMT) for title',
      name: 'useIOSFontInfoForTitle',
      desc: '',
      args: [],
    );
  }

  /// `Use iOS font info(TimesNewRomanPS-ItalicMT) for CTA`
  String get useIOSFontInfoForCTA {
    return Intl.message(
      'Use iOS font info(TimesNewRomanPS-ItalicMT) for CTA',
      name: 'useIOSFontInfoForCTA',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 12`
  String get titleFontSizeHint1 {
    return Intl.message(
      'e.g. 12',
      name: 'titleFontSizeHint1',
      desc: '',
      args: [],
    );
  }

  /// `Stop floating player`
  String get stopFloatingPlayer {
    return Intl.message(
      'Stop floating player',
      name: 'stopFloatingPlayer',
      desc: '',
      args: [],
    );
  }

  /// `Play`
  String get play {
    return Intl.message(
      'Play',
      name: 'play',
      desc: '',
      args: [],
    );
  }

  /// `Pause`
  String get pause {
    return Intl.message(
      'Pause',
      name: 'pause',
      desc: '',
      args: [],
    );
  }

  /// `Hashtag Playlist Feed`
  String get hashtagPlaylistFeed {
    return Intl.message(
      'Hashtag Playlist Feed',
      name: 'hashtagPlaylistFeed',
      desc: '',
      args: [],
    );
  }

  /// `Hashtag Playlist Info`
  String get hashtagPlaylistInfo {
    return Intl.message(
      'Hashtag Playlist Info',
      name: 'hashtagPlaylistInfo',
      desc: '',
      args: [],
    );
  }

  /// `Hashtag filter expression`
  String get hashtagFilterExpression {
    return Intl.message(
      'Hashtag filter expression',
      name: 'hashtagFilterExpression',
      desc: '',
      args: [],
    );
  }

  /// `Enter hashtag filter expression`
  String get hashtagFilterExpressionHint {
    return Intl.message(
      'Enter hashtag filter expression',
      name: 'hashtagFilterExpressionHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter hashtag filter expression`
  String get hashtagFilterExpressionRequiredError {
    return Intl.message(
      'Please enter hashtag filter expression',
      name: 'hashtagFilterExpressionRequiredError',
      desc: '',
      args: [],
    );
  }

  /// `Change App Langauge ({language})`
  String changeAppLanguage(Object language) {
    return Intl.message(
      'Change App Langauge ($language)',
      name: 'changeAppLanguage',
      desc: '',
      args: [language],
    );
  }

  /// `Link Content(Flutter page)`
  String get linkContentScreenTitle {
    return Intl.message(
      'Link Content(Flutter page)',
      name: 'linkContentScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `CTA delay type`
  String get ctaDelayType {
    return Intl.message(
      'CTA delay type',
      name: 'ctaDelayType',
      desc: '',
      args: [],
    );
  }

  /// `constant`
  String get constant {
    return Intl.message(
      'constant',
      name: 'constant',
      desc: '',
      args: [],
    );
  }

  /// `percentage`
  String get percentage {
    return Intl.message(
      'percentage',
      name: 'percentage',
      desc: '',
      args: [],
    );
  }

  /// `CTA delay value: {value}`
  String ctaDelayValue(Object value) {
    return Intl.message(
      'CTA delay value: $value',
      name: 'ctaDelayValue',
      desc: '',
      args: [value],
    );
  }

  /// `Shopping CTA button text`
  String get shoppingCTAButtonText {
    return Intl.message(
      'Shopping CTA button text',
      name: 'shoppingCTAButtonText',
      desc: '',
      args: [],
    );
  }

  /// `CTA highlight delay type`
  String get ctaHighlightDelayType {
    return Intl.message(
      'CTA highlight delay type',
      name: 'ctaHighlightDelayType',
      desc: '',
      args: [],
    );
  }

  /// `CTA highlight delay value: {value}`
  String ctaHighlightDelayValue(Object value) {
    return Intl.message(
      'CTA highlight delay value: $value',
      name: 'ctaHighlightDelayValue',
      desc: '',
      args: [value],
    );
  }

  /// `Share base URL`
  String get shareBaseURL {
    return Intl.message(
      'Share base URL',
      name: 'shareBaseURL',
      desc: '',
      args: [],
    );
  }

  /// `CTA width`
  String get ctaWidth {
    return Intl.message(
      'CTA width',
      name: 'ctaWidth',
      desc: '',
      args: [],
    );
  }

  /// `Full width`
  String get fullWidth {
    return Intl.message(
      'Full width',
      name: 'fullWidth',
      desc: '',
      args: [],
    );
  }

  /// `Compact`
  String get compact {
    return Intl.message(
      'Compact',
      name: 'compact',
      desc: '',
      args: [],
    );
  }

  /// `Size to fit`
  String get sizeToFit {
    return Intl.message(
      'Size to fit',
      name: 'sizeToFit',
      desc: '',
      args: [],
    );
  }

  /// `Number of title lines`
  String get numberOfTitleLines {
    return Intl.message(
      'Number of title lines',
      name: 'numberOfTitleLines',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 1`
  String get numberOfTitleLinesHint {
    return Intl.message(
      'e.g. 1',
      name: 'numberOfTitleLinesHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct grid columns`
  String get numberOfTitleLinesError {
    return Intl.message(
      'Please enter correct grid columns',
      name: 'numberOfTitleLinesError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter grid columns in [1, 5]`
  String get numberOfTitleLinesRangeError {
    return Intl.message(
      'Please enter grid columns in [1, 5]',
      name: 'numberOfTitleLinesRangeError',
      desc: '',
      args: [],
    );
  }

  /// `Use Android font info for title`
  String get useAndroidFontInfoForTitle {
    return Intl.message(
      'Use Android font info for title',
      name: 'useAndroidFontInfoForTitle',
      desc: '',
      args: [],
    );
  }

  /// `Use Android gradient drawable for title`
  String get useAndroidGradientDrawableForTitle {
    return Intl.message(
      'Use Android gradient drawable for title',
      name: 'useAndroidGradientDrawableForTitle',
      desc: '',
      args: [],
    );
  }

  /// `Story block configuration`
  String get storyBlockConfiguration {
    return Intl.message(
      'Story block configuration',
      name: 'storyBlockConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Please set up default shopping playlist info in './FireworkFlutterSDKSample/lib/assets/feed.json'. Or you could also configure shopping playlist info by clicking the setting icon on the right side of the navigation bar.`
  String get setDefaultShoppingPlaylistTip {
    return Intl.message(
      'Please set up default shopping playlist info in \'./FireworkFlutterSDKSample/lib/assets/feed.json\'. Or you could also configure shopping playlist info by clicking the setting icon on the right side of the navigation bar.',
      name: 'setDefaultShoppingPlaylistTip',
      desc: '',
      args: [],
    );
  }

  /// `Product ids`
  String get productIds {
    return Intl.message(
      'Product ids',
      name: 'productIds',
      desc: '',
      args: [],
    );
  }

  /// `e.g. product_id_1,product_id_2`
  String get productsIdsHint {
    return Intl.message(
      'e.g. product_id_1,product_id_2',
      name: 'productsIdsHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter product ids`
  String get productsIdsRequiredError {
    return Intl.message(
      'Please enter product ids',
      name: 'productsIdsRequiredError',
      desc: '',
      args: [],
    );
  }

  /// `SKU Feed`
  String get skuFeed {
    return Intl.message(
      'SKU Feed',
      name: 'skuFeed',
      desc: '',
      args: [],
    );
  }

  /// `SKU Info`
  String get skuFeedInfo {
    return Intl.message(
      'SKU Info',
      name: 'skuFeedInfo',
      desc: '',
      args: [],
    );
  }

  /// `Firework Android SDK version: {version}`
  String fwAndroidSdkVersion(Object version) {
    return Intl.message(
      'Firework Android SDK version: $version',
      name: 'fwAndroidSdkVersion',
      desc: '',
      args: [version],
    );
  }

  /// `Content id`
  String get contentId {
    return Intl.message(
      'Content id',
      name: 'contentId',
      desc: '',
      args: [],
    );
  }

  /// `Enter content id`
  String get contentIdHint {
    return Intl.message(
      'Enter content id',
      name: 'contentIdHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct content id`
  String get contentIdError {
    return Intl.message(
      'Please enter correct content id',
      name: 'contentIdError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter content id`
  String get contentIdRequiredError {
    return Intl.message(
      'Please enter content id',
      name: 'contentIdRequiredError',
      desc: '',
      args: [],
    );
  }

  /// `Single Content Feed`
  String get singleContentFeed {
    return Intl.message(
      'Single Content Feed',
      name: 'singleContentFeed',
      desc: '',
      args: [],
    );
  }

  /// `Single Content Feed Info`
  String get singleContentFeedInfo {
    return Intl.message(
      'Single Content Feed Info',
      name: 'singleContentFeedInfo',
      desc: '',
      args: [],
    );
  }

  /// `Product card CTA button text`
  String get productCardCTAButtonText {
    return Intl.message(
      'Product card CTA button text',
      name: 'productCardCTAButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Product card theme`
  String get productCardTheme {
    return Intl.message(
      'Product card theme',
      name: 'productCardTheme',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Enable custom tap product card`
  String get enableCustomTapProductCard {
    return Intl.message(
      'Enable custom tap product card',
      name: 'enableCustomTapProductCard',
      desc: '',
      args: [],
    );
  }

  /// `Enable custom buttons`
  String get enableCustomButtons {
    return Intl.message(
      'Enable custom buttons',
      name: 'enableCustomButtons',
      desc: '',
      args: [],
    );
  }

  /// `Video player complete action(full-screen)`
  String get videoPlayerCompleteAction2 {
    return Intl.message(
      'Video player complete action(full-screen)',
      name: 'videoPlayerCompleteAction2',
      desc: '',
      args: [],
    );
  }

  /// `Show video detail title`
  String get showVideoDetailTitle {
    return Intl.message(
      'Show video detail title',
      name: 'showVideoDetailTitle',
      desc: '',
      args: [],
    );
  }

  /// `Video player style(full-screen)`
  String get videoPlayerStyle2 {
    return Intl.message(
      'Video player style(full-screen)',
      name: 'videoPlayerStyle2',
      desc: '',
      args: [],
    );
  }

  /// `CTA background color(iOS)(full-screen)`
  String get ctaBackgroundColor2 {
    return Intl.message(
      'CTA background color(iOS)(full-screen)',
      name: 'ctaBackgroundColor2',
      desc: '',
      args: [],
    );
  }

  /// `CTA text color(iOS)(full-screen)`
  String get ctaTextColor2 {
    return Intl.message(
      'CTA text color(iOS)(full-screen)',
      name: 'ctaTextColor2',
      desc: '',
      args: [],
    );
  }

  /// `CTA font size(iOS)(full-screen)`
  String get ctaFontSize2 {
    return Intl.message(
      'CTA font size(iOS)(full-screen)',
      name: 'ctaFontSize2',
      desc: '',
      args: [],
    );
  }

  /// `Hide product card price`
  String get hideProductCardPrice {
    return Intl.message(
      'Hide product card price',
      name: 'hideProductCardPrice',
      desc: '',
      args: [],
    );
  }

  /// `Hide product card CTA Button`
  String get hideProductCardCtaButton {
    return Intl.message(
      'Hide product card CTA Button',
      name: 'hideProductCardCtaButton',
      desc: '',
      args: [],
    );
  }

  /// `Product card corner radius`
  String get productCardCornerRadius {
    return Intl.message(
      'Product card corner radius',
      name: 'productCardCornerRadius',
      desc: '',
      args: [],
    );
  }

  /// `Enter product card corner radius`
  String get productCardCornerRadiusHint {
    return Intl.message(
      'Enter product card corner radius',
      name: 'productCardCornerRadiusHint',
      desc: '',
      args: [],
    );
  }

  /// `Enable Pause Player`
  String get enablePausePlayer {
    return Intl.message(
      'Enable Pause Player',
      name: 'enablePausePlayer',
      desc: '',
      args: [],
    );
  }

  /// `Enable Keeping Alive`
  String get enableKeepingAlive {
    return Intl.message(
      'Enable Keeping Alive',
      name: 'enableKeepingAlive',
      desc: '',
      args: [],
    );
  }

  /// `Multi-feeds`
  String get multiFeeds {
    return Intl.message(
      'Multi-feeds',
      name: 'multiFeeds',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Player logo option`
  String get playerLogoOption {
    return Intl.message(
      'Player logo option',
      name: 'playerLogoOption',
      desc: '',
      args: [],
    );
  }

  /// `Disabled`
  String get disabled {
    return Intl.message(
      'Disabled',
      name: 'disabled',
      desc: '',
      args: [],
    );
  }

  /// `Creator`
  String get creator {
    return Intl.message(
      'Creator',
      name: 'creator',
      desc: '',
      args: [],
    );
  }

  /// `Channel Aggregator`
  String get channelAggregator {
    return Intl.message(
      'Channel Aggregator',
      name: 'channelAggregator',
      desc: '',
      args: [],
    );
  }

  /// `Player logo encoded id`
  String get playerLogoEncodedId {
    return Intl.message(
      'Player logo encoded id',
      name: 'playerLogoEncodedId',
      desc: '',
      args: [],
    );
  }

  /// `Player logo is clickable`
  String get playerLogoClickable {
    return Intl.message(
      'Player logo is clickable',
      name: 'playerLogoClickable',
      desc: '',
      args: [],
    );
  }

  /// `Text color of product card CTA button(iOS)`
  String get productCardCTAButtonTextColor {
    return Intl.message(
      'Text color of product card CTA button(iOS)',
      name: 'productCardCTAButtonTextColor',
      desc: '',
      args: [],
    );
  }

  /// `Font size of product card CTA button(iOS)`
  String get productCardCTAButtonFontSize {
    return Intl.message(
      'Font size of product card CTA button(iOS)',
      name: 'productCardCTAButtonFontSize',
      desc: '',
      args: [],
    );
  }

  /// `e.g. #ffffff`
  String get productCardCTAButtonTextColorHint {
    return Intl.message(
      'e.g. #ffffff',
      name: 'productCardCTAButtonTextColorHint',
      desc: '',
      args: [],
    );
  }

  /// `Product card width(iOS)`
  String get productCardWidth {
    return Intl.message(
      'Product card width(iOS)',
      name: 'productCardWidth',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 218`
  String get productCardWidthHint {
    return Intl.message(
      'e.g. 218',
      name: 'productCardWidthHint',
      desc: '',
      args: [],
    );
  }

  /// `Product card height(iOS)`
  String get productCardHeight {
    return Intl.message(
      'Product card height(iOS)',
      name: 'productCardHeight',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 88`
  String get productCardHeightHint {
    return Intl.message(
      'e.g. 88',
      name: 'productCardHeightHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct width`
  String get widthError {
    return Intl.message(
      'Please enter correct width',
      name: 'widthError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter width in [{min}, {max}]`
  String widthRangeError(Object min, Object max) {
    return Intl.message(
      'Please enter width in [$min, $max]',
      name: 'widthRangeError',
      desc: '',
      args: [min, max],
    );
  }

  /// `Please enter correct height`
  String get heightError {
    return Intl.message(
      'Please enter correct height',
      name: 'heightError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter height in [{min}, {max}]`
  String heightRangeError(Object min, Object max) {
    return Intl.message(
      'Please enter height in [$min, $max]',
      name: 'heightRangeError',
      desc: '',
      args: [min, max],
    );
  }

  /// `Product card background color`
  String get productCardBackgroundColor {
    return Intl.message(
      'Product card background color',
      name: 'productCardBackgroundColor',
      desc: '',
      args: [],
    );
  }

  /// `Product card icon corner radius`
  String get productCardIconCornerRadius {
    return Intl.message(
      'Product card icon corner radius',
      name: 'productCardIconCornerRadius',
      desc: '',
      args: [],
    );
  }

  /// `Enter product card icon corner radius`
  String get productCardIconCornerRadiusHint {
    return Intl.message(
      'Enter product card icon corner radius',
      name: 'productCardIconCornerRadiusHint',
      desc: '',
      args: [],
    );
  }

  /// `Text color of product card name label(iOS)`
  String get productCardNameLabelTextColor {
    return Intl.message(
      'Text color of product card name label(iOS)',
      name: 'productCardNameLabelTextColor',
      desc: '',
      args: [],
    );
  }

  /// `Font size of product card name label(iOS)`
  String get productCardNameLabelFontSize {
    return Intl.message(
      'Font size of product card name label(iOS)',
      name: 'productCardNameLabelFontSize',
      desc: '',
      args: [],
    );
  }

  /// `e.g. #ffffff`
  String get productCardNameLabelTextColorHint {
    return Intl.message(
      'e.g. #ffffff',
      name: 'productCardNameLabelTextColorHint',
      desc: '',
      args: [],
    );
  }

  /// `Number of lines for product card name label(iOS)`
  String get productCardNameLabelLines {
    return Intl.message(
      'Number of lines for product card name label(iOS)',
      name: 'productCardNameLabelLines',
      desc: '',
      args: [],
    );
  }

  /// `Text color of product card price label(iOS)`
  String get productCardPriceLabelTextColor {
    return Intl.message(
      'Text color of product card price label(iOS)',
      name: 'productCardPriceLabelTextColor',
      desc: '',
      args: [],
    );
  }

  /// `Font size of product card price label(iOS)`
  String get productCardPriceLabelFontSize {
    return Intl.message(
      'Font size of product card price label(iOS)',
      name: 'productCardPriceLabelFontSize',
      desc: '',
      args: [],
    );
  }

  /// `e.g. #ffffff`
  String get productCardPriceLabelTextColorHint {
    return Intl.message(
      'e.g. #ffffff',
      name: 'productCardPriceLabelTextColorHint',
      desc: '',
      args: [],
    );
  }

  /// `Number of lines for product card price label(iOS)`
  String get productCardPriceLabelLines {
    return Intl.message(
      'Number of lines for product card price label(iOS)',
      name: 'productCardPriceLabelLines',
      desc: '',
      args: [],
    );
  }

  /// `Text color of product card original price label(iOS)`
  String get productCardOriginalPriceLabelTextColor {
    return Intl.message(
      'Text color of product card original price label(iOS)',
      name: 'productCardOriginalPriceLabelTextColor',
      desc: '',
      args: [],
    );
  }

  /// `Font size of product card original price label(iOS)`
  String get productCardOriginalPriceLabelFontSize {
    return Intl.message(
      'Font size of product card original price label(iOS)',
      name: 'productCardOriginalPriceLabelFontSize',
      desc: '',
      args: [],
    );
  }

  /// `e.g. #ffffff`
  String get productCardOriginalPriceLabelTextColorHint {
    return Intl.message(
      'e.g. #ffffff',
      name: 'productCardOriginalPriceLabelTextColorHint',
      desc: '',
      args: [],
    );
  }

  /// `Number of lines for product card original price label(iOS)`
  String get productCardOriginalPriceLabelLines {
    return Intl.message(
      'Number of lines for product card original price label(iOS)',
      name: 'productCardOriginalPriceLabelLines',
      desc: '',
      args: [],
    );
  }

  /// `Product card is price first(iOS)`
  String get productCardIsPriceFirst {
    return Intl.message(
      'Product card is price first(iOS)',
      name: 'productCardIsPriceFirst',
      desc: '',
      args: [],
    );
  }

  /// `Hide replay badge`
  String get hideReplayBadge {
    return Intl.message(
      'Hide replay badge',
      name: 'hideReplayBadge',
      desc: '',
      args: [],
    );
  }

  /// `Hide countdown timer`
  String get hideCountdownTimer {
    return Intl.message(
      'Hide countdown timer',
      name: 'hideCountdownTimer',
      desc: '',
      args: [],
    );
  }

  /// `Shadow opacity`
  String get shadowOpacity {
    return Intl.message(
      'Shadow opacity',
      name: 'shadowOpacity',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 0.6`
  String get shadowOpacityHint {
    return Intl.message(
      'e.g. 0.6',
      name: 'shadowOpacityHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct shadow opacity`
  String get shadowOpacityError {
    return Intl.message(
      'Please enter correct shadow opacity',
      name: 'shadowOpacityError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter opacity in [0, 1]`
  String get shadowOpacityRangeError {
    return Intl.message(
      'Please enter opacity in [0, 1]',
      name: 'shadowOpacityRangeError',
      desc: '',
      args: [],
    );
  }

  /// `Shadow color`
  String get shadowColor {
    return Intl.message(
      'Shadow color',
      name: 'shadowColor',
      desc: '',
      args: [],
    );
  }

  /// `e.g. #000000`
  String get shadowColorHint {
    return Intl.message(
      'e.g. #000000',
      name: 'shadowColorHint',
      desc: '',
      args: [],
    );
  }

  /// `Shadow width`
  String get shadowWidth {
    return Intl.message(
      'Shadow width',
      name: 'shadowWidth',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 0`
  String get shadowWidthHint {
    return Intl.message(
      'e.g. 0',
      name: 'shadowWidthHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct shadow width`
  String get shadowWidthError {
    return Intl.message(
      'Please enter correct shadow width',
      name: 'shadowWidthError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter shadow width in [0, 100]`
  String get shadowWidthRangeError {
    return Intl.message(
      'Please enter shadow width in [0, 100]',
      name: 'shadowWidthRangeError',
      desc: '',
      args: [],
    );
  }

  /// `Shadow height`
  String get shadowHeight {
    return Intl.message(
      'Shadow height',
      name: 'shadowHeight',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 0`
  String get shadowHeightHint {
    return Intl.message(
      'e.g. 0',
      name: 'shadowHeightHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct shadow height`
  String get shadowHeightError {
    return Intl.message(
      'Please enter correct shadow height',
      name: 'shadowHeightError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter shadow height in [0, 100]`
  String get shadowHeightRangeError {
    return Intl.message(
      'Please enter shadow height in [0, 100]',
      name: 'shadowHeightRangeError',
      desc: '',
      args: [],
    );
  }

  /// `The page url is {url}.`
  String pageUrlToastText(Object url) {
    return Intl.message(
      'The page url is $url.',
      name: 'pageUrlToastText',
      desc: '',
      args: [url],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
