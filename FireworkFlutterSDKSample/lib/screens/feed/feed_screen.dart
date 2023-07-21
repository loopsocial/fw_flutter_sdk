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
              if (_feedWidgetType == FeedWidgetType.storyBlock &&
                  defaultTargetPlatform == TargetPlatform.android)
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
    final showEnablePictureInPicture =
        defaultTargetPlatform == TargetPlatform.iOS ||
            _feedWidgetType == FeedWidgetType.videoFeed;
    if (_source != 'playlistGroup') {
      widgetList.addAll(<Widget>[
        const SizedBox(
          height: 20,
        ),
        _buildFeedWidgetTypeSegmentedControl(context),
        const SizedBox(
          height: 10,
        ),
        if (showEnablePictureInPicture) _buildEnablePictureInPicture(context),
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
        _buildFeed(context),
      ]);
    } else {
      widgetList.addAll([
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

    FWExampleLoggerUtil.log("_FeedScreenState _buildFeed source $source");
    FWExampleLoggerUtil.log("_FeedScreenState _buildFeed channel $channel");
    FWExampleLoggerUtil.log(
        "_FeedScreenState _buildFeed dynamicContentParameters $dynamicContentParameters");
    FWExampleLoggerUtil.log(
        "_FeedScreenState _buildFeed _hashtagFilterExpression $_hashtagFilterExpression");
    final feedWidget = VideoFeed(
      height: 220,
      width: (_mode == VideoFeedMode.column && Platform.isAndroid) ? 150 : null,
      source: source,
      channel: channel,
      playlist: playlist,
      playlistGroup: playlistGroup,
      dynamicContentParameters: dynamicContentParameters,
      hashtagFilterExpression: hashtagFilterExpression,
      productIds: productIds,
      mode: _mode,
      enablePictureInPicture: _enablePip,
      videoFeedConfiguration: resultFeedConfiguration,
      videoPlayerConfiguration: playerConfiguration,
      adConfiguration: adConfiguration,
      onVideoFeedLoadFinished: _onVideoFeedLoadFinished,
      onVideoFeedCreated: _onVideoFeedCreated,
    );

    return Expanded(
      flex: _mode == VideoFeedMode.row ? 0 : 1,
      child: Padding(
        padding: defaultTargetPlatform == TargetPlatform.android
            ? _androidPadding
            : EdgeInsets.zero,
        child: Container(
          color:
              feedConfiguration.titlePosition == VideoFeedTitlePosition.stacked
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
    final storyBlockConfiguration =
        context.watch<StoryBlockConfigurationState>().storyBlockConfiguration;
    FWExampleLoggerUtil.log("_FeedScreenState _buildStoryBlock source $source");
    FWExampleLoggerUtil.log(
        "_FeedScreenState _buildStoryBlock channel $channel");
    FWExampleLoggerUtil.log(
        "_FeedScreenState _buildStoryBlock dynamicContentParameters $dynamicContentParameters");

    return Expanded(
      child: Padding(
        padding: _androidPadding,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: defaultTargetPlatform == TargetPlatform.android ? 20 : 0,
            ),
            child: StoryBlock(
              source: source,
              channel: channel,
              playlist: playlist,
              dynamicContentParameters: dynamicContentParameters,
              hashtagFilterExpression: hashtagFilterExpression,
              productIds: productIds,
              adConfiguration: AdConfiguration(requiresAds: false),
              storyBlockConfiguration: storyBlockConfiguration,
              enablePictureInPicture: _enablePip,
              cornerRadius: 20,
              onStoryBlockLoadFinished: _onStoryBlockLoadFinished,
              onStoryBlockCreated: _onStoryBlockCreated,
            ),
          ),
        ),
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

  void _onStoryBlockLoadFinished(FWError? error) {
    FWExampleLoggerUtil.log(
        "_onStoryBlockLoadFinished error ${error?.displayString()}");
    if (_feedError != error && mounted) {
      setState(() {
        _feedError = error;
      });
    }
  }

  void _onStoryBlockCreated(StoryBlockController controller) {
    FWExampleLoggerUtil.log("_onVideoFeedCreated");
    _storyBlockController = controller;
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
}
