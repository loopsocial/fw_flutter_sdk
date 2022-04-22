import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';

import '../utils/fw_example_logger_util.dart';

extension SDKInitEventExtension on SDKInitEvent {
  void logMessage() {
    if (error == null) {
      FWExampleLoggerUtil.log("The SDK was initialized successfully.");
    } else {
      FWExampleLoggerUtil.log("Failed to initialize sdk. The error is $error.");
    }
  }
}

extension CustomCTAClickEventExtension on CustomCTAClickEvent {
  void logMessage() {
    FWExampleLoggerUtil.log("onCustomCTAClick url: $url");
  }
}

extension VideoPlaybackEventExtension on VideoPlaybackEvent {
  void logMessage() {
    final videoId = info.videoId;
    final duration = info.duration;
    final caption = info.caption;
    final badge = info.badge;
    final playerWidth = info.playerSize?.width;
    final playerHeight = info.playerSize?.height;
    final hasCTA = info.hasCTA;

    FWExampleLoggerUtil.log("""onVideoPlayback eventName: $eventName 
videoId: $videoId 
duration: $duration 
caption: $caption 
badge: $badge 
playerWidth:$playerWidth 
playerHeight: $playerHeight 
hasCTA: $hasCTA""");
  }
}

extension VideoFeedClickEventExtension on VideoFeedClickEvent {
  void logMessage() {
    final id = info.id;
    final duration = info.duration;
    final index = info.index;
    final source = info.source;

    FWExampleLoggerUtil.log("""onVideoFeedClick id: $id 
duration: $duration 
index: $index
source: $source""");
  }
}

extension LiveStreamEventExtension on LiveStreamEvent {
  void logMessage() {
    FWExampleLoggerUtil.log("""onLiveStreamEvent eventName: $eventName 
info.id: ${info.id}""");
  }
}

extension LiveStreamChatEventExtension on LiveStreamChatEvent {
  void logMessage() {
    FWExampleLoggerUtil.log("""onLiveStreamChatEvent eventName: $eventName 
message.messageId: ${message.messageId}
message.username: ${message.username}
message.text: ${message.text}
liveStream.id: ${liveStream.id}
""");
  }
}