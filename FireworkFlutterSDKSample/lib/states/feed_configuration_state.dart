import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:flutter/material.dart';

class FeedConfigurationState extends ChangeNotifier {
  static VideoFeedConfiguration _getDefaultConfiguration() {
    return VideoFeedConfiguration(
      titlePosition: VideoFeedTitlePosition.nested,
      title: VideoFeedTitleConfiguration(
        hidden: false,
        fontSize: 12,
      ),
      showAdBadge: true,
      playIcon: VideoFeedPlayIconConfiguration(),
      itemSpacing: 10,
    );
  }

  VideoFeedConfiguration _feedConfiguration = _getDefaultConfiguration();

  VideoFeedConfiguration get feedConfiguration => _feedConfiguration;

  set feedConfiguration(VideoFeedConfiguration feedConfiguration) {
    _feedConfiguration = feedConfiguration;
    notifyListeners();
  }

  AdConfiguration _adConfiguration = AdConfiguration(
    adsFetchTimeout: 20,
  );

  AdConfiguration get adConfiguration => _adConfiguration;

  set adConfiguration(AdConfiguration adConfiguration) {
    _adConfiguration = adConfiguration;
    notifyListeners();
  }

  void reset() {
    _feedConfiguration = _getDefaultConfiguration();
    notifyListeners();
  }
}
