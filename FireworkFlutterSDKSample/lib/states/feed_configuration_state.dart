import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:flutter/material.dart';

class FeedConfigurationState extends ChangeNotifier {
  VideoFeedConfiguration _feedConfiguration = VideoFeedConfiguration(
    titlePosition: VideoFeedTitlePosition.nested,
    title: VideoFeedTitleConfiguration(
      hidden: false,
    ),
    showAdBadge: true,
    enablePictureInPicture: true,
  );

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
    _feedConfiguration = VideoFeedConfiguration(
      titlePosition: VideoFeedTitlePosition.nested,
      title: VideoFeedTitleConfiguration(
        hidden: false,
      ),
      showAdBadge: true,
      enablePictureInPicture: true,
    );
    _adConfiguration = AdConfiguration(
      adsFetchTimeout: 20,
    );
    notifyListeners();
  }
}
