// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopify_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopifyProduct _$ShopifyProductFromJson(Map<String, dynamic> json) =>
    ShopifyProduct(
      encodedId: json['id'] as String,
    )
      ..title = json['title'] as String?
      ..descriptionHtml = json['descriptionHtml'] as String?;

Map<String, dynamic> _$ShopifyProductToJson(ShopifyProduct instance) =>
    <String, dynamic>{
      'id': instance.encodedId,
      'title': instance.title,
      'descriptionHtml': instance.descriptionHtml,
    };
