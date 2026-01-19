import 'package:flutter/material.dart';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';

class CircleStorySourceState extends ChangeNotifier {
  VideoFeedSource _source = VideoFeedSource.playlist;
  String? _channel = "bJDywZ";
  String? _playlist = "g206q5";

  VideoFeedSource get source => _source;
  String? get channel => _channel;
  String? get playlist => _playlist;

  void updateSource({
    VideoFeedSource? source,
    String? channel,
    String? playlist,
  }) {
    if (source != null) {
      _source = source;
    }
    _channel = channel;
    _playlist = playlist;
    notifyListeners();
  }

  void reset() {
    _source = VideoFeedSource.playlist;
    _channel = "bJDywZ";
    _playlist = "g206q5";
    notifyListeners();
  }
}
