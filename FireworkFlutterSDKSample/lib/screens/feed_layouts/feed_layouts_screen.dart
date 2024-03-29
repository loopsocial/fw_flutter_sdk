import 'dart:convert';
import 'package:fw_flutter_sdk_example/utils/fw_example_logger_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../generated/l10n.dart';
import '../../models/feed_playlist_info.dart';
import '../../widgets/fw_app_bar.dart';

class FeedLayoutsScreen extends StatefulWidget {
  const FeedLayoutsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FeedLayoutsScreen> createState() => _FeedLayoutsScreenState();
}

class _FeedLayoutsScreenState extends State<FeedLayoutsScreen> {
  List<String> _defaultChannelIdArray = [];
  List<FeedPlaylistInfo> _defaultPlaylistInfoArray = [];
  List<_FeedLayoutsDynamicContentInfo> _defaultDynamicContentInfoArray = [];
  List<String> _defaultPlaylistGroupIdArray = [];
  List<_FeedLayoutsHashtagPlaylistInfo> _defaultHashtagPlaylistInfoArray = [];

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
          setState(() {
            _defaultChannelIdArray = List<String>.from(
                jsonData["defaultChannelIdArray"] as List<dynamic>);
          });
        }

        if (jsonData["defaultPlaylistInfoArray"] is List<dynamic>) {
          final defaultPlaylistInfoJsonArray = List<Map<String, dynamic>>.from(
              jsonData["defaultPlaylistInfoArray"] as List<dynamic>);
          setState(() {
            _defaultPlaylistInfoArray = defaultPlaylistInfoJsonArray
                .map(
                  (e) {
                    if (e["channelId"] is String && e["playlistId"] is String) {
                      return FeedPlaylistInfo(
                        channelId: e["channelId"] as String,
                        playlistId: e["playlistId"] as String,
                      );
                    } else {
                      return FeedPlaylistInfo(
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
          });
        }

        FWExampleLoggerUtil.log(
            "defaultPlaylistInfoArray ${jsonData["defaultPlaylistInfoArray"].runtimeType}");

        if (jsonData["defaultPlaylistGroupIdArray"] is List<dynamic>) {
          setState(() {
            _defaultPlaylistGroupIdArray = List<String>.from(
                jsonData["defaultPlaylistGroupIdArray"] as List<dynamic>);
          });
        }

        if (jsonData["defaultDynamicContentInfoArray"] is List<dynamic>) {
          final defaultDynamicContentInfoJsonArray =
              List<Map<String, dynamic>>.from(
                  jsonData["defaultDynamicContentInfoArray"] as List<dynamic>);
          setState(() {
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
          });
        }
        if (jsonData["defaultHashtagPlaylistInfoArray"] is List<dynamic>) {
          final defaultHashtagPlaylistInfoArray =
              List<Map<String, dynamic>>.from(
                  jsonData["defaultHashtagPlaylistInfoArray"] as List<dynamic>);

          setState(() {
            _defaultHashtagPlaylistInfoArray = defaultHashtagPlaylistInfoArray
                .map(
                  (e) {
                    if (e["channelId"] is String &&
                        e["hashtagFilterExpression"] is String &&
                        e["name"] is String) {
                      return _FeedLayoutsHashtagPlaylistInfo(
                        channelId: e["channelId"] as String,
                        hashtagFilterExpression:
                            e["hashtagFilterExpression"] as String,
                        name: e["name"] as String,
                      );
                    } else {
                      return _FeedLayoutsHashtagPlaylistInfo(
                        channelId: "",
                        hashtagFilterExpression: "",
                        name: "",
                      );
                    }
                  },
                )
                .where((hashtagPlaylistInfo) =>
                    hashtagPlaylistInfo.channelId.isNotEmpty &&
                    hashtagPlaylistInfo.name.isNotEmpty &&
                    hashtagPlaylistInfo.hashtagFilterExpression.isNotEmpty)
                .toList();
          });
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
            _buildHashtagPlaylistItem(context),
            _buildSkuItem(context),
            _buildSingleContentItem(context),
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
      "source": "discover",
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
            final defaultChannelIdWidgetArray = _defaultChannelIdArray.map(
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
                for (var w in defaultChannelIdWidgetArray) w,
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
        "source": "channel",
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
            final defaultPlaylistInfoWidgetArray =
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
                for (var w in defaultPlaylistInfoWidgetArray) w,
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
        "source": "playlist",
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
            final defaultPlaylistGroupIdWidgetArray =
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
                for (var w in defaultPlaylistGroupIdWidgetArray) w,
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
        "source": "playlistGroup",
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
            final defaultDynamicContentInfoWidgetArray =
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
                for (var w in defaultDynamicContentInfoWidgetArray) w,
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
    final navigator = Navigator.of(context);
    final s = S.of(context);
    final result = await navigator.pushNamed(
      "/dynamic_content_configuration",
    );
    if (result is Map<String, dynamic>) {
      FWExampleLoggerUtil.log(
          'channelId ${result["channelId"]} ${result["channelId"].runtimeType}');
      FWExampleLoggerUtil.log(
          'dynamicContentParameters ${result["dynamicContentParameters"]} ${result["dynamicContentParameters"].runtimeType}');
      if (result["channelId"] is String &&
          result["dynamicContentParameters"] is Map<String, List<String>>) {
        navigator.pushNamed(
          "/feed",
          arguments: {
            "source": "dynamicContent",
            "channel": result["channelId"] as String,
            "dynamicContentParameters":
                result["dynamicContentParameters"] as Map<String, List<String>>,
            "title": s.dynamicContentFeed,
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
        "source": "dynamicContent",
        "channel": channelId,
        "dynamicContentParameters": dynamicContentParameters,
        "title": S.of(context).dynamicContentFeed,
      },
    );
  }

  Widget _buildHashtagPlaylistItem(BuildContext context) {
    return _buildItem(
      context: context,
      title: S.of(context).hashtagPlaylistFeed,
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) {
            final defaultHashtagPlaylistInfoArray =
                _defaultHashtagPlaylistInfoArray.map(
              (hashtagPlaylistInfo) => CupertinoActionSheetAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.of(context).pop();
                  _goToHashtagPlaylistFeed(hashtagPlaylistInfo.channelId,
                      hashtagPlaylistInfo.hashtagFilterExpression);
                },
                child: Text(
                  hashtagPlaylistInfo.name,
                ),
              ),
            );
            return CupertinoActionSheet(
              title: Text(
                S.of(context).selectDynamicContentInfo,
              ),
              actions: [
                for (var w in defaultHashtagPlaylistInfoArray) w,
                CupertinoActionSheetAction(
                  child: Text(
                    S.of(context).custom,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _goToHashtagPlaylistConfiguration();
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

  void _goToHashtagPlaylistConfiguration() async {
    final navigator = Navigator.of(context);
    final s = S.of(context);
    final result = await navigator.pushNamed(
      "/hashtag_playlist_configuration",
    );
    if (result is Map<String, dynamic>) {
      FWExampleLoggerUtil.log(
          'hashtagFilterExpression ${result["hashtagFilterExpression"]}');
      FWExampleLoggerUtil.log(
          'channelId ${result["channelId"]} ${result["channelId"].runtimeType}');
      if (result["channelId"] is String &&
          result["hashtagFilterExpression"] is String) {
        navigator.pushNamed(
          "/feed",
          arguments: {
            "source": "hashtagPlaylist",
            "channel": result["channelId"] as String,
            "hashtagFilterExpression":
                result["hashtagFilterExpression"] as String,
            "title": s.hashtagPlaylistFeed,
          },
        );
      }
    }
  }

  void _goToHashtagPlaylistFeed(
      String channelId, String hashtagFilterExpression) {
    Navigator.of(context).pushNamed(
      "/feed",
      arguments: {
        "source": "hashtagPlaylist",
        "channel": channelId,
        "hashtagFilterExpression": hashtagFilterExpression,
        "title": S.of(context).hashtagPlaylistFeed,
      },
    );
  }

  Widget _buildSkuItem(BuildContext context) {
    return _buildItem(
      context: context,
      title: S.of(context).skuFeed,
      onTap: () {
        _goToSkuConfiguration();
      },
    );
  }

  void _goToSkuConfiguration() async {
    final navigator = Navigator.of(context);
    final s = S.of(context);
    final result = await navigator.pushNamed(
      "/sku_configuration",
    );
    if (result is Map<String, dynamic>) {
      FWExampleLoggerUtil.log(
          'channelId ${result["channelId"]} ${result["channelId"].runtimeType}');
      FWExampleLoggerUtil.log(
          'productIds ${result["productIds"]} ${result["productIds"].runtimeType}');
      if (result["channelId"] is String &&
          result["productIds"] is List<String>) {
        navigator.pushNamed(
          "/feed",
          arguments: {
            "source": "sku",
            "channel": result["channelId"] as String,
            "productIds": result["productIds"] as List<String>,
            "title": s.skuFeed,
          },
        );
      }
    }
  }

  Widget _buildSingleContentItem(BuildContext context) {
    return _buildItem(
      context: context,
      title: S.of(context).singleContentFeed,
      onTap: () {
        _goToSingleContentConfiguration();
      },
    );
  }

  void _goToSingleContentConfiguration() async {
    final navigator = Navigator.of(context);
    final s = S.of(context);
    final result = await navigator.pushNamed(
      "/single_content_configuration",
    );
    if (result is Map<String, dynamic>) {
      FWExampleLoggerUtil.log(
          'contentId ${result["contentId"]} ${result["contentId"].runtimeType}');
      if (result["contentId"] is String) {
        navigator.pushNamed(
          "/feed",
          arguments: {
            "source": "singleContent",
            "contentId": result["contentId"] as String,
            "title": s.singleContentFeedInfo,
          },
        );
      }
    }
  }

  Widget _buildItem({
    required BuildContext context,
    required String title,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            height: 1,
            color: const Color.fromARGB(255, 202, 200, 200),
          ),
        ],
      ),
    );
  }
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

class _FeedLayoutsHashtagPlaylistInfo {
  final String channelId;
  final String hashtagFilterExpression;
  final String name;
  _FeedLayoutsHashtagPlaylistInfo({
    required this.channelId,
    required this.hashtagFilterExpression,
    required this.name,
  });
}
