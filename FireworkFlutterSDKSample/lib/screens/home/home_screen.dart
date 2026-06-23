import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fw_flutter_sdk_example/utils/host_app_service.dart';

import '../../extensions/fw_error_extension.dart';
import '../../generated/l10n.dart';
import '../../models/feed_playlist_info.dart';
import '../../utils/fw_example_logger_util.dart';
import '../../widgets/fw_app_bar.dart';

enum HomeScreenTabIndex {
  multiFeeds,
  shopping,
  embed,
}

/// The widget type embedded in the [HomeScreenTabIndex.embed] tab.
/// Only one widget is embedded at a time.
enum EmbedWidgetType {
  videoFeed,
  storyBlock,
  playerDeck,
  circleStory,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  VideoFeedController? _feedController;
  String? _channelId;
  String? _playlistId;
  FWError? _feedError;
  bool _enablePip = true;
  bool _enableKeepingAlive = false;
  HomeScreenTabIndex _tabIndex = HomeScreenTabIndex.multiFeeds;
  EmbedWidgetType _embedWidgetType = EmbedWidgetType.playerDeck;
  bool _embedInitiallyVisible = true;
  List<FeedPlaylistInfo> _defaultHomeVideoFeedPlaylistInfoArray = [];
  List<FeedPlaylistInfo> _defaultHomeStoryBlockPlaylistInfoArray = [];

  bool _loading = true;

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
          "_ShoppingScreenState jsonData: $jsonData jsonData.runtimeType: ${jsonData.runtimeType}");
      if (jsonData is Map<String, dynamic>) {
        if (jsonData["defaultShoppingPlaylist"] is Map<String, dynamic>) {
          final defaultShoppingPlaylistJson =
              jsonData["defaultShoppingPlaylist"] as Map<String, dynamic>;
          if (defaultShoppingPlaylistJson["channelId"] is String &&
              defaultShoppingPlaylistJson["playlistId"] is String) {
            final channelId =
                defaultShoppingPlaylistJson["channelId"] as String;
            final playlistId =
                defaultShoppingPlaylistJson["playlistId"] as String;
            if (mounted) {
              setState(() {
                _channelId = channelId;
                _playlistId = playlistId;
              });
            }
          }
        }

        if (jsonData["defaultHomeVideoFeedPlaylistInfoArray"]
            is List<dynamic>) {
          final defaultHomeVideoFeedPlaylistInfoJsonArray =
              List<Map<String, dynamic>>.from(
                  jsonData["defaultHomeVideoFeedPlaylistInfoArray"]
                      as List<dynamic>);
          setState(() {
            _defaultHomeVideoFeedPlaylistInfoArray =
                defaultHomeVideoFeedPlaylistInfoJsonArray
                    .map(
                      (e) {
                        if (e["channelId"] is String &&
                            e["playlistId"] is String) {
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

        if (jsonData["defaultHomeStoryBlockPlaylistInfoArray"]
            is List<dynamic>) {
          final defaultHomeStoryBlockPlaylistInfoJsonArray =
              List<Map<String, dynamic>>.from(
                  jsonData["defaultHomeStoryBlockPlaylistInfoArray"]
                      as List<dynamic>);
          setState(() {
            _defaultHomeStoryBlockPlaylistInfoArray =
                defaultHomeStoryBlockPlaylistInfoJsonArray
                    .map(
                      (e) {
                        if (e["channelId"] is String &&
                            e["playlistId"] is String) {
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
      }
    } catch (e) {
      FWExampleLoggerUtil.log("_ShoppingScreenState _readConfig error: $e");
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: fwAppBar(
        context: context,
        titleText: S.of(context).shopping,
        actions: [
          if (_tabIndex == HomeScreenTabIndex.shopping)
            Semantics(
              label: 'Refresh',
              child: IconButton(
                onPressed: () {
                  _refresh();
                },
                icon: const Icon(
                  Icons.refresh,
                ),
              ),
            ),
          Semantics(
            label: 'Playlist Config',
            child: IconButton(
              onPressed: () {
                _goPlaylistConfiguration();
              },
              icon: const Icon(
                Icons.settings,
              ),
            ),
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_loading) {
      return Container(
        color: Colors.white,
      );
    }

    if ((_channelId ?? "").isEmpty || (_playlistId ?? "").isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Text(
            S.of(context).setDefaultShoppingPlaylistTip,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
    List<Widget> multiFeedsWidgetList = [];
    if (_tabIndex == HomeScreenTabIndex.multiFeeds) {
      multiFeedsWidgetList = _buildMultiFeeds(context);
    }
    return ListView(
      children: [
        const SizedBox(
          height: 10,
        ),
        _buildOptionToggles(context),
        const SizedBox(
          height: 6,
        ),
        _buildFeedWidgetTypeSegmentedControl(context),
        const SizedBox(
          height: 10,
        ),
        if (_tabIndex == HomeScreenTabIndex.shopping)
          _buildShoppingFeed(context),
        for (var w in multiFeedsWidgetList) w,
        if (_tabIndex == HomeScreenTabIndex.embed)
          for (var w in _buildEmbedTab(context)) w,
        if (_tabIndex == HomeScreenTabIndex.shopping)
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 20,
              ),
              _buildSeperator(context),
              _buildItem(
                context: context,
                leftText: "${S.of(context).channelId}: ",
                rightText: _channelId!,
              ),
              _buildItem(
                context: context,
                leftText: "${S.of(context).playlistId}:",
                rightText: _playlistId!,
              ),
              _buildSeperator(context),
              const SizedBox(
                height: 20,
              ),
              _buildConfigButtonList(context),
              const SizedBox(
                height: 20,
              ),
            ],
          )
      ],
    );
  }

  Widget _buildOptionToggles(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _buildCompactCheckbox(
              value: _enablePip,
              label: S.of(context).enablePictureInPicture,
              onChanged: (value) {
                setState(() {
                  _enablePip = value ?? false;
                });
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildCompactCheckbox(
              value: _enableKeepingAlive,
              label: S.of(context).enableKeepingAlive,
              onChanged: (value) {
                setState(() {
                  _enableKeepingAlive = value ?? false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactCheckbox({
    required bool value,
    required String label,
    required ValueChanged<bool?> onChanged,
  }) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: value,
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: onChanged,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedWidgetTypeSegmentedControl(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoSegmentedControl<HomeScreenTabIndex>(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        onValueChanged: (value) {
          setState(() {
            _tabIndex = value;
          });
        },
        children: {
          HomeScreenTabIndex.multiFeeds: Text(
            S.of(context).multiFeeds,
            style: const TextStyle(fontSize: 13),
          ),
          HomeScreenTabIndex.shopping: Text(
            S.of(context).shopping,
            style: const TextStyle(fontSize: 13),
          ),
          HomeScreenTabIndex.embed: const Text(
            "Embed",
            style: TextStyle(fontSize: 13),
          ),
        },
        groupValue: _tabIndex,
      ),
    );
  }

  Widget _buildShoppingFeed(BuildContext context) {
    if (_feedError != null) {
      return _buildErrorWidget(context);
    }
    VideoFeedConfiguration feedConfiguration = VideoFeedConfiguration(
      titlePosition: VideoFeedTitlePosition.nested,
      title: VideoFeedTitleConfiguration(
        hidden: false,
      ),
      showAdBadge: true,
      itemSpacing: 10,
    );

    VideoPlayerConfiguration playerConfiguration = VideoPlayerConfiguration(
      playerStyle: VideoPlayerStyle.full,
      showShareButton: true,
      showMuteButton: true,
      showPlaybackButton: true,
      videoCompleteAction: VideoPlayerCompleteAction.advanceToNext,
    );
    return Padding(
      padding: defaultTargetPlatform == TargetPlatform.android
          ? const EdgeInsets.fromLTRB(10, 10, 10, 0)
          : const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: VideoFeed(
        wantKeepAlive: _enableKeepingAlive,
        height: 300,
        source: VideoFeedSource.playlist,
        channel: _channelId,
        playlist: _playlistId,
        mode: VideoFeedMode.row,
        enablePictureInPicture: _enablePip,
        videoFeedConfiguration: feedConfiguration,
        videoPlayerConfiguration: playerConfiguration,
        onVideoFeedCreated: _onVideoFeedCreated,
        onVideoFeedLoadFinished: _onVideoFeedLoadFinished,
        onVideoFeedDidStartPictureInPicture:
            _onVideoFeedDidStartPictureInPicture,
        onVideoFeedDidStopPictureInPicture: _onVideoFeedDidStopPictureInPicture,
      ),
    );
  }

  List<Widget> _buildMultiFeeds(BuildContext context) {
    List<Widget> widgetList = <Widget>[];

    var storyBlockIndex = 0;

    for (var e in _defaultHomeStoryBlockPlaylistInfoArray) {
      storyBlockIndex++;
      final title = "Story Block $storyBlockIndex";
      FWExampleLoggerUtil.log(
          "_buildMultiFeeds channelId: ${e.channelId} playlistId: ${e.playlistId}");
      widgetList.addAll([
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: StoryBlock(
            wantKeepAlive: _enableKeepingAlive,
            cornerRadius: 20,
            height: defaultTargetPlatform == TargetPlatform.android ? 400 : 500,
            source: StoryBlockSource.playlist,
            channel: e.channelId,
            playlist: e.playlistId,
            enablePictureInPicture: _enablePip,
            onStoryBlockEmpty: (error) {
              FWExampleLoggerUtil.log(
                  "onStoryBlockEmpty error ${error?.displayString()}");
            },
            onStoryBlockGetFeedId: (feedId) {
              HostAppService.getInstance().widgetInfoMap[feedId] = WidgetInfo(
                title: title,
                type: "StoryBlock",
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        _buildListItemPlaceholder(context),
        const SizedBox(
          height: 20,
        ),
      ]);
    }
    Map<String, WidgetInfo> globalWidgetInfoMap = {};
    VideoFeed(
      height: 300,
      source: VideoFeedSource.playlist,
      channel: "your encoded channel id",
      playlist: "your encoded playlist id",
      enablePictureInPicture: true,
      onVideoFeedGetFeedId: (feedId) {
        globalWidgetInfoMap[feedId] = WidgetInfo(
          title: "VideoFeed 1",
          type: "VideoFeed",
        );
      },
    );
    StoryBlock(
      cornerRadius: 20,
      height: 400,
      source: StoryBlockSource.playlist,
      channel: "your encoded channel id",
      playlist: "your encoded playlist id",
      enablePictureInPicture: true,
      onStoryBlockGetFeedId: (feedId) {
        globalWidgetInfoMap[feedId] = WidgetInfo(
          title: "StoryBlock 1",
          type: "StoryBlock",
        );
      },
    );
    var videoFeedIndex = 0;
    for (var e in _defaultHomeVideoFeedPlaylistInfoArray) {
      videoFeedIndex++;
      final title = "Video Feed $videoFeedIndex";
      widgetList.addAll([
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: defaultTargetPlatform == TargetPlatform.android
              ? const EdgeInsets.symmetric(horizontal: 10)
              : EdgeInsets.zero,
          child: VideoFeed(
            wantKeepAlive: _enableKeepingAlive,
            height: 300,
            source: VideoFeedSource.playlist,
            channel: e.channelId,
            playlist: e.playlistId,
            enablePictureInPicture: _enablePip,
            onVideoFeedGetFeedId: (feedId) {
              FWExampleLoggerUtil.log("onVideoFeedGetFeedId feedId: $feedId");
              HostAppService.getInstance().widgetInfoMap[feedId] = WidgetInfo(
                title: title,
                type: "VideoFeed",
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        _buildListItemPlaceholder(context),
        const SizedBox(
          height: 20,
        ),
      ]);
    }

    return widgetList;
  }

  List<Widget> _buildEmbedTab(BuildContext context) {
    final widgetList = <Widget>[];

    widgetList.addAll([
      _buildEmbedWidgetTypeSelector(context),
      const SizedBox(height: 8),
      _buildEmbedControlsRow(context),
      const SizedBox(height: 12),
    ]);

    // When the widget should start off-screen, push it below the fold with
    // leading placeholders so it only becomes visible after scrolling.
    if (!_embedInitiallyVisible) {
      for (var i = 0; i < 4; i++) {
        widgetList.addAll([
          _buildListItemPlaceholder(context),
          const SizedBox(height: 20),
        ]);
      }
    }

    widgetList.addAll([
      _buildEmbeddedWidget(context),
      const SizedBox(height: 20),
    ]);

    // Trailing placeholders so the embedded widget can also be scrolled out of
    // view in both directions.
    for (var i = 0; i < 4; i++) {
      widgetList.addAll([
        _buildListItemPlaceholder(context),
        const SizedBox(height: 20),
      ]);
    }

    return widgetList;
  }

  Widget _buildEmbedWidgetTypeSelector(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoSegmentedControl<EmbedWidgetType>(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        onValueChanged: (value) {
          setState(() {
            _embedWidgetType = value;
          });
        },
        children: const {
          EmbedWidgetType.videoFeed: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text("VideoFeed", style: TextStyle(fontSize: 13)),
          ),
          EmbedWidgetType.storyBlock: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text("StoryBlock", style: TextStyle(fontSize: 13)),
          ),
          EmbedWidgetType.playerDeck: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text("PlayerDeck", style: TextStyle(fontSize: 13)),
          ),
          EmbedWidgetType.circleStory: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text("CircleStory", style: TextStyle(fontSize: 13)),
          ),
        },
        groupValue: _embedWidgetType,
      ),
    );
  }

  Widget _buildEmbedControlsRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _buildCompactCheckbox(
              value: _embedInitiallyVisible,
              label: "Initially visible in ListView",
              onChanged: (value) {
                setState(() {
                  _embedInitiallyVisible = value ?? false;
                });
              },
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/embed_secondary");
            },
            child: const Text("Push to secondary page"),
          ),
        ],
      ),
    );
  }

  Widget _buildEmbeddedWidget(BuildContext context) {
    final channel = _channelId;
    final playlist = _playlistId;
    // Fold the PiP / keep-alive flags into the key so that toggling either of
    // them forces the embedded widget (and its native view) to be recreated
    // rather than just rebuilt with new props, which the native side ignores.
    final configSuffix = "pip:$_enablePip-keepAlive:$_enableKeepingAlive";
    switch (_embedWidgetType) {
      case EmbedWidgetType.videoFeed:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: VideoFeed(
            key: ValueKey("embed-video-feed-$configSuffix"),
            wantKeepAlive: _enableKeepingAlive,
            height: 300,
            source: VideoFeedSource.playlist,
            channel: channel,
            playlist: playlist,
            enablePictureInPicture: _enablePip,
          ),
        );
      case EmbedWidgetType.storyBlock:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: StoryBlock(
            key: ValueKey("embed-story-block-$configSuffix"),
            wantKeepAlive: _enableKeepingAlive,
            cornerRadius: 20,
            height: defaultTargetPlatform == TargetPlatform.android ? 400 : 500,
            source: StoryBlockSource.playlist,
            channel: channel,
            playlist: playlist,
            enablePictureInPicture: _enablePip,
          ),
        );
      case EmbedWidgetType.playerDeck:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: PlayerDeck(
            key: ValueKey("embed-player-deck-$configSuffix"),
            wantKeepAlive: _enableKeepingAlive,
            height: 430,
            source: VideoFeedSource.playlist,
            channel: channel,
            playlist: playlist,
            enablePictureInPicture: _enablePip,
          ),
        );
      case EmbedWidgetType.circleStory:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CircleStory(
            key: ValueKey("embed-circle-story-$configSuffix"),
            wantKeepAlive: _enableKeepingAlive,
            height: 100,
            source: VideoFeedSource.playlist,
            channel: channel,
            playlist: playlist,
            enablePictureInPicture: _enablePip,
          ),
        );
    }
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                _refresh();
              },
              child: Text(
                S.of(context).refresh,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              _feedError?.reason ?? S.of(context).videoFeedLoadError,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItemPlaceholder(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        color: Colors.grey,
        height: 200,
        child: const Center(
          child: Text('List item placeholder'),
        ),
      ),
    );
  }

  void _onVideoFeedCreated(VideoFeedController controller) {
    FWExampleLoggerUtil.log("_onVideoFeedCreated");
    _feedController = controller;
  }

  void _onVideoFeedLoadFinished(FWError? error) {
    FWExampleLoggerUtil.log(
        "_onVideoFeedLoadFinished error ${error?.displayString()}");
    if (_feedError != error && mounted) {
      setState(() {
        _feedError = error;
      });
    }
  }

  void _onVideoFeedDidStartPictureInPicture(FWError? error) {
    FWExampleLoggerUtil.log(
        "_onVideoFeedDidStartPictureInPicture error ${error?.displayString()}");
  }

  void _onVideoFeedDidStopPictureInPicture(FWError? error) {
    FWExampleLoggerUtil.log(
        "_onVideoFeedDidStopPictureInPicture error ${error?.displayString()}");
  }

  Widget _buildSeperator(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 1,
        color: const Color.fromARGB(255, 202, 200, 200),
      ),
    );
  }

  Widget _buildItem({
    required BuildContext context,
    required String leftText,
    required String rightText,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        children: [
          Text(
            leftText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            rightText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 110, 109, 109),
            ),
          ),
        ],
      ),
    );
  }

  void _goPlaylistConfiguration() async {
    final result = await Navigator.of(context).pushNamed(
      "/playlist_configuration",
    );
    FWExampleLoggerUtil.log(
        "playlist_configuration result: $result type: ${result?.runtimeType}");

    if (result is Map<String, String>) {
      final channelId = result["channelId"] ?? "";
      final playlistId = result["playlistId"] ?? "";
      if (channelId.isNotEmpty && playlistId.isNotEmpty && mounted) {
        setState(() {
          _channelId = channelId;
          _playlistId = playlistId;
        });
      }
    }
  }

  Widget _buildConfigButtonList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/shopping_configuration");
        },
        child: Text(
          S.of(context).shoppingConfiguration,
        ),
      ),
    );
  }

  void _refresh() {
    if (_feedError != null && mounted) {
      setState(() {
        _feedError = null;
      });
    }
    _feedController?.refresh();
  }
}
