import 'dart:convert';
import 'dart:io';

import 'package:fw_flutter_sdk_example/constants/fw_example_event_name.dart';
import 'package:fw_flutter_sdk_example/models/app_language_info.dart';
import 'package:fw_flutter_sdk_example/models/cart_item.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/utils/fw_example_logger_util.dart';
import 'package:fw_flutter_sdk_example/utils/shopify_client.dart';

import '../my_app.dart';

class HostAppService {
  static HostAppService? _instance;

  static HostAppService _getInstance() {
    _instance ??= HostAppService._();
    return _instance!;
  }

  bool enablePausePlayer = false;

  HostAppService._();

  factory HostAppService.getInstance() => _getInstance();

  Future<ShoppingCTAResult?> onShopNow(ShoppingCTAEvent? event) async {
    FWExampleLoggerUtil.log("onAddToCart feedId: ${event?.video.feedId}");

    if (event == null) {
      return null;
    }

    await closePlayerOrStartFloatingPlayer();

    globalNavigatorKey.currentState?.pushNamed('/link_content', arguments: {
      "url": event.url,
    });

    await event.ctaHandler?.complete(
      ShoppingCTAResult(
        res: ShoppingCTARes.success,
      ),
    );

    return null;
  }

  Future<ShoppingCTAResult?> onAddToCart(ShoppingCTAEvent? event) async {
    FWExampleLoggerUtil.log("onAddToCart feedId: ${event?.video.feedId}");

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

  Future<void> onCustomClickCartIcon(event) async {
    FWExampleLoggerUtil.log(
        "onCustomClickCartIcon feedId: ${event?.video.feedId}");

    await closePlayerOrStartFloatingPlayer();
    final showCart = await shouldShowCart();
    if (showCart) {
      globalNavigatorKey.currentState?.pushNamed('/cart');
    }
  }

  Future<List<Product>?> onUpdateProductDetails(
      UpdateProductDetailsEvent? event) async {
    FWExampleLoggerUtil.log(
        "onUpdateProductDetails feedId: ${event?.video.feedId}");

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
    await closePlayerOrStartFloatingPlayer();
    globalNavigatorKey.currentState?.pushNamed('/link_content', arguments: {
      "url": event?.url ?? '',
    });
  }

  Future<void> onCustomTapProductCard(CustomTapProductCardEvent? event) async {
    await closePlayerOrStartFloatingPlayer();
    FWExampleLoggerUtil.log(
      "onCustomTapProductCard event?.url ${event?.url}",
    );
    globalNavigatorKey.currentState?.pushNamed('/link_content', arguments: {
      "url": event?.url ?? '',
    });
  }

  void onCustomCTAClick(CustomCTAClickEvent? event) {
    FWExampleLoggerUtil.log("onCustomCTAClick feedId ${event?.video.feedId}");

    closePlayerOrStartFloatingPlayer().then((_) {
      if (enablePausePlayer) {
        event?.playerHandler?.pause();
      }
      globalNavigatorKey.currentState?.pushNamed('/link_content', arguments: {
        "url": event?.url ?? '',
      });
    });
  }

  Future<void> closePlayerOrStartFloatingPlayer() async {
    final result =
        await FireworkSDK.getInstance().navigator.startFloatingPlayer();
    if (!result) {
      await FireworkSDK.getInstance().navigator.popNativeContainer();
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
        language: 'en',
        displayName: 'English',
      ),
      AppLanguageInfo(
        language: 'ar',
        displayName: 'Arabic',
      ),
      AppLanguageInfo(
        language: 'ja',
        displayName: 'Japanese',
      ),
      AppLanguageInfo(
        language: 'pt-BR',
        displayName: 'Portuguese (Brazil)',
      ),
      AppLanguageInfo(
        language: null,
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
          .changeAppLanguage(appLanguageInfo.language);
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
      FWExampleLoggerUtil.log("cacheAppLanguageInfo e $e");
    }

    return AppLanguageInfo(language: null, displayName: 'System');
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
}
