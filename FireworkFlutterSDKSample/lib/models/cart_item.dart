import 'package:json_annotation/json_annotation.dart';

part 'cart_item.g.dart';

@JsonSerializable()
class CartItem {
  String productId;
  String unitId;
  String? title;
  String? subTitle;
  String? amount;
  String? currencyCode;
  String? description;
  String? imageURL;
  int? quantity;

  CartItem({
    required this.productId,
    required this.unitId,
    this.title,
    this.subTitle,
    this.amount,
    this.currencyCode,
    this.description,
    this.imageURL,
    this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
