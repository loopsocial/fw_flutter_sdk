import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:flutter/material.dart';

class CircleStoryConfigurationState extends ChangeNotifier {
  static CircleStoryConfiguration _getDefaultConfiguration() {
    return CircleStoryConfiguration(
      backgroundColor: "#F5F5F5",
      enableAutoplay: true,
      showAdBadge: true,
      playIcon: VideoFeedPlayIconConfiguration(),
    );
  }

  CircleStoryConfiguration _circleStoryConfiguration = _getDefaultConfiguration();

  CircleStoryConfiguration get circleStoryConfiguration => _circleStoryConfiguration;

  set circleStoryConfiguration(CircleStoryConfiguration circleStoryConfiguration) {
    _circleStoryConfiguration = circleStoryConfiguration;
    notifyListeners();
  }

  void reset() {
    _circleStoryConfiguration = _getDefaultConfiguration();
    notifyListeners();
  }
}
