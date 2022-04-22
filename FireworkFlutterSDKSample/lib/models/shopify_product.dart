import 'package:json_annotation/json_annotation.dart';

import 'shopify_product_variant.dart';
part 'shopify_product.g.dart';

@JsonSerializable()
class ShopifyProduct {
  @JsonKey(name: "id")
  String encodedId;

  String? title;
  String? descriptionHtml;

  @JsonKey(
    ignore: true,
  )
  List<ShopifyProductVariant>? variants;

  ShopifyProduct({
    required this.encodedId,
  });

  factory ShopifyProduct.fromJson(Map<String, dynamic> json) =>
      _$ShopifyProductFromJson(json);

  Map<String, dynamic> toJson() => _$ShopifyProductToJson(this);
}
