// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      productId: json['productId'] as String,
      unitId: json['unitId'] as String,
      title: json['title'] as String?,
      subTitle: json['subTitle'] as String?,
      amount: json['amount'] as String?,
      currencyCode: json['currencyCode'] as String?,
      description: json['description'] as String?,
      imageURL: json['imageURL'] as String?,
      quantity: json['quantity'] as int?,
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'productId': instance.productId,
      'unitId': instance.unitId,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'amount': instance.amount,
      'currencyCode': instance.currencyCode,
      'description': instance.description,
      'imageURL': instance.imageURL,
      'quantity': instance.quantity,
    };
