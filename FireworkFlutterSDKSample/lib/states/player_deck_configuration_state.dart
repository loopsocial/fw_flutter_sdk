import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:flutter/material.dart';

class PlayerDeckConfigurationState extends ChangeNotifier {
  PlayerDeckConfiguration _playerDeckConfiguration = PlayerDeckConfiguration();

  PlayerDeckConfiguration get playerDeckConfiguration =>
      _playerDeckConfiguration;

  set playerDeckConfiguration(PlayerDeckConfiguration config) {
    _playerDeckConfiguration = config;
    notifyListeners();
  }

  void reset() {
    _playerDeckConfiguration = PlayerDeckConfiguration();
    notifyListeners();
  }
}
