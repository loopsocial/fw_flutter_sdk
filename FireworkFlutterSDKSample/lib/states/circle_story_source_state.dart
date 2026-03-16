import 'package:flutter/material.dart';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';

/// Default values aligned with feed.json (Feed Layouts tab demo parameters).
/// Playlist: defaultPlaylistInfoArray[0]. Channel: defaultChannelIdArray[0].
/// PlaylistGroup: defaultPlaylistGroupIdArray[0]. DynamicContent: defaultDynamicContentInfoArray[0].
/// Hashtag: defaultHashtagPlaylistInfoArray[0].
class CircleStorySourceState extends ChangeNotifier {
  VideoFeedSource _source = VideoFeedSource.playlist;
  String? _channel = "bJDywZ";
  String? _playlist = "g206q5";
  String? _playlistGroup;
  Map<String, List<String>>? _dynamicContentParameters;
  String? _hashtagFilterExpression;
  List<String>? _productIds;
  String? _contentId;

  VideoFeedSource get source => _source;
  String? get channel => _channel;
  String? get playlist => _playlist;
  String? get playlistGroup => _playlistGroup;
  Map<String, List<String>>? get dynamicContentParameters =>
      _dynamicContentParameters;
  String? get hashtagFilterExpression => _hashtagFilterExpression;
  List<String>? get productIds => _productIds;
  String? get contentId => _contentId;

  void updateSource({
    required VideoFeedSource source,
    String? channel,
    String? playlist,
    String? playlistGroup,
    Map<String, List<String>>? dynamicContentParameters,
    String? hashtagFilterExpression,
    List<String>? productIds,
    String? contentId,
  }) {
    _source = source;
    _channel = channel;
    _playlist = playlist;
    _playlistGroup = playlistGroup;
    _dynamicContentParameters = dynamicContentParameters;
    _hashtagFilterExpression = hashtagFilterExpression;
    _productIds = productIds;
    _contentId = contentId;
    notifyListeners();
  }

  void reset() {
    _source = VideoFeedSource.playlist;
    _channel = null;
    _playlist = null;
    _playlistGroup = null;
    _dynamicContentParameters = null;
    _hashtagFilterExpression = null;
    _productIds = null;
    _contentId = null;
    notifyListeners();
  }
}
