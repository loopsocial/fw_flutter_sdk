import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:flutter/material.dart';

class StoryBlockConfigurationState extends ChangeNotifier {
  static StoryBlockConfiguration _getDefaultConfiguration() {
    return StoryBlockConfiguration(
      playerStyle: VideoPlayerStyle.full,
      showShareButton: true,
      showPlaybackButton: true,
      showMuteButton: true,
      showBranding: true,
      videoCompleteAction: VideoPlayerCompleteAction.advanceToNext,
      ctaDelay:
          VideoPlayerCTADelay(type: VideoPlayerCTADelayType.constant, value: 3),
      ctaHighlightDelay:
          VideoPlayerCTADelay(type: VideoPlayerCTADelayType.constant, value: 3),
      ctaWidth: VideoPlayerCTAWidth.fullWidth,
      showVideoDetailTitle: true,
    );
  }

  StoryBlockConfiguration _storyBlockConfiguration = _getDefaultConfiguration();

  StoryBlockConfiguration get storyBlockConfiguration =>
      _storyBlockConfiguration;

  set storyBlockConfiguration(StoryBlockConfiguration storyBlockConfiguration) {
    _storyBlockConfiguration = storyBlockConfiguration;
    notifyListeners();
  }

  void reset() {
    _storyBlockConfiguration = _getDefaultConfiguration();
    notifyListeners();
  }
}
