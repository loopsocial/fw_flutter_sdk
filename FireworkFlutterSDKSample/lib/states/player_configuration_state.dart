import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:flutter/material.dart';

class PlayerConfigurationState extends ChangeNotifier {
  VideoPlayerConfiguration _playerConfiguration = VideoPlayerConfiguration(
    playerStyle: VideoPlayerStyle.full,
    showShareButton: true,
    showMuteButton: true,
    showPlaybackButton: true,
    videoCompleteAction: VideoPlayerCompleteAction.advanceToNext,
  );

  VideoPlayerConfiguration get playerConfiguration => _playerConfiguration;

  set playerConfiguration(VideoPlayerConfiguration playerConfiguration) {
    _playerConfiguration = playerConfiguration;
    notifyListeners();
  }

  void reset() {
    _playerConfiguration = VideoPlayerConfiguration(
      playerStyle: VideoPlayerStyle.full,
      showShareButton: true,
      showMuteButton: true,
      showPlaybackButton: true,
      videoCompleteAction: VideoPlayerCompleteAction.advanceToNext,
    );
    notifyListeners();
  }
}
