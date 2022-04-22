import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:flutter/material.dart';

class ProductInfoViewConfigurationState extends ChangeNotifier {
  ProductInfoViewConfiguration _productInfoViewConfiguration =
      ProductInfoViewConfiguration();

  ProductInfoViewConfiguration get productInfoViewConfiguration =>
      _productInfoViewConfiguration;

  set productInfoViewConfiguration(
      ProductInfoViewConfiguration productInfoViewConfiguration) {
    _productInfoViewConfiguration = productInfoViewConfiguration;
    notifyListeners();
  }

  void reset() {
    productInfoViewConfiguration = ProductInfoViewConfiguration();
  }
}
