import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:flutter/material.dart';

class FeedConfigurationState extends ChangeNotifier {
  VideoFeedConfiguration _feedConfiguration = VideoFeedConfiguration(
    titlePosition: VideoFeedTitlePosition.nested,
    title: VideoFeedTitleConfiguration(
      hidden: false,
    ),
  );

  VideoFeedConfiguration get feedConfiguration => _feedConfiguration;

  set feedConfiguration(VideoFeedConfiguration feedConfiguration) {
    _feedConfiguration = feedConfiguration;
    notifyListeners();
  }

  void reset() {
    _feedConfiguration = VideoFeedConfiguration(
      titlePosition: VideoFeedTitlePosition.nested,
      title: VideoFeedTitleConfiguration(
        hidden: false,
      ),
    );
    notifyListeners();
  }
}
