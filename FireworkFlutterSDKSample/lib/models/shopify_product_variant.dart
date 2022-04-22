import 'package:json_annotation/json_annotation.dart';
part 'shopify_product_variant.g.dart';

@JsonSerializable()
class ShopifyProductVariant {
  @JsonKey(name: "id")
  String encodedId;

  String? title;
  Map<String, dynamic>? image;
  Map<String, dynamic>? priceV2;

  ShopifyProductVariant({
    required this.encodedId,
  });

  factory ShopifyProductVariant.fromJson(Map<String, dynamic> json) =>
      _$ShopifyProductVariantFromJson(json);

  Map<String, dynamic> toJson() => _$ShopifyProductVariantToJson(this);
}
