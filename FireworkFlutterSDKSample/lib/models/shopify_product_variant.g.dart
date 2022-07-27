// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopify_product_variant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopifyProductVariant _$ShopifyProductVariantFromJson(
        Map<String, dynamic> json) =>
    ShopifyProductVariant(
      encodedId: json['id'] as String,
    )
      ..title = json['title'] as String?
      ..image = json['image'] as Map<String, dynamic>?
      ..priceV2 = json['priceV2'] as Map<String, dynamic>?
      ..selectedOptions = (json['selectedOptions'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList();

Map<String, dynamic> _$ShopifyProductVariantToJson(
        ShopifyProductVariant instance) =>
    <String, dynamic>{
      'id': instance.encodedId,
      'title': instance.title,
      'image': instance.image,
      'priceV2': instance.priceV2,
      'selectedOptions': instance.selectedOptions,
    };
