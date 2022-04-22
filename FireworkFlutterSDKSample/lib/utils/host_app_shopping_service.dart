import 'dart:convert';
import 'dart:io';

import 'package:fw_flutter_sdk_example/constants/fw_example_event_name.dart';
import 'package:fw_flutter_sdk_example/models/cart_item.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/utils/fw_example_logger_util.dart';
import 'package:fw_flutter_sdk_example/utils/shopify_client.dart';
import '../states/product_info_view_configuration_state.dart';

class HostAppShoppingService {
  static HostAppShoppingService? _instance;
  ProductInfoViewConfigurationState configState =
      ProductInfoViewConfigurationState();

  static HostAppShoppingService _getInstance() {
    _instance ??= HostAppShoppingService._();
    return _instance!;
  }

  HostAppShoppingService._();

  factory HostAppShoppingService.getInstance() => _getInstance();

  Future<AddToCartResult> onAddToCart(AddToCartEvent? event) async {
    if (event == null) {
      return AddToCartResult(
        res: AddToCartResponse.fail,
        tips: "Fail to add to cart",
      );
    }

    try {
      final shopifyProduct =
          await ShopifyClient.getInstance().fetchProduct(event.productId);
      FWExampleLoggerUtil.log(
          "fetchProduct $shopifyProduct ${shopifyProduct?.encodedId} ${shopifyProduct?.variants?.first.encodedId}");
      if (shopifyProduct == null) {
        return AddToCartResult(
          res: AddToCartResponse.fail,
          tips: "Fail to add to cart",
        );
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
        return AddToCartResult(
          res: AddToCartResponse.fail,
          tips: "Unable to locate the selected variant",
        );
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
        if (image["originalSrc"] is String) {
          cartItem.imageURL = image["originalSrc"] as String;
        }
      }
      await addCartItem(cartItem);

      return AddToCartResult(
        res: AddToCartResponse.success,
        tips: "Add to cart successfully",
      );
    } catch (e) {
      FWExampleLoggerUtil.log("fetchProduct error: $e");
      return AddToCartResult(
        res: AddToCartResponse.fail,
        tips: "Fail to add to cart",
      );
    }
  }

  Future<List<Product>?> onUpdateProductDetails(
      UpdateProductDetailsEvent? event) async {
    if (event == null) {
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
            final unit = ProductUnit(
              unitId: ShopifyClient.getInstance()
                  .decodeId(shopifyProductVariant.encodedId),
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

  Future<ProductInfoViewConfiguration?> onWillDisplayProduct(
      WillDisplayProductEvent? event) async {
    return configState.productInfoViewConfiguration;
  }

  Future<void> addCartItem(CartItem item) async {
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
      final cacheFile = await _cacheFile;
      await cacheFile.writeAsString(jsonString);
    } catch (e) {
      FWExampleLoggerUtil.log("addCartItem e $e");
    }

    FireworkSDK.getInstance().shopping.setCartItemCount(cartItemList.length);
    FWEventBus.getInstance().fire(
      FWEvent(
        eventName: FWExampleEventName.cartItemCountUpdateEvent,
        arguments: <String, dynamic>{
          "count": cartItemList.length,
        },
      ),
    );
  }

  Future<void> removeAllCartItems() async {
    try {
      final cacheFile = await _cacheFile;
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
      final cacheFile = await _cacheFile;
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

  Future<File> get _cacheFile async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/fw_example_cart_items.json");
    final exist = await file.exists();

    FWExampleLoggerUtil.log("_cacheFile exist $exist");

    if (!exist) {
      return await file.create(recursive: true);
    } else {
      return file;
    }
  }
}
