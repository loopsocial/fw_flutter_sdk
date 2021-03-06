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

  /// `CTA background color`
  String get ctaBackgroundColor {
    return Intl.message(
      'CTA background color',
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

  /// `CTA text color`
  String get ctaTextColor {
    return Intl.message(
      'CTA text color',
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

  /// `CTA font size`
  String get ctaFontSize {
    return Intl.message(
      'CTA font size',
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

  /// `Please correct url`
  String get urlRequiredError {
    return Intl.message(
      'Please correct url',
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

  /// `Cart Configuration`
  String get cartConfiguration {
    return Intl.message(
      'Cart Configuration',
      name: 'cartConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Background color of "Add to cart" button`
  String get addToCartButtonBackgroundColor {
    return Intl.message(
      'Background color of "Add to cart" button',
      name: 'addToCartButtonBackgroundColor',
      desc: '',
      args: [],
    );
  }

  /// `Text color of "Add to cart" button`
  String get addToCartButtonTextColor {
    return Intl.message(
      'Text color of "Add to cart" button',
      name: 'addToCartButtonTextColor',
      desc: '',
      args: [],
    );
  }

  /// `Font size of "Add to cart" button`
  String get addToCartButtonFontSize {
    return Intl.message(
      'Font size of "Add to cart" button',
      name: 'addToCartButtonFontSize',
      desc: '',
      args: [],
    );
  }

  /// `e.g. #ffffff`
  String get addToCartButtonTextColorHint {
    return Intl.message(
      'e.g. #ffffff',
      name: 'addToCartButtonTextColorHint',
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

  /// `Video Player Style`
  String get videoPlayerStyle {
    return Intl.message(
      'Video Player Style',
      name: 'videoPlayerStyle',
      desc: '',
      args: [],
    );
  }

  /// `Video Player CompleteAction`
  String get videoPlayerCompleteAction {
    return Intl.message(
      'Video Player CompleteAction',
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
