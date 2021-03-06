import 'dart:convert';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/utils/fw_example_logger_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../generated/l10n.dart';
import '../../widgets/fw_app_bar.dart';

class FeedLayoutsScreen extends StatefulWidget {
  const FeedLayoutsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _FeedLayoutsScreenState createState() => _FeedLayoutsScreenState();
}

class _FeedLayoutsScreenState extends State<FeedLayoutsScreen> {
  List<String> _defaultChannelIdArray = [];
  List<_FeedLayoutsPlaylistInfo> _defaultPlaylistInfoArray = [];
  List<_FeedLayoutsDynamicContentInfo> _defaultDynamicContentInfoArray = [];
  List<String> _defaultPlaylistGroupIdArray = [];

  @override
  void initState() {
    super.initState();
    _readConfig();
  }

  Future<void> _readConfig() async {
    try {
      final String response =
          await rootBundle.loadString('lib/assets/feed.json');
      final jsonData = await json.decode(response);

      FWExampleLoggerUtil.log(
          "jsonData: $jsonData jsonData.runtimeType: ${jsonData.runtimeType}");
      if (jsonData is Map<String, dynamic>) {
        if (jsonData["defaultChannelIdArray"] is List<dynamic>) {
          _defaultChannelIdArray = List<String>.from(
              jsonData["defaultChannelIdArray"] as List<dynamic>);
        }

        if (jsonData["defaultPlaylistInfoArray"] is List<dynamic>) {
          final defaultPlaylistInfoJsonArray = List<Map<String, dynamic>>.from(
              jsonData["defaultPlaylistInfoArray"] as List<dynamic>);
          _defaultPlaylistInfoArray = defaultPlaylistInfoJsonArray
              .map(
                (e) {
                  if (e["channelId"] is String && e["playlistId"] is String) {
                    return _FeedLayoutsPlaylistInfo(
                      channelId: e["channelId"] as String,
                      playlistId: e["playlistId"] as String,
                    );
                  } else {
                    return _FeedLayoutsPlaylistInfo(
                      channelId: "",
                      playlistId: "",
                    );
                  }
                },
              )
              .where((playlistInfo) =>
                  playlistInfo.channelId.isNotEmpty &&
                  playlistInfo.playlistId.isNotEmpty)
              .toList();
        }

        FWExampleLoggerUtil.log(
            "defaultPlaylistInfoArray ${jsonData["defaultPlaylistInfoArray"].runtimeType}");

        if (jsonData["defaultPlaylistGroupIdArray"] is List<dynamic>) {
          _defaultPlaylistGroupIdArray = List<String>.from(
              jsonData["defaultPlaylistGroupIdArray"] as List<dynamic>);
        }

        if (jsonData["defaultDynamicContentInfoArray"] is List<dynamic>) {
          final defaultDynamicContentInfoJsonArray =
              List<Map<String, dynamic>>.from(
                  jsonData["defaultDynamicContentInfoArray"] as List<dynamic>);
          _defaultDynamicContentInfoArray = defaultDynamicContentInfoJsonArray
              .map(
                (e) {
                  if (e["channelId"] is String &&
                      e["parameters"] is Map<String, dynamic> &&
                      e["name"] is String) {
                    final tmpParameters = Map<String, List<dynamic>>.from(
                        e["parameters"] as Map<String, dynamic>);
                    var resultParameters = <String, List<String>>{};

                    tmpParameters.forEach((key, value) {
                      resultParameters[key] = List<String>.from(value);
                    });
                    return _FeedLayoutsDynamicContentInfo(
                      channelId: e["channelId"] as String,
                      parameters: resultParameters,
                      name: e["name"] as String,
                    );
                  } else {
                    return _FeedLayoutsDynamicContentInfo(
                      channelId: "",
                      parameters: <String, List<String>>{},
                      name: "",
                    );
                  }
                },
              )
              .where((dynamicContentInfo) =>
                  dynamicContentInfo.channelId.isNotEmpty &&
                  dynamicContentInfo.name.isNotEmpty &&
                  dynamicContentInfo.parameters.isNotEmpty)
              .toList();
        }
      }
    } catch (e) {
      FWExampleLoggerUtil.log("_FeedLayoutsScreenState _readConfig error: $e");
    }

    FWExampleLoggerUtil.log("_defaultChannelIdArray $_defaultChannelIdArray");
    FWExampleLoggerUtil.log(
        "_defaultPlaylistInfoArray $_defaultPlaylistInfoArray");

    FWExampleLoggerUtil.log(
        "_defaultPlaylistGroupIdArray $_defaultPlaylistGroupIdArray");
    FWExampleLoggerUtil.log(
        "_defaultDynamicContentInfoArray $_defaultDynamicContentInfoArray");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fwAppBar(
        context: context,
        titleText: S.of(context).feedLayouts,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            _buildDiscoverItem(context),
            _buildChannelItem(context),
            _buildPlaylistItem(context),
            _buildPlaylistGroupItem(context),
            _buildDynamicContentItem(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscoverItem(BuildContext context) {
    return _buildItem(
      context: context,
      title: S.of(context).discoverFeed,
      onTap: () {
        _goToDiscoverFeed();
      },
    );
  }

  void _goToDiscoverFeed() {
    Navigator.of(context).pushNamed("/feed", arguments: {
      "source": VideoFeedSource.discover,
      "title": S.of(context).discoverFeed,
    });
  }

  Widget _buildChannelItem(BuildContext context) {
    return _buildItem(
      context: context,
      title: S.of(context).channelFeed,
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) {
            final _defaultChannelIdWidgetArray = _defaultChannelIdArray.map(
              (channelId) => CupertinoActionSheetAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.of(context).pop();
                  _goToChannelFeed(channelId);
                },
                child: Text(
                  channelId,
                ),
              ),
            );
            return CupertinoActionSheet(
              title: Text(
                S.of(context).selectChannelId,
              ),
              actions: [
                for (var w in _defaultChannelIdWidgetArray) w,
                CupertinoActionSheetAction(
                  child: Text(
                    S.of(context).custom,
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    _goToChannelConfiguration();
                  },
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                child: Text(
                  S.of(context).cancel,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            );
          },
        );
      },
    );
  }

  void _goToChannelConfiguration() async {
    final channelId = await Navigator.of(context).pushNamed(
      "/channel_configuration",
    );
    FWExampleLoggerUtil.log("channel_configuration channelId: $channelId");
    if (channelId is String && channelId.isNotEmpty) {
      _goToChannelFeed(channelId);
    }
  }

  void _goToChannelFeed(String channelId) {
    Navigator.of(context).pushNamed(
      "/feed",
      arguments: {
        "source": VideoFeedSource.channel,
        "channel": channelId,
        "title": S.of(context).channelFeed,
      },
    );
  }

  Widget _buildPlaylistItem(BuildContext context) {
    return _buildItem(
      context: context,
      title: S.of(context).playlistFeed,
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) {
            final _defaultPlaylistInfoWidgetArray =
                _defaultPlaylistInfoArray.map(
              (playlistInfo) => CupertinoActionSheetAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.of(context).pop();
                  _goToPlaylistFeed(
                      playlistInfo.channelId, playlistInfo.playlistId);
                },
                child: Text(
                  "channelId: ${playlistInfo.channelId} playlistId: ${playlistInfo.playlistId}",
                ),
              ),
            );
            return CupertinoActionSheet(
              title: Text(
                S.of(context).selectPlaylistInfo,
              ),
              actions: [
                for (var w in _defaultPlaylistInfoWidgetArray) w,
                CupertinoActionSheetAction(
                  child: Text(
                    S.of(context).custom,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _goToPlaylistConfiguration();
                  },
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                child: Text(
                  S.of(context).cancel,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            );
          },
        );
      },
    );
  }

  void _goToPlaylistConfiguration() async {
    final result = await Navigator.of(context).pushNamed(
      "/playlist_configuration",
    );
    FWExampleLoggerUtil.log(
        "playlist_configuration result: $result type: ${result?.runtimeType}");

    if (result is Map<String, String>) {
      final channelId = result["channelId"] ?? "";
      final playlistId = result["playlistId"] ?? "";
      if (channelId.isNotEmpty && playlistId.isNotEmpty) {
        _goToPlaylistFeed(channelId, playlistId);
      }
    }
  }

  void _goToPlaylistFeed(String channelId, String playlistId) {
    Navigator.of(context).pushNamed(
      "/feed",
      arguments: {
        "source": VideoFeedSource.playlist,
        "channel": channelId,
        "playlist": playlistId,
        "title": S.of(context).playlistFeed,
      },
    );
  }

  Widget _buildPlaylistGroupItem(BuildContext context) {
    return _buildItem(
      context: context,
      title: S.of(context).playlistGroupFeed,
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) {
            final _defaultPlaylistGroupIdWidgetArray =
                _defaultPlaylistGroupIdArray.map(
              (playlistGroupId) => CupertinoActionSheetAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.of(context).pop();
                  _goToPlaylistGroupFeed(playlistGroupId);
                },
                child: Text(
                  playlistGroupId,
                ),
              ),
            );
            return CupertinoActionSheet(
              title: Text(
                S.of(context).selectPlaylistGroupId,
              ),
              actions: [
                for (var w in _defaultPlaylistGroupIdWidgetArray) w,
                CupertinoActionSheetAction(
                  child: Text(
                    S.of(context).custom,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _goToPlaylistGroupConfiguration();
                  },
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                child: Text(
                  S.of(context).cancel,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            );
          },
        );
      },
    );
  }

  void _goToPlaylistGroupConfiguration() async {
    final playlistGroupId = await Navigator.of(context).pushNamed(
      "/playlist_group_configuration",
    );
    FWExampleLoggerUtil.log(
        "playlist_group_configuration playlistGroupId: $playlistGroupId");
    if (playlistGroupId is String && playlistGroupId.isNotEmpty) {
      _goToPlaylistGroupFeed(playlistGroupId);
    }
  }

  void _goToPlaylistGroupFeed(String playlistGroupId) {
    Navigator.of(context).pushNamed(
      "/feed",
      arguments: {
        "source": VideoFeedSource.playlistGroup,
        "playlistGroup": playlistGroupId,
        "title": S.of(context).playlistGroupFeed,
      },
    );
  }

  Widget _buildDynamicContentItem(BuildContext context) {
    return _buildItem(
      context: context,
      title: S.of(context).dynamicContentFeed,
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) {
            final _defaultDynamicContentInfoWidgetArray =
                _defaultDynamicContentInfoArray.map(
              (dynamicContentInfo) => CupertinoActionSheetAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.of(context).pop();
                  _goToDynamicContentGroupFeed(dynamicContentInfo.channelId,
                      dynamicContentInfo.parameters);
                },
                child: Text(
                  dynamicContentInfo.name,
                ),
              ),
            );
            return CupertinoActionSheet(
              title: Text(
                S.of(context).selectDynamicContentInfo,
              ),
              actions: [
                for (var w in _defaultDynamicContentInfoWidgetArray) w,
                CupertinoActionSheetAction(
                  child: Text(
                    S.of(context).custom,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _goToDynamicContentConfiguration();
                  },
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                child: Text(
                  S.of(context).cancel,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            );
          },
        );
      },
    );
  }

  void _goToDynamicContentConfiguration() async {
    final result = await Navigator.of(context).pushNamed(
      "/dynamic_content_configuration",
    );
    if (result is Map<String, dynamic>) {
      FWExampleLoggerUtil.log(
          'dynamicContentParameters ${result["dynamicContentParameters"]} ${result["dynamicContentParameters"].runtimeType}');
      FWExampleLoggerUtil.log(
          'channelId ${result["channelId"]} ${result["channelId"].runtimeType}');
      if (result["channelId"] is String &&
          result["dynamicContentParameters"] is Map<String, List<String>>) {
        Navigator.of(context).pushNamed(
          "/feed",
          arguments: {
            "source": VideoFeedSource.dynamicContent,
            "channel": result["channelId"] as String,
            "dynamicContentParameters":
                result["dynamicContentParameters"] as Map<String, List<String>>,
            "title": S.of(context).dynamicContentFeed,
          },
        );
      }
    }
  }

  void _goToDynamicContentGroupFeed(
      String channelId, Map<String, List<String>> dynamicContentParameters) {
    Navigator.of(context).pushNamed(
      "/feed",
      arguments: {
        "source": VideoFeedSource.dynamicContent,
        "channel": channelId,
        "dynamicContentParameters": dynamicContentParameters,
        "title": S.of(context).dynamicContentFeed,
      },
    );
  }

  Widget _buildItem({
    required BuildContext context,
    required String title,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.white,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            padding: const EdgeInsets.all(20),
          ),
          Container(
            height: 1,
            color: const Color.fromARGB(255, 202, 200, 200),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}

class _FeedLayoutsPlaylistInfo {
  final String channelId;
  final String playlistId;
  _FeedLayoutsPlaylistInfo({
    required this.channelId,
    required this.playlistId,
  });
}

class _FeedLayoutsDynamicContentInfo {
  final String channelId;
  final Map<String, List<String>> parameters;
  final String name;
  _FeedLayoutsDynamicContentInfo({
    required this.channelId,
    required this.parameters,
    required this.name,
  });
}
