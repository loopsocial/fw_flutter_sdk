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
    final feedId = info.feedId;

    FWExampleLoggerUtil.log("""onVideoPlayback eventName: $eventName 
videoId: $videoId 
duration: $duration 
caption: $caption 
badge: $badge 
playerWidth:$playerWidth 
playerHeight: $playerHeight 
hasCTA: $hasCTA
feedId: $feedId""");
  }
}

extension VideoFeedClickEventExtension on VideoFeedClickEvent {
  void logMessage() {
    final id = info.id;
    final feedId = info.feedId;
    final duration = info.duration;
    final index = info.index;
    final title = info.title;
    final source = info.source;
    final channel = info.channel;
    final playlist = info.playlist;
    final playlistGroup = info.playlistGroup;
    final dynamicContentParameters = info.dynamicContentParameters;

    FWExampleLoggerUtil.log("""onVideoFeedClick id: $id 
feedId: $feedId 
duration: $duration 
index: $index
title: $title
source: $source
channel: $channel
playlist: $playlist
playlistGroup: $playlistGroup
dynamicContentParameters: $dynamicContentParameters
dynamicContentParameters.runtimeType: ${dynamicContentParameters.runtimeType}
""");
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
