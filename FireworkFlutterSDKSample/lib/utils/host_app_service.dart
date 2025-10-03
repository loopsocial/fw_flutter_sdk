import 'dart:convert';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fw_flutter_sdk_example/constants/fw_example_event_name.dart';
import 'package:fw_flutter_sdk_example/models/app_language_info.dart';
import 'package:fw_flutter_sdk_example/models/cart_item.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/utils/fw_example_logger_util.dart';
import 'package:fw_flutter_sdk_example/utils/shopify_client.dart';

import '../my_app.dart';

class WidgetInfo {
  String title;
  String type;
  WidgetInfo({
    required this.title,
    required this.type,
  });
}

class HostAppService {
  static HostAppService? _instance;

  static HostAppService _getInstance() {
    _instance ??= HostAppService._();
    return _instance!;
  }

  bool enablePausePlayer = false;

  Map<String, WidgetInfo> widgetInfoMap = {};

  HostAppService._();

  factory HostAppService.getInstance() => _getInstance();

  Future<ShoppingCTAResult?> onShopNow(ShoppingCTAEvent? event) async {
    final feedId = event?.video.feedId ?? "";
    final videoId = event?.video.videoId;
    final widgetType = FireworkSDK.getInstance().getWidgetType(feedId);
    final videoType = event?.video.videoType;
    final liveStreamStatus = event?.video.liveStreamStatus;
    final customProductCTA = event?.customProductCTA;
    final customProductCTAUrl = customProductCTA?.url ?? "";
    final customProductCTATitleKey = customProductCTA?.titleKey ?? "";
    final customProductCTATitle = customProductCTA?.title ?? "";
    FWExampleLoggerUtil.log(
      "[Analytics] [Shopping] onShopNow feedId: $feedId videoId: $videoId widgetType: $widgetType videoType: $videoType liveStreamStatus: $liveStreamStatus customProductCTAUrl: $customProductCTAUrl customProductCTATitleKey: $customProductCTATitleKey customProductCTATitle: $customProductCTATitle",
      shouldCache: true,
    );
    final widgetInfo = HostAppService.getInstance().widgetInfoMap[feedId];
    EasyLoading.showToast(
      "The user comes from ${widgetInfo?.title ?? ""}",
      duration: const Duration(
        seconds: 5,
      ),
    );
    if (event == null) {
      return null;
    }

    await startFloatingPlayerOrClosePlayer();
    final url = event.url;
    final urlInfo = FWUrlUtil.parseUrl(
        url: url, iOSQueryName: "ios", androidQueryName: "android");
    FWExampleLoggerUtil.log("onShopNow url: ${urlInfo?.url}");
    FWExampleLoggerUtil.log("onShopNow iOS url: ${urlInfo?.iOSUrl}");
    FWExampleLoggerUtil.log("onShopNow android url: ${urlInfo?.androidUrl}");

    globalNavigatorKey.currentState?.pushNamed('/link_content', arguments: {
      "url": urlInfo?.url ?? '',
      "iOSUrl": urlInfo?.iOSUrl ?? '',
      "androidUrl": urlInfo?.androidUrl ?? '',
    });

    await event.ctaHandler?.complete(
      ShoppingCTAResult(
        res: ShoppingCTARes.success,
      ),
    );

    return null;
  }

  Future<ShoppingCTAResult?> onAddToCart(ShoppingCTAEvent? event) async {
    final feedId = event?.video.feedId ?? "";
    final videoId = event?.video.videoId;
    final widgetType = FireworkSDK.getInstance().getWidgetType(feedId);
    final videoType = event?.video.videoType;
    final liveStreamStatus = event?.video.liveStreamStatus;
    final customProductCTA = event?.customProductCTA;
    final customProductCTAUrl = customProductCTA?.url ?? "";
    final customProductCTATitleKey = customProductCTA?.titleKey ?? "";
    final customProductCTATitle = customProductCTA?.title ?? "";
    FWExampleLoggerUtil.log(
      "[Analytics] [Shopping] onAddToCart feedId: $feedId videoId: $videoId widgetType: $widgetType videoType: $videoType liveStreamStatus: $liveStreamStatus customProductCTAUrl: $customProductCTAUrl customProductCTATitleKey: $customProductCTATitleKey customProductCTATitle: $customProductCTATitle",
      shouldCache: true,
    );
    await event?.ctaHandler?.showLoader();

    if (event == null) {
      return null;
    }

    final showCart = await shouldShowCart();
    if (!showCart) {
      return onShopNow(event);
    }

    try {
      final shopifyProduct =
          await ShopifyClient.getInstance().fetchProduct(event.productId);
      FWExampleLoggerUtil.log(
          "fetchProduct $shopifyProduct ${shopifyProduct?.encodedId} ${shopifyProduct?.variants?.first.encodedId}");
      if (shopifyProduct == null) {
        return onShopNow(event);
      }

      final shopifyProductVariants = shopifyProduct.variants ?? [];

      final variantList = shopifyProductVariants
          .where(
            (element) =>
                ShopifyClient.getInstance().decodeId(element.encodedId) ==
                event.unitId,
          )
          .toList();
      if (variantList.isEmpty) {
        await event.ctaHandler?.complete(
          ShoppingCTAResult(
            res: ShoppingCTARes.fail,
            tips: "Unable to locate the selected variant",
          ),
        );
        return null;
      }

      final variant = variantList.first;

      final cartItem = CartItem(
        productId: event.productId,
        unitId: event.unitId,
      );
      cartItem.title = shopifyProduct.title;
      cartItem.subTitle = variant.title;
      if (variant.priceV2 != null) {
        final priceV2 = variant.priceV2!;
        if (priceV2["amount"] is String && priceV2["currencyCode"] is String) {
          cartItem.amount = priceV2["amount"] as String;
          cartItem.currencyCode = priceV2["currencyCode"] as String;
        }
      }

      if (variant.image != null) {
        final image = variant.image!;
        if (image["src"] is String) {
          cartItem.imageURL = image["src"] as String;
        }
      }
      await _addCartItem(cartItem);
      await event.ctaHandler?.complete(
        ShoppingCTAResult(
          res: ShoppingCTARes.success,
          tips: "Add to cart successfully",
        ),
      );
    } catch (e) {
      FWExampleLoggerUtil.log("fetchProduct error: $e");
      await event.ctaHandler?.complete(
        ShoppingCTAResult(
          res: ShoppingCTARes.fail,
          tips: "Fail to add to cart",
        ),
      );
    }
    return null;
  }

  Future<void> onShoppingSecondaryCTA(ShoppingSecondaryCTAEvent? event) async {
    final feedId = event?.video.feedId ?? "";
    final videoId = event?.video.videoId;
    final widgetType = FireworkSDK.getInstance().getWidgetType(feedId);
    final videoType = event?.video.videoType;
    final liveStreamStatus = event?.video.liveStreamStatus;
    final customProductCTA = event?.customProductCTA;
    final customProductCTAUrl = customProductCTA?.url ?? "";
    final customProductCTATitleKey = customProductCTA?.titleKey ?? "";
    final customProductCTATitle = customProductCTA?.title ?? "";
    FWExampleLoggerUtil.log(
      "[Analytics] [Shopping] onShoppingSecondaryCTA feedId: $feedId videoId: $videoId widgetType: $widgetType videoType: $videoType liveStreamStatus: $liveStreamStatus customProductCTAUrl: $customProductCTAUrl customProductCTATitleKey: $customProductCTATitleKey customProductCTATitle: $customProductCTATitle",
      shouldCache: true,
    );
    await startFloatingPlayerOrClosePlayer();
    globalNavigatorKey.currentState?.pushNamed('/link_content', arguments: {
      "url": event?.url ?? '',
    });
  }

  Future<void> onCustomClickCartIcon(CustomClickCartIconEvent? event) async {
    final feedId = event?.video.feedId ?? "";
    final videoId = event?.video.videoId;
    final widgetType = FireworkSDK.getInstance().getWidgetType(feedId);
    final videoType = event?.video.videoType;
    final liveStreamStatus = event?.video.liveStreamStatus;
    FWExampleLoggerUtil.log(
      "[Analytics] [Shopping] onCustomClickCartIcon feedId: $feedId videoId: $videoId widgetType: $widgetType videoType: $videoType liveStreamStatus: $liveStreamStatus",
      shouldCache: true,
    );
    await startFloatingPlayerOrClosePlayer();
    final showCart = await shouldShowCart();
    if (showCart) {
      globalNavigatorKey.currentState?.pushNamed('/cart');
    }
  }

  Future<List<Product>?> onUpdateProductDetails(
      UpdateProductDetailsEvent? event) async {
    final feedId = event?.video.feedId ?? "";
    final videoId = event?.video.videoId;
    final widgetType = FireworkSDK.getInstance().getWidgetType(feedId);
    final videoType = event?.video.videoType;
    final liveStreamStatus = event?.video.liveStreamStatus;
    FWExampleLoggerUtil.log(
      "[Analytics] [Shopping] onUpdateProductDetails feedId: $feedId videoId: $videoId widgetType: $widgetType videoType: $videoType liveStreamStatus: $liveStreamStatus",
      shouldCache: true,
    );
    if (event == null) {
      return null;
    }

    final showCart = await shouldShowCart();
    if (!showCart) {
      return null;
    }

    List<Product> productList = [];
    for (var productId in event.productIds) {
      final shopifyProduct =
          await ShopifyClient.getInstance().fetchProduct(productId);
      if (shopifyProduct != null) {
        final product = Product(
          productId:
              ShopifyClient.getInstance().decodeId(shopifyProduct.encodedId),
          name: shopifyProduct.title,
          description: shopifyProduct.descriptionHtml,
        );

        if (shopifyProduct.variants != null) {
          product.units = shopifyProduct.variants!.map((shopifyProductVariant) {
            final unitId = ShopifyClient.getInstance()
                .decodeId(shopifyProductVariant.encodedId);
            final unit = ProductUnit(
              unitId: unitId,
              name: shopifyProductVariant.title,
            );
            if (shopifyProductVariant.priceV2 != null) {
              final priceV2 = shopifyProductVariant.priceV2!;
              if (priceV2["amount"] is String &&
                  priceV2["currencyCode"] is String) {
                final amountDouble = num.tryParse(priceV2["amount"] as String);
                if (amountDouble != null) {
                  unit.price = ProductPrice(
                    amount: amountDouble.toDouble(),
                    currencyCode: priceV2["currencyCode"] as String,
                  );
                }
              }
            }
            return unit;
          }).toList();
        }

        productList.add(product);
      }
    }

    return productList;
  }

  Future<void> onCustomClickLinkButton(
      CustomClickLinkButtonEvent? event) async {
    final feedId = event?.video?.feedId ?? "";
    final videoId = event?.video?.videoId;
    final widgetType = FireworkSDK.getInstance().getWidgetType(feedId);
    final videoType = event?.video?.videoType;
    final liveStreamStatus = event?.video?.liveStreamStatus;
    FWExampleLoggerUtil.log(
      "[Analytics] [Shopping] onCustomClickLinkButton feedId: $feedId videoId: $videoId widgetType: $widgetType videoType: $videoType liveStreamStatus: $liveStreamStatus",
      shouldCache: true,
    );

    FWExampleLoggerUtil.log(
        "onCustomClickLinkButton original url: ${event?.url}");

    final urlInfo = FWUrlUtil.parseUrl(
      url: event?.url ?? "",
      iOSQueryName: "ios",
      androidQueryName: "android",
    );

    FWExampleLoggerUtil.log("onCustomClickLinkButton url: ${urlInfo?.url}");
    FWExampleLoggerUtil.log(
        "onCustomClickLinkButton iOS url: ${urlInfo?.iOSUrl}");
    FWExampleLoggerUtil.log(
        "onCustomClickLinkButton android url: ${urlInfo?.androidUrl}");
    await startFloatingPlayerOrClosePlayer();
    globalNavigatorKey.currentState?.pushNamed('/link_content', arguments: {
      "url": event?.url ?? '',
    });
  }

  Future<void> onCustomTapProductCard(CustomTapProductCardEvent? event) async {
    final feedId = event?.video.feedId ?? "";
    final videoId = event?.video.videoId;
    final widgetType = FireworkSDK.getInstance().getWidgetType(feedId);
    final videoType = event?.video.videoType;
    final liveStreamStatus = event?.video.liveStreamStatus;
    FWExampleLoggerUtil.log(
      "[Analytics] [Shopping] onCustomTapProductCard feedId: $feedId videoId: $videoId widgetType: $widgetType videoType: $videoType liveStreamStatus: $liveStreamStatus",
      shouldCache: true,
    );

    await startFloatingPlayerOrClosePlayer();
    globalNavigatorKey.currentState?.pushNamed('/link_content', arguments: {
      "url": event?.url ?? '',
    });
  }

  Future<void> onClickProduct(ClickProductEvent? event) async {
    final feedId = event?.video.feedId ?? "";
    final videoId = event?.video.videoId;
    final widgetType = FireworkSDK.getInstance().getWidgetType(feedId);
    final videoType = event?.video.videoType;
    final liveStreamStatus = event?.video.liveStreamStatus;
    FWExampleLoggerUtil.log(
      "[Analytics] [Shopping] onClickProduct feedId: $feedId videoId: $videoId widgetType: $widgetType videoType: $videoType liveStreamStatus: $liveStreamStatus",
      shouldCache: true,
    );
  }

  void onCustomCTAClick(CustomCTAClickEvent? event) {
    final feedId = event?.video.feedId ?? "";
    final videoId = event?.video.videoId;
    final widgetType = FireworkSDK.getInstance().getWidgetType(feedId);
    final videoType = event?.video.videoType;
    final liveStreamStatus = event?.video.liveStreamStatus;
    FWExampleLoggerUtil.log(
      "[Analytics] [CTA] onCustomCTAClick feedId: $feedId videoId: $videoId widgetType: $widgetType videoType: $videoType liveStreamStatus: $liveStreamStatus",
      shouldCache: true,
    );
    final url = event?.url ?? "";
    FWExampleLoggerUtil.log("onCustomCTAClick original url: $url");

    final urlInfo = FWUrlUtil.parseUrl(
        url: url, iOSQueryName: "ios", androidQueryName: "android");
    FWExampleLoggerUtil.log("onCustomCTAClick base url: ${urlInfo?.url}");
    FWExampleLoggerUtil.log("onCustomCTAClick iOS url: ${urlInfo?.iOSUrl}");
    FWExampleLoggerUtil.log(
        "onCustomCTAClick android url: ${urlInfo?.androidUrl}");

    startFloatingPlayerOrClosePlayer().then((_) {
      if (enablePausePlayer) {
        event?.playerHandler?.pause();
      }
      globalNavigatorKey.currentState?.pushNamed('/link_content', arguments: {
        "url": urlInfo?.url ?? '',
        "iOSUrl": urlInfo?.iOSUrl ?? '',
        "androidUrl": urlInfo?.androidUrl ?? '',
      });
    });
  }

  Future<void> onVideoPlayback(VideoPlaybackEvent? event) async {
    if (event != null) {
      final eventName = event.eventName;
      final feedId = event.info.feedId ?? "";
      final videoId = event.info.videoId;
      final widgetType = FireworkSDK.getInstance().getWidgetType(feedId);
      final duration = event.info.duration;
      final progress = event.info.progress;
      final videoType = event.info.videoType;
      final liveStreamStatus = event.info.liveStreamStatus;

      FWExampleLoggerUtil.log(
        "[Analytics] [Playback] onVideoPlayback eventName:$eventName feedId: $feedId videoId: $videoId widgetType: $widgetType duration: $duration progress: $progress videoType: $videoType liveStreamStatus: $liveStreamStatus",
        shouldCache: true,
      );
      switch (eventName) {
        case VideoPlaybackEventName.impression:

          /// When video is shown to the user.
          break;
        case VideoPlaybackEventName.start:

          /// Video started.
          break;
        case VideoPlaybackEventName.pause:

          /// Video paused.
          break;
        case VideoPlaybackEventName.resume:

          /// Video resume.
          break;
        case VideoPlaybackEventName.firstQuartile:

          /// Video reached 25%.
          break;
        case VideoPlaybackEventName.midpoint:

          /// Video reached 50%.
          break;
        case VideoPlaybackEventName.thirdQuartile:

          /// Video reached 75%.
          break;
        case VideoPlaybackEventName.complete:

          /// Video reached 100%.
          break;
        case VideoPlaybackEventName.adStart:

          /// When ad video start playing.
          break;
        case VideoPlaybackEventName.adEnd:

          /// When ad video finishes playing.
          break;
        case VideoPlaybackEventName.clickCTA:

          /// When a visitor clicks on CTA button (if available).
          break;
        case VideoPlaybackEventName.clickShare:

          /// When user clicks on "Share" button.
          break;
      }
    }
  }

  Future<void> onVideoFeedClick(VideoFeedClickEvent? event) async {
    final feedId = event?.info.feedId ?? "";
    final videoId = event?.info.id;
    final widgetType = FireworkSDK.getInstance().getWidgetType(feedId);
    final videoType = event?.info.videoType;
    final liveStreamStatus = event?.info.liveStreamStatus;

    FWExampleLoggerUtil.log(
      "onVideoFeedClick source: ${event?.info.source} feedId: $feedId videoId: $videoId widgetType: $widgetType videoType: $videoType liveStreamStatus: $liveStreamStatus",
      shouldCache: true,
    );
  }

  Future<void> onLiveStreamEvent(LiveStreamEvent? event) async {
    if (event != null) {
      final eventName = event.eventName;
      final feedId = event.info.feedId ?? "";
      final videoId = event.info.id;
      final widgetType = FireworkSDK.getInstance().getWidgetType(feedId);
      final videoType = event.info.videoType;
      final liveStreamStatus = event.info.liveStreamStatus;
      FWExampleLoggerUtil.log(
        "[Analytics] [Livestream] onLiveStreamEvent eventName: $eventName feedId: $feedId videoId: $videoId widgetType: $widgetType videoType: $videoType liveStreamStatus: $liveStreamStatus videoIdFromVideo: ${event.info.video.videoId} duration: ${event.info.video.duration} caption: ${event.info.video.caption}",
        shouldCache: true,
      );

      switch (eventName) {
        case LiveStreamEventName.userDidjoin:
          // The user joins an active live stream.
          break;
        case LiveStreamEventName.userDidLeave:
          // The user leaves an active live stream.
          break;
        case LiveStreamEventName.userSendLike:
          // The user sends a like to an active live stream.
          break;
      }
    }
  }

  Future<void> onLiveStreamChatEvent(LiveStreamChatEvent? event) async {
    if (event != null) {
      final eventName = event.eventName;
      final feedId = event.liveStream.feedId ?? "";
      final videoId = event.liveStream.id;
      final widgetType = FireworkSDK.getInstance().getWidgetType(feedId);
      final videoType = event.liveStream.videoType;
      final liveStreamStatus = event.liveStream.liveStreamStatus;
      FWExampleLoggerUtil.log(
        "[Analytics] [Livestream] onLiveStreamChatEvent eventName: $eventName feedId: $feedId videoId: $videoId widgetType: $widgetType videoType: $videoType liveStreamStatus: $liveStreamStatus videoIdFromVideo: ${event.liveStream.video.videoId} duration: ${event.liveStream.video.duration} caption: ${event.liveStream.video.caption}",
        shouldCache: true,
      );
      switch (eventName) {
        case LiveStreamChatEventName.userSendChat:
          FWExampleLoggerUtil.log(
              "onLiveStreamChatEvent userSendChat livestream videoId: ${event.liveStream.id} feedId: ${event.liveStream.feedId} widgetType: ${FireworkSDK.getInstance().getWidgetType(event.liveStream.feedId ?? "")}");
          FWExampleLoggerUtil.log(
              "onLiveStreamChatEvent userSendChat message id: ${event.message.messageId} username: ${event.message.username} text: ${event.message.text}");
          break;
      }
    }
  }

  Future<CustomShareUrlResult?> onCustomShareUrl(
      CustomShareUrlEvent? event) async {
    final feedId = event?.video.feedId ?? "";
    final videoId = event?.video.videoId;
    final widgetType = FireworkSDK.getInstance().getWidgetType(feedId);
    final videoType = event?.video.videoType;
    final liveStreamStatus = event?.video.liveStreamStatus;
    FWExampleLoggerUtil.log(
      "[Analytics] [Share] onCustomShareUrl url: ${event?.url} feedId: $feedId videoId: $videoId widgetType: $widgetType videoType: $videoType liveStreamStatus: $liveStreamStatus",
      shouldCache: true,
    );
    await Future.delayed(const Duration(seconds: 2));
    return CustomShareUrlResult(url: "${event?.url ?? ""}&custom=true");
  }

  Future<void> onCustomLinkInteractionClick(
      CustomLinkInteractionClickEvent? event) async {
    if (event != null) {
      final title = event.title;
      final url = event.url;
      final feedId = event.info.feedId ?? "";
      final videoId = event.info.id;
      final widgetType = FireworkSDK.getInstance().getWidgetType(feedId);
      final videoType = event.info.videoType;
      final liveStreamStatus = event.info.liveStreamStatus;
      FWExampleLoggerUtil.log(
        "[Analytics] [Livestream] onCustomLinkInteractionClick title: $title url: $url feedId: $feedId videoId: $videoId widgetType: $widgetType videoType: $videoType liveStreamStatus: $liveStreamStatus videoIdFromVideo: ${event.info.video.videoId} duration: ${event.info.video.duration} caption: ${event.info.video.caption}",
        shouldCache: true,
      );
      await startFloatingPlayerOrClosePlayer();
      globalNavigatorKey.currentState?.pushNamed('/link_content', arguments: {
        "url": event.url,
      });
    }
  }

  Future<void> onCustomGiveawayTermsAndConditionsClick(
      CustomGiveawayTermsAndConditionsClickEvent? event) async {
    if (event != null) {
      final name = event.name;
      final url = event.url;
      final type = event.type;
      final feedId = event.info.feedId ?? "";
      final videoId = event.info.id;
      final widgetType = FireworkSDK.getInstance().getWidgetType(feedId);
      final videoType = event.info.videoType;
      final liveStreamStatus = event.info.liveStreamStatus;
      FWExampleLoggerUtil.log(
        "[Analytics] [Livestream] onCustomGiveawayTermsAndConditionsClick name: $name type: $type url: $url feedId: $feedId videoId: $videoId widgetType: $widgetType videoType: $videoType liveStreamStatus: $liveStreamStatus videoIdFromVideo: ${event.info.video.videoId} duration: ${event.info.video.duration} caption: ${event.info.video.caption}",
        shouldCache: true,
      );
      await startFloatingPlayerOrClosePlayer();
      if (url != null && url.isNotEmpty) {
        globalNavigatorKey.currentState?.pushNamed('/link_content', arguments: {
          "url": url,
        });
      } else {
        EasyLoading.showToast(
          "Giveaway terms and conditions clicked: $name, type: $type",
          duration: const Duration(seconds: 3),
        );
      }
    }
  }

  Future<void> onInteractableEngagement(
      InteractableEngagementEvent? event) async {
    if (event != null) {
      final feedId = event.video.feedId ?? "";
      final videoId = event.video.videoId;
      final widgetType = FireworkSDK.getInstance().getWidgetType(feedId);
      final videoType = event.video.videoType;
      final liveStreamStatus = event.video.liveStreamStatus;
      FWExampleLoggerUtil.log(
        "[Analytics] [Interactable] onInteractableEngagement feedId: $feedId videoId: $videoId widgetType: $widgetType videoType: $videoType liveStreamStatus: $liveStreamStatus",
        shouldCache: true,
      );
    }
  }

  Future<void> onStoryBlockClickToFullScreen(
      StoryBlockClickToFullScreenEvent? event) async {
    if (event != null) {
      final feedId = event.video.feedId ?? "";
      final videoId = event.video.videoId;
      final widgetType = FireworkSDK.getInstance().getWidgetType(feedId);
      final videoType = event.video.videoType;
      final liveStreamStatus = event.video.liveStreamStatus;
      FWExampleLoggerUtil.log(
        "[Analytics] [StoryBlock] onStoryBlockClickToFullScreen feedId: $feedId videoId: $videoId widgetType: $widgetType videoType: $videoType liveStreamStatus: $liveStreamStatus ctaActionType: ${event.video.ctaActionType} ctaActionURL: ${event.video.ctaActionURL} progress: ${event.video.progress} duration: ${event.video.duration} playerSizeWidth: ${event.video.playerSize?.width} playerSizeHeight: ${event.video.playerSize?.height} caption: ${event.video.caption} badge: ${event.video.badge} hasCTA: ${event.video.hasCTA}",
        shouldCache: true,
      );
    }
  }

  Future<void> startFloatingPlayerOrClosePlayer() async {
    final result =
        await FireworkSDK.getInstance().navigator.startFloatingPlayer();
    FWExampleLoggerUtil.log("startFloatingPlayer result: $result");
    if (!result) {
      await FireworkSDK.getInstance().navigator.popNativeContainer();
      EasyLoading.showToast(
        "The player is closed. If PiP is disabled, it's expected. Otherwise, it's a bug.",
        duration: const Duration(
          seconds: 5,
        ),
      );
    }
  }

  Future<void> removeAllCartItems() async {
    try {
      final cacheFile = await _cartItemsCacheFile;
      await cacheFile.delete();
    } catch (e) {
      FWExampleLoggerUtil.log("removeAllCartItems e $e");
    }

    FireworkSDK.getInstance().shopping.setCartItemCount(0);
    FWEventBus.getInstance().fire(
      FWEvent(
        eventName: FWExampleEventName.cartItemCountUpdateEvent,
        arguments: <String, dynamic>{
          "count": 0,
        },
      ),
    );
  }

  Future<List<CartItem>> getAllCartItems() async {
    try {
      FWExampleLoggerUtil.log("before _cacheFile");
      final cacheFile = await _cartItemsCacheFile;
      FWExampleLoggerUtil.log("after _cacheFile");
      final contents = await cacheFile.readAsString();
      FWExampleLoggerUtil.log("after readAsString");

      FWExampleLoggerUtil.log(
          "getAllCartItems contents $contents length: ${contents.length}");
      if (contents.isNotEmpty) {
        final cachedCartItemJsonList = jsonDecode(contents) as List<dynamic>;
        FWExampleLoggerUtil.log(
            "getAllCartItems cachedCartItemJsonList $cachedCartItemJsonList ${cachedCartItemJsonList.runtimeType}");
        final cartItemList =
            List<Map<String, dynamic>>.from(cachedCartItemJsonList)
                .map(
                  (e) => CartItem.fromJson(e),
                )
                .toList();
        return cartItemList;
      }
    } catch (e) {
      FWExampleLoggerUtil.log("getAllCartItems e $e");
    }

    return [];
  }

  Future<void> _addCartItem(CartItem item) async {
    final cartItemList = await getAllCartItems();

    final foundItemList = cartItemList.where(
      (e) => e.productId == item.productId && e.unitId == item.unitId,
    );

    if (foundItemList.isNotEmpty) {
      CartItem foundItem = foundItemList.first;
      cartItemList.removeWhere(
        (e) => e.productId == item.productId && e.unitId == item.unitId,
      );
      item.quantity = (foundItem.quantity ?? 1) + 1;
    } else {
      item.quantity = 1;
    }

    cartItemList.add(item);

    final cartItemJsonList = cartItemList.map((e) => e.toJson()).toList();
    FWExampleLoggerUtil.log("addCartItem cartItemJsonList $cartItemJsonList");

    try {
      String jsonString = jsonEncode(cartItemJsonList);
      final cacheFile = await _cartItemsCacheFile;
      await cacheFile.writeAsString(jsonString);

      FireworkSDK.getInstance().shopping.setCartItemCount(cartItemList.length);
      FWEventBus.getInstance().fire(
        FWEvent(
          eventName: FWExampleEventName.cartItemCountUpdateEvent,
          arguments: <String, dynamic>{
            "count": cartItemList.length,
          },
        ),
      );
    } catch (e) {
      FWExampleLoggerUtil.log("addCartItem e $e");
    }
  }

  Future<bool> shouldShowCart() async {
    return ShopifyClient.getInstance().creatClientSuccessfully();
  }

  List<AppLanguageInfo> getAppLanguageInfoList() {
    return [
      AppLanguageInfo(
        languageCode: 'en',
        displayName: 'English',
      ),
      AppLanguageInfo(
        languageCode: 'ar',
        displayName: 'Arabic',
      ),
      AppLanguageInfo(
        languageCode: 'ar-SA',
        displayName: 'Arabic (Saudi Arabia)',
      ),
      AppLanguageInfo(
        languageCode: 'ar-AE',
        displayName: 'Arabic (United Arab Emirates)',
      ),
      AppLanguageInfo(
        languageCode: 'de',
        displayName: 'German',
      ),
      AppLanguageInfo(
        languageCode: 'it',
        displayName: 'Italian',
      ),
      AppLanguageInfo(
        languageCode: 'ja',
        displayName: 'Japanese',
      ),
      AppLanguageInfo(
        languageCode: 'pl',
        displayName: 'Polish',
      ),
      AppLanguageInfo(
        languageCode: 'pt-BR',
        displayName: 'Portuguese (Brazil)',
      ),
      AppLanguageInfo(
        languageCode: 'ru',
        displayName: 'Russian',
      ),
      AppLanguageInfo(
        languageCode: 'es',
        displayName: 'Spanish',
      ),
      AppLanguageInfo(
        languageCode: 'es-MX',
        displayName: 'Spanish (Mexico)',
      ),
      AppLanguageInfo(
        languageCode: 'es-CO',
        displayName: 'Spanish (Colombia)',
      ),
      AppLanguageInfo(
        languageCode: 'vi',
        displayName: 'Vietnamese',
      ),
      AppLanguageInfo(
        languageCode: 'th',
        displayName: 'Thai',
      ),
      AppLanguageInfo(
        languageCode: 'hu',
        displayName: 'Hungarian',
      ),
      AppLanguageInfo(
        languageCode: 'tr',
        displayName: 'Turkish',
      ),
      AppLanguageInfo(
        languageCode: 'fr',
        displayName: 'French',
      ),
      AppLanguageInfo(
        languageCode: 'pt',
        displayName: 'Portuguese',
      ),
      AppLanguageInfo(
        languageCode: 'id',
        displayName: 'Indonesian',
      ),
      AppLanguageInfo(
        languageCode: 'sv',
        displayName: 'Swedish',
      ),
      AppLanguageInfo(
        languageCode: 'ro',
        displayName: 'Romanian',
      ),
      AppLanguageInfo(
        languageCode: 'zh-Hant',
        displayName: 'Chinese (Traditional)',
      ),
      AppLanguageInfo(
        languageCode: 'zh-TW',
        displayName: 'Chinese (Traditional, Taiwan)',
      ),
      AppLanguageInfo(
        languageCode: null,
        displayName: 'System',
      ),
    ];
  }

  Future<void> cacheAppLanguageInfo(AppLanguageInfo appLanguageInfo) async {
    try {
      String jsonString = jsonEncode(appLanguageInfo.toJson());
      final cacheFile = await _appLanguageInfoCacheFile;
      await cacheFile.writeAsString(jsonString);
      await FireworkSDK.getInstance()
          .changeAppLanguage(appLanguageInfo.languageCode);
      FWEventBus.getInstance().fire(
        FWEvent(
          eventName: FWExampleEventName.appLanguageUpdateEvent,
          arguments: appLanguageInfo.toJson(),
        ),
      );
    } catch (e) {
      FWExampleLoggerUtil.log("cacheAppLanguageInfo e $e");
    }
  }

  Future<AppLanguageInfo> getCacheAppLanguageInfo() async {
    try {
      final cacheFile = await _appLanguageInfoCacheFile;
      final contents = await cacheFile.readAsString();
      if (contents.isNotEmpty) {
        final cachedAppLanguageInfoJson =
            jsonDecode(contents) as Map<dynamic, dynamic>;
        return AppLanguageInfo.fromJson(
          Map<String, dynamic>.from(cachedAppLanguageInfoJson),
        );
      }
    } catch (e) {
      FWExampleLoggerUtil.log("getCacheAppLanguageInfo e $e");
    }

    return AppLanguageInfo(languageCode: null, displayName: 'System');
  }

  Future<void> cacheDataTrackingLevel(
      DataTrackingLevel dataTrackingLevel) async {
    try {
      final cacheFile = await _dataTrackingLevelCacheFile;
      await cacheFile.writeAsString(dataTrackingLevel.name);
      FireworkSDK.getInstance().dataTrackingLevel = dataTrackingLevel;
    } catch (e) {
      FWExampleLoggerUtil.log("cacheDataTrackingLevel e $e");
    }
  }

  Future<DataTrackingLevel?> getCacheDataTrackingLevel() async {
    try {
      final cacheFile = await _dataTrackingLevelCacheFile;
      final contents = await cacheFile.readAsString();
      return DataTrackingLevel.values.asNameMap()[contents];
    } catch (e) {
      FWExampleLoggerUtil.log("getCacheDataTrackingLevel e $e");
    }

    return null;
  }

  Future<void> cacheLivestreamPlayerVersion(
      LivestreamPlayerDesignVersion playerVersion) async {
    try {
      final cacheFile = await _livestreamPlayerVersionCacheFile;
      await cacheFile.writeAsString(playerVersion.name);
      FireworkSDK.getInstance().livestreamPlayerDesignVersion = playerVersion;
    } catch (e) {
      FWExampleLoggerUtil.log("cacheLivestreamPlayerVersion e $e");
    }
  }

  Future<LivestreamPlayerDesignVersion?> getLivestreamPlayerVersion() async {
    try {
      final cacheFile = await _livestreamPlayerVersionCacheFile;
      final contents = await cacheFile.readAsString();
      return LivestreamPlayerDesignVersion.values.asNameMap()[contents];
    } catch (e) {
      FWExampleLoggerUtil.log("getLivestreamPlayerVersion e $e");
    }

    return null;
  }

  Future<void> cacheShortVideoPlayerVersion(
      ShortVideoPlayerDesignVersion playerVersion) async {
    try {
      final cacheFile = await _shortVideoPlayerVersionCacheFile;
      await cacheFile.writeAsString(playerVersion.name);
      FireworkSDK.getInstance().shortVideoPlayerDesignVersion = playerVersion;
    } catch (e) {
      FWExampleLoggerUtil.log("cacheShortVideoPlayerVersion e $e");
    }
  }

  Future<ShortVideoPlayerDesignVersion?> getShortVideoPlayerVersion() async {
    try {
      final cacheFile = await _shortVideoPlayerVersionCacheFile;
      final contents = await cacheFile.readAsString();
      return ShortVideoPlayerDesignVersion.values.asNameMap()[contents];
    } catch (e) {
      FWExampleLoggerUtil.log("getShortVideoPlayerVersion e $e");
    }

    return null;
  }

  Future<File> get _cartItemsCacheFile async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/fw_example_cart_items.json");
    final exist = await file.exists();

    FWExampleLoggerUtil.log("_cartItemsCacheFile exist $exist");

    if (!exist) {
      return await file.create(recursive: true);
    } else {
      return file;
    }
  }

  Future<File> get _appLanguageInfoCacheFile async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/fw_example_app_language_info.json");
    final exist = await file.exists();

    FWExampleLoggerUtil.log("_appLanguageInfoCacheFile exist $exist");

    if (!exist) {
      return await file.create(recursive: true);
    } else {
      return file;
    }
  }

  Future<File> get _dataTrackingLevelCacheFile async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/fw_data_tracking_level.txt");
    final exist = await file.exists();

    FWExampleLoggerUtil.log("_dataTrackingLevelCacheFile exist $exist");

    if (!exist) {
      return await file.create(recursive: true);
    } else {
      return file;
    }
  }

  Future<File> get _livestreamPlayerVersionCacheFile async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/fw_livestream_player_version.txt");
    final exist = await file.exists();

    FWExampleLoggerUtil.log("_livestreamPlayerVersionCacheFile exist $exist");

    if (!exist) {
      return await file.create(recursive: true);
    } else {
      return file;
    }
  }

  Future<File> get _shortVideoPlayerVersionCacheFile async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/fw_short_video_player_version.txt");
    final exist = await file.exists();

    FWExampleLoggerUtil.log("_shortVideoPlayerVersionCacheFile exist $exist");

    if (!exist) {
      return await file.create(recursive: true);
    } else {
      return file;
    }
  }
}
