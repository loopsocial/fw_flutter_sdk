import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:flutter/material.dart';

class StoryBlockConfigurationState extends ChangeNotifier {
  static StoryBlockConfiguration _getDefaultConfiguration() {
    return StoryBlockConfiguration(
      playerStyle: VideoPlayerStyle.full,
      scrollDirection: VideoPlayerScrollDirection.horizontal,
      enableScrollForVertical: false,
      showShareButton: true,
      showPlaybackButton: true,
      showMuteButton: true,
      showBranding: true,
      videoCompleteAction: VideoPlayerCompleteAction.advanceToNext,
      ctaDelay:
          VideoPlayerCTADelay(type: VideoPlayerCTADelayType.constant, value: 3),
      ctaHighlightDelay:
          VideoPlayerCTADelay(type: VideoPlayerCTADelayType.constant, value: 3),
      ctaButtonStyle: VideoPlayerCTAStyle(shape: ButtonShape.roundRectangle),
      ctaWidth: VideoPlayerCTAWidth.fullWidth,
      showVideoDetailTitle: true,
      countdownTimerConfiguration: CountdownTimerConfiguration(
        isHidden: false,
        appearance: CountdownTimerAppearanceMode.dark,
      ),
      actionButtonStyle:
          VideoPlayerActionButtonStyle(shape: ButtonShape.roundRectangle),
      cancelButtonStyle:
          VideoPlayerActionButtonStyle(shape: ButtonShape.roundRectangle),
      enableAutoplay: true,
      enableAutopause: false,
      enableFullScreen: true,
      enableSmallSizeInCompact: false,
      horizontalLayout: VideoPlayerHorizontalLayoutConfiguration(
        isEnabled: false,
      ),
      chatStyle: ChatStyle(
        textColor: null,
        textShadow: null,
      ),
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
