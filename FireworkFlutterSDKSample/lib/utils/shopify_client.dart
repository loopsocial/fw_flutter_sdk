import 'dart:async';
import 'dart:convert';

import 'package:fw_flutter_sdk_example/models/shopify_product.dart';
import 'package:fw_flutter_sdk_example/models/shopify_product_variant.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';

import 'fw_example_logger_util.dart';

class ShopifyClient {
  static ShopifyClient? _instance;
  final Completer<Dio> _dioCompleter = Completer<Dio>();

  static ShopifyClient _getInstance() {
    _instance ??= ShopifyClient._();
    return _instance!;
  }

  ShopifyClient._() {
    _readConfig();
  }

  factory ShopifyClient.getInstance() => _getInstance();

  Dio _createDio({
    required String shopifyDomain,
    required String shopifyStorefrontAccessToken,
  }) {
    final dio = Dio();
    dio.options.baseUrl = "https://$shopifyDomain/api/2022-01";
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          FWExampleLoggerUtil.log(
              'ShopifyClient send request：path:${options.path}，baseURL:${options.baseUrl}');

          options.headers["Content-Type"] = "application/graphql";
          options.headers["X-Shopify-Storefront-Access-Token"] =
              shopifyStorefrontAccessToken;
          handler.next(options);
        },
      ),
    );

    return dio;
  }

  Future<ShopifyProduct?> fetchProduct(String productId) async {
    try {
      final dio = await _dioCompleter.future;
      final body = """
query {
  product(id:"gid://shopify/Product/$productId")
  {
    variants(first:250){
      edges{
        node{
          id,
          title,
          availableForSale,
          image { src },
          priceV2 { amount, currencyCode }
          selectedOptions { name, value }
        }
      }
    },
    availableForSale,
    descriptionHtml,
    title,
    id
  }
}
""";
      final response = await dio.post(
        '/graphql.json',
        data: body,
      );
      FWExampleLoggerUtil.log(
          "fetchProduct Response status: ${response.statusCode}");
      final resData = response.data as Map<String, dynamic>;
      final productJson = (resData["data"] as Map<String, dynamic>)["product"];
      ShopifyProduct shopifyProduct = ShopifyProduct.fromJson(productJson);
      if (productJson["variants"]["edges"] is List<dynamic>) {
        shopifyProduct.variants =
            (productJson["variants"]["edges"] as List<dynamic>)
                .map(
                  (e) => ShopifyProductVariant.fromJson(
                      e["node"] as Map<String, dynamic>),
                )
                .toList();
      }

      return shopifyProduct;
    } catch (e) {
      FWExampleLoggerUtil.log("ShopifyClient fetchProduct error: $e");
      return null;
    }
  }

  String decodeId(String encodedId) {
    String resultDecodedGid = encodedId;
    try {
      final decodedGid = utf8.decode(base64Decode(encodedId));
      resultDecodedGid = decodedGid;
    } catch (e) {
      FWExampleLoggerUtil.log('decode id $e encodedId: $encodedId');
    }
    final splitArray = resultDecodedGid.split('/');
    if (splitArray.isNotEmpty) {
      final resultId = splitArray.last;

      return resultId;
    }
    return "";
  }

  Future<bool> creatClientSuccessfully() async {
    try {
      await _dioCompleter.future;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> _readConfig() async {
    try {
      final String response =
          await rootBundle.loadString('lib/assets/shopify.json');
      final jsonData = await json.decode(response);

      FWExampleLoggerUtil.log(
          "shopify.json jsonData: $jsonData jsonData.runtimeType: ${jsonData.runtimeType}");
      if (jsonData is Map<String, dynamic>) {
        if (jsonData["shopifyDomain"] is String &&
            jsonData["shopifyStorefrontAccessToken"] is String) {
          final shopifyDomain = jsonData["shopifyDomain"] as String;
          final shopifyStorefrontAccessToken =
              jsonData["shopifyStorefrontAccessToken"] as String;
          if (shopifyDomain.isNotEmpty &&
              shopifyStorefrontAccessToken.isNotEmpty) {
            final dio = _createDio(
              shopifyDomain: shopifyDomain,
              shopifyStorefrontAccessToken: shopifyStorefrontAccessToken,
            );
            _dioCompleter.complete(dio);
          }
        }
      }
    } catch (e) {
      FWExampleLoggerUtil.log("ShopifyClient _readConfig error: $e");
    }

    if (!_dioCompleter.isCompleted) {
      _dioCompleter.completeError("Fail to creat client");
    }
  }
}
