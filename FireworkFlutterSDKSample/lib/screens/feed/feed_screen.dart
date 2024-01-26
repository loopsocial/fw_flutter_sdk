import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/states/feed_configuration_state.dart';
import 'package:fw_flutter_sdk_example/states/player_configuration_state.dart';
import 'package:fw_flutter_sdk_example/states/story_block_configuration_state.dart';
import 'package:fw_flutter_sdk_example/utils/fw_example_logger_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../generated/l10n.dart';
import '../../extensions/fw_error_extension.dart';
import '../../models/feed_widget_type.dart';
import '../../widgets/fw_app_bar.dart';

class FeedScreen extends StatefulWidget {
  final RouteSettings settings;
  const FeedScreen({
    Key? key,
    required this.settings,
  }) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  VideoFeedMode _mode = VideoFeedMode.row;
  bool _enablePip = true;
  bool _enableKeepingAlive = false;
  FeedWidgetType _feedWidgetType = FeedWidgetType.videoFeed;
  VideoFeedController? _feedController;
  StoryBlockController? _storyBlockController;

  FWError? _feedError;

  String? _source;
  String? _channel;
  String? _playlist;
  String? _playlistGroup;
  Map<String, List<String>>? _dynamicContentParameters;
  String? _hashtagFilterExpression;
  List<String>? _productIds;
  String? _contentId;

  final _androidPadding = const EdgeInsets.symmetric(horizontal: 10);

  @override
  void initState() {
    super.initState();
    FWExampleLoggerUtil.log(
        "FeedConfigurationState initState ${DateTime.now()}");

    if (widget.settings.arguments is Map<dynamic, dynamic>) {
      final arg = widget.settings.arguments as Map<dynamic, dynamic>;

      if (arg["source"] is String) {
        _source = arg["source"] as String;
      }

      if (arg["channel"] is String) {
        _channel = arg["channel"] as String;
      }

      if (arg["playlist"] is String) {
        _playlist = arg["playlist"] as String;
      }

      if (arg["playlistGroup"] is String) {
        _playlistGroup = arg["playlistGroup"] as String;
      }

      if (arg["dynamicContentParameters"] is Map<String, List<String>>) {
        _dynamicContentParameters =
            arg["dynamicContentParameters"] as Map<String, List<String>>;
      }

      if (arg["hashtagFilterExpression"] is String) {
        _hashtagFilterExpression = arg["hashtagFilterExpression"] as String;
      }

      if (arg["productIds"] is List<String>) {
        _productIds = arg["productIds"] as List<String>;
      }

      if (arg["contentId"] is String) {
        _contentId = arg["contentId"] as String;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    FWExampleLoggerUtil.log(
        "FeedConfigurationState build ${DateTime.now()}${DateTime.now()}");
    String? titleText;
    if (widget.settings.arguments is Map<dynamic, dynamic>) {
      final arg = widget.settings.arguments as Map<dynamic, dynamic>;
      if (arg["title"] is String && (arg["title"] as String).isNotEmpty) {
        titleText = arg["title"] as String;
      }
    }

    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: fwAppBar(
            context: context,
            titleText: titleText ?? S.of(context).feed,
            actions: [
              if (_feedWidgetType == FeedWidgetType.videoFeed)
                IconButton(
                  onPressed: () {
                    _refreshVideoFeed();
                  },
                  icon: const Icon(
                    Icons.refresh,
                  ),
                ),
              if (_feedWidgetType == FeedWidgetType.storyBlock)
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed("/story_block_configuration");
                  },
                  icon: const Icon(
                    Icons.settings,
                  ),
                ),
              if (_feedWidgetType == FeedWidgetType.storyBlock)
                IconButton(
                  onPressed: () {
                    _playStoryBlock();
                  },
                  icon: const Icon(
                    Icons.play_circle,
                  ),
                ),
              if (_feedWidgetType == FeedWidgetType.storyBlock)
                IconButton(
                  onPressed: () {
                    _pauseStoryBlock();
                  },
                  icon: const Icon(
                    Icons.pause_circle,
                  ),
                ),
              if (_feedWidgetType == FeedWidgetType.storyBlock)
                IconButton(
                  onPressed: () {
                    _openFullScreenStoryBlock();
                  },
                  icon: const Icon(
                    Icons.fullscreen,
                  ),
                ),
            ],
          ),
          body: _buildBody(context),
        ),
        onWillPop: () async {
          FWExampleLoggerUtil.log("FeedConfigurationState onWillPop");
          context.read<FeedConfigurationState>().reset();
          context.read<PlayerConfigurationState>().reset();

          return true;
        });
  }

  Widget _buildBody(BuildContext context) {
    List<Widget> widgetList = [];

    if (_source != 'playlistGroup') {
      widgetList.addAll(<Widget>[
        const SizedBox(
          height: 20,
        ),
        _buildFeedWidgetTypeSegmentedControl(context),
        const SizedBox(
          height: 10,
        ),
        _buildEnablePictureInPicture(context),
      ]);
    }

    if (_feedWidgetType == FeedWidgetType.videoFeed) {
      widgetList.addAll(<Widget>[
        const SizedBox(
          height: 10,
        ),
        _buildModeSegmentedControl(context),
        const SizedBox(
          height: 10,
        ),
        _buildConfigButtonList(context),
        const SizedBox(
          height: 10,
        ),
        if (_mode == VideoFeedMode.row) _buildEnableKeepingAlive(context),
        _buildFeed(context),
      ]);
    } else {
      widgetList.addAll([
        const SizedBox(
          height: 10,
        ),
        _buildEnableKeepingAlive(context),
        const SizedBox(
          height: 10,
        ),
        _buildStoryBlock(context),
      ]);
    }

    var crossAxisAlignment = CrossAxisAlignment.stretch;
    if (_feedWidgetType == FeedWidgetType.videoFeed &&
        _mode == VideoFeedMode.column &&
        Platform.isAndroid) {
      crossAxisAlignment = CrossAxisAlignment.center;
    }

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: crossAxisAlignment,
        children: widgetList,
      ),
    );
  }

  Widget _buildFeedWidgetTypeSegmentedControl(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoSegmentedControl<FeedWidgetType>(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        onValueChanged: (value) {
          setState(() {
            _feedWidgetType = value;
            _feedError = null;
          });
        },
        children: {
          FeedWidgetType.videoFeed: Text(
            S.of(context).videoFeed,
            style: const TextStyle(fontSize: 13),
          ),
          FeedWidgetType.storyBlock: Text(
            S.of(context).storyBlock,
            style: const TextStyle(fontSize: 13),
          ),
        },
        groupValue: _feedWidgetType,
      ),
    );
  }

  Widget _buildEnablePictureInPicture(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CheckboxListTile(
        contentPadding: EdgeInsets.zero,
        value: _enablePip,
        onChanged: (value) {
          setState(() {
            _enablePip = value ?? false;
          });
        },
        title: Text(
          S.of(context).enablePictureInPicture,
        ),
      ),
    );
  }

  Widget _buildModeSegmentedControl(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoSegmentedControl<VideoFeedMode>(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        onValueChanged: (value) {
          setState(() {
            _mode = value;
          });
        },
        children: {
          VideoFeedMode.row: Text(
            S.of(context).row,
            style: const TextStyle(fontSize: 13),
          ),
          VideoFeedMode.column: Text(
            S.of(context).column,
            style: const TextStyle(fontSize: 13),
          ),
          VideoFeedMode.grid: Text(
            S.of(context).grid,
            style: const TextStyle(fontSize: 13),
          ),
        },
        groupValue: _mode,
      ),
    );
  }

  Widget _buildConfigButtonList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/feed_configuration");
            },
            child: Text(
              S.of(context).feedConfiguration,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/player_configuration");
            },
            child: Text(
              S.of(context).playerConfiguration,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildEnableKeepingAlive(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CheckboxListTile(
        contentPadding: EdgeInsets.zero,
        value: _enableKeepingAlive,
        onChanged: (value) {
          setState(() {
            _enableKeepingAlive = value ?? false;
          });
        },
        title: Text(
          S.of(context).enableKeepingAlive,
        ),
      ),
    );
  }

  Widget _buildFeed(BuildContext context) {
    if (_feedError != null) {
      return _buildErrorWidget(context);
    }

    final feedConfiguration =
        context.watch<FeedConfigurationState>().feedConfiguration;
    final adConfiguration =
        context.watch<FeedConfigurationState>().adConfiguration;
    final playerConfiguration =
        context.watch<PlayerConfigurationState>().playerConfiguration;
    final resultFeedConfiguration = feedConfiguration.deepCopy();
    if (feedConfiguration.titlePosition == VideoFeedTitlePosition.stacked) {
      resultFeedConfiguration.titlePadding =
          VideoFeedPadding(top: 8, right: 8, bottom: 0, left: 8);
    }
    VideoFeedSource source =
        VideoFeedSource.values.asNameMap()[_source ?? ""] ??
            VideoFeedSource.discover;
    String? channel = _channel;
    String? playlist = _playlist;
    String? playlistGroup = _playlistGroup;
    Map<String, List<String>>? dynamicContentParameters =
        _dynamicContentParameters;
    String? hashtagFilterExpression = _hashtagFilterExpression;
    List<String>? productIds = _productIds;
    String? contentId = _contentId;

    FWExampleLoggerUtil.log("_FeedScreenState _buildFeed source $source");
    FWExampleLoggerUtil.log("_FeedScreenState _buildFeed channel $channel");
    FWExampleLoggerUtil.log(
        "_FeedScreenState _buildFeed dynamicContentParameters $dynamicContentParameters");
    FWExampleLoggerUtil.log(
        "_FeedScreenState _buildFeed _hashtagFilterExpression $_hashtagFilterExpression");
    final feedWidget = VideoFeed(
      wantKeepAlive: _mode == VideoFeedMode.row ? _enableKeepingAlive : null,
      height: 220,
      width: (_mode == VideoFeedMode.column && Platform.isAndroid) ? 150 : null,
      source: source,
      channel: channel,
      playlist: playlist,
      playlistGroup: playlistGroup,
      dynamicContentParameters: dynamicContentParameters,
      hashtagFilterExpression: hashtagFilterExpression,
      productIds: productIds,
      contentId: contentId,
      mode: _mode,
      enablePictureInPicture: _enablePip,
      videoFeedConfiguration: resultFeedConfiguration,
      videoPlayerConfiguration: playerConfiguration,
      adConfiguration: adConfiguration,
      onVideoFeedLoadFinished: _onVideoFeedLoadFinished,
      onVideoFeedEmpty: _onVideoFeedEmpty,
      onVideoFeedCreated: _onVideoFeedCreated,
      onVideoFeedDidStartPictureInPicture: _onVideoFeedDidStartPictureInPicture,
      onVideoFeedDidStopPictureInPicture: _onVideoFeedDidStopPictureInPicture,
      onVideoFeedGetFeedId: _onVideoFeedGetFeedId,
    );

    return _mode == VideoFeedMode.row
        ? Expanded(
            child: ListView(children: [
              Container(
                color: feedConfiguration.titlePosition ==
                        VideoFeedTitlePosition.stacked
                    ? Colors.grey
                    : null,
                child: Padding(
                  padding: defaultTargetPlatform == TargetPlatform.android
                      ? _androidPadding
                      : EdgeInsets.zero,
                  child: feedWidget,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _buildListItemPlaceholder(context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _buildListItemPlaceholder(context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _buildListItemPlaceholder(context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _buildListItemPlaceholder(context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _buildListItemPlaceholder(context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _buildListItemPlaceholder(context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _buildListItemPlaceholder(context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _buildListItemPlaceholder(context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _buildListItemPlaceholder(context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _buildListItemPlaceholder(context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _buildListItemPlaceholder(context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _buildListItemPlaceholder(context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _buildListItemPlaceholder(context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _buildListItemPlaceholder(context),
              ),
            ]),
          )
        : Expanded(
            child: Padding(
              padding: defaultTargetPlatform == TargetPlatform.android
                  ? _androidPadding
                  : EdgeInsets.zero,
              child: Container(
                color: feedConfiguration.titlePosition ==
                        VideoFeedTitlePosition.stacked
                    ? Colors.grey
                    : null,
                child: feedWidget,
              ),
            ),
          );
  }

  Widget _buildStoryBlock(BuildContext context) {
    if (_feedError != null) {
      return _buildErrorWidget(context);
    }
    StoryBlockSource source = StoryBlockSource.values.firstWhere(
        (e) => e.toString() == 'StoryBlockSource.${_source ?? ''}',
        orElse: () => StoryBlockSource.discover);
    String? channel = _channel;
    String? playlist = _playlist;
    Map<String, List<String>>? dynamicContentParameters =
        _dynamicContentParameters;
    String? hashtagFilterExpression = _hashtagFilterExpression;
    List<String>? productIds = _productIds;
    String? contentId = _contentId;
    final storyBlockConfiguration =
        context.watch<StoryBlockConfigurationState>().storyBlockConfiguration;
    FWExampleLoggerUtil.log("_FeedScreenState _buildStoryBlock source $source");
    FWExampleLoggerUtil.log(
        "_FeedScreenState _buildStoryBlock channel $channel");
    FWExampleLoggerUtil.log(
        "_FeedScreenState _buildStoryBlock dynamicContentParameters $dynamicContentParameters");

    return Expanded(
      child: ListView(
        padding: defaultTargetPlatform == TargetPlatform.android
            ? _androidPadding
            : const EdgeInsets.symmetric(horizontal: 10),
        children: [
          StoryBlock(
            wantKeepAlive: _enableKeepingAlive,
            height: defaultTargetPlatform == TargetPlatform.android ? 400 : 500,
            source: source,
            channel: channel,
            playlist: playlist,
            dynamicContentParameters: dynamicContentParameters,
            hashtagFilterExpression: hashtagFilterExpression,
            productIds: productIds,
            contentId: contentId,
            adConfiguration: AdConfiguration(requiresAds: false),
            storyBlockConfiguration: storyBlockConfiguration,
            enablePictureInPicture: _enablePip,
            cornerRadius: 20,
            onStoryBlockLoadFinished: _onStoryBlockLoadFinished,
            onStoryBlockEmpty: _onStoryBlockEmpty,
            onStoryBlockCreated: _onStoryBlockCreated,
            onStoryBlockDidStartPictureInPicture:
                _onStoryBlockDidStartPictureInPicture,
            onStoryBlockDidStopPictureInPicture:
                _onStoryBlockDidStopPictureInPicture,
            onStoryBlockGetFeedId: _onStoryBlockGetFeedId,
          ),
          _buildListItemPlaceholder(context),
          _buildListItemPlaceholder(context),
          _buildListItemPlaceholder(context),
          _buildListItemPlaceholder(context),
          _buildListItemPlaceholder(context),
          _buildListItemPlaceholder(context),
          _buildListItemPlaceholder(context),
          _buildListItemPlaceholder(context),
          _buildListItemPlaceholder(context),
          _buildListItemPlaceholder(context),
          _buildListItemPlaceholder(context),
          _buildListItemPlaceholder(context),
          _buildListItemPlaceholder(context),
          _buildListItemPlaceholder(context),
          _buildListItemPlaceholder(context),
        ],
      ),
    );
  }

  Widget _buildListItemPlaceholder(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      color: Colors.grey,
      height: 200,
      child: const Center(
        child: Text('List item placeholder'),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context) {
    final defaultErrorText = _feedWidgetType == FeedWidgetType.videoFeed
        ? S.of(context).videoFeedLoadError
        : S.of(context).storyBlockLoadError;
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
                _refreshVideoFeed();
              },
              child: Text(
                S.of(context).refresh,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              _feedError?.reason ?? defaultErrorText,
            ),
          ],
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

  void _onVideoFeedEmpty(FWError? error) {
    FWExampleLoggerUtil.log(
        "_onVideoFeedEmpty error ${error?.displayString()}");
  }

  void _onVideoFeedDidStartPictureInPicture(FWError? error) {
    FWExampleLoggerUtil.log(
        "_onVideoFeedDidStartPictureInPicture error ${error?.displayString()}");
  }

  void _onVideoFeedDidStopPictureInPicture(FWError? error) {
    FWExampleLoggerUtil.log(
        "_onVideoFeedDidStopPictureInPicture error ${error?.displayString()}");
  }

  void _onVideoFeedGetFeedId(String feedId) {
    FWExampleLoggerUtil.log("_onVideoFeedGetFeedId feedId $feedId");
  }

  void _onStoryBlockLoadFinished(FWError? error) {
    FWExampleLoggerUtil.log(
        "_onStoryBlockLoadFinished error ${error?.displayString()}");
    if (_feedError != error && mounted) {
      setState(() {
        _feedError = error;
      });
    }
  }

  void _onStoryBlockEmpty(FWError? error) {
    FWExampleLoggerUtil.log(
        "_onStoryBlockEmpty error ${error?.displayString()}");
  }

  void _onStoryBlockCreated(StoryBlockController controller) {
    FWExampleLoggerUtil.log("_onStoryBlockCreated");
    _storyBlockController = controller;
  }

  void _onStoryBlockDidStartPictureInPicture(FWError? error) {
    FWExampleLoggerUtil.log(
        "_onStoryBlockDidStartPictureInPicture error ${error?.displayString()}");
  }

  void _onStoryBlockDidStopPictureInPicture(FWError? error) {
    FWExampleLoggerUtil.log(
        "_onStoryBlockDidStopPictureInPicture error ${error?.displayString()}");
  }

  void _onStoryBlockGetFeedId(String feedId) {
    FWExampleLoggerUtil.log("_onStoryBlockGetFeedId feedId $feedId");
  }

  void _refreshVideoFeed() {
    if (_feedError != null && mounted) {
      setState(() {
        _feedError = null;
      });
    }
    _feedController?.refresh();
  }

  void _playStoryBlock() {
    if (_feedError != null && mounted) {
      setState(() {
        _feedError = null;
      });
    }
    _storyBlockController?.play();
  }

  void _pauseStoryBlock() {
    if (_feedError != null && mounted) {
      setState(() {
        _feedError = null;
      });
    }
    _storyBlockController?.pause();
  }

  void _openFullScreenStoryBlock() {
    _storyBlockController?.openFullscreen();
  }
}
