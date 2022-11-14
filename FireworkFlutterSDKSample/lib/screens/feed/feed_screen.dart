import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/extensions/video_feed_configuration_extension.dart';
import 'package:fw_flutter_sdk_example/states/feed_configuration_state.dart';
import 'package:fw_flutter_sdk_example/states/player_configuration_state.dart';
import 'package:fw_flutter_sdk_example/utils/fw_example_logger_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../generated/l10n.dart';
import '../../extensions/fw_error_extension.dart';
import '../../widgets/fw_app_bar.dart';

enum FeedWidgetType {
  videoFeed,
  storyBlock,
}

class FeedScreen extends StatefulWidget {
  final RouteSettings settings;
  const FeedScreen({
    Key? key,
    required this.settings,
  }) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  VideoFeedMode _mode = VideoFeedMode.row;
  FeedWidgetType _feedWidgetType = FeedWidgetType.videoFeed;
  VideoFeedController? _feedController;
  FWError? _feedError;

  String? _source;
  String? _channel;
  String? _playlist;
  String? _playlistGroup;
  Map<String, List<String>>? _dynamicContentParameters;

  @override
  void initState() {
    super.initState();
    FWExampleLoggerUtil.log("FeedConfigurationState initState");

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
    }
  }

  @override
  Widget build(BuildContext context) {
    FWExampleLoggerUtil.log("FeedConfigurationState build");
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
                    _refresh();
                  },
                  icon: const Icon(
                    Icons.refresh,
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

    if (_source != 'playlistGroup' &&
        defaultTargetPlatform == TargetPlatform.iOS) {
      widgetList.addAll(<Widget>[
        const SizedBox(
          height: 20,
        ),
        _buildFeedWidgetTypeSegmentedControl(context),
      ]);
    }

    if (_feedWidgetType == FeedWidgetType.videoFeed) {
      widgetList.addAll(<Widget>[
        const SizedBox(
          height: 20,
        ),
        _buildModeSegmentedControl(context),
        const SizedBox(
          height: 20,
        ),
        _buildConfigButtonList(context),
        const SizedBox(
          height: 20,
        ),
        _buildFeed(context),
      ]);
    } else {
      widgetList.addAll([
        const SizedBox(
          height: 20,
        ),
        _buildStoryBlock(context),
      ]);
    }

    var crossAxisAlignment = CrossAxisAlignment.stretch;
    if (_feedWidgetType == FeedWidgetType.storyBlock) {
      crossAxisAlignment = CrossAxisAlignment.center;
    } else if (_feedWidgetType == FeedWidgetType.videoFeed &&
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
    final resultConfiguration = feedConfiguration.clone();
    if (_mode == VideoFeedMode.column) {
      resultConfiguration.aspectRatio = 1;
    } else {
      resultConfiguration.aspectRatio = null;
    }
    VideoFeedSource source = VideoFeedSource.values.firstWhere(
        (e) => e.toString() == 'VideoFeedSource.${_source ?? ''}',
        orElse: () => VideoFeedSource.discover);
    String? channel = _channel;
    String? playlist = _playlist;
    String? playlistGroup = _playlistGroup;
    Map<String, List<String>>? dynamicContentParameters =
        _dynamicContentParameters;

    FWExampleLoggerUtil.log("_FeedScreenState _buildFeed source $source");
    FWExampleLoggerUtil.log("_FeedScreenState _buildFeed channel $channel");
    FWExampleLoggerUtil.log(
        "_FeedScreenState _buildFeed dynamicContentParameters $dynamicContentParameters");
    FWExampleLoggerUtil.log(
        "_FeedScreenState _buildFeed enablePictureInPicture ${resultConfiguration.enablePictureInPicture}");

    final feedWidget = VideoFeed(
      height: 200,
      width: (_mode == VideoFeedMode.column && Platform.isAndroid) ? 150 : null,
      source: source,
      channel: channel,
      playlist: playlist,
      playlistGroup: playlistGroup,
      dynamicContentParameters: dynamicContentParameters,
      mode: _mode,
      videoFeedConfiguration: resultConfiguration,
      videoPlayerConfiguration: playerConfiguration,
      adConfiguration: adConfiguration,
      onVideoFeedLoadFinished: _onVideoFeedLoadFinished,
      onVideoFeedCreated: _onVideoFeedCreated,
    );

    return Expanded(
      flex: _mode == VideoFeedMode.row ? 0 : 1,
      child: feedWidget,
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

    FWExampleLoggerUtil.log("_FeedScreenState _buildStoryBlock source $source");
    FWExampleLoggerUtil.log(
        "_FeedScreenState _buildStoryBlock channel $channel");
    FWExampleLoggerUtil.log(
        "_FeedScreenState _buildStoryBlock dynamicContentParameters $dynamicContentParameters");

    return Expanded(
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          clipBehavior: Clip.hardEdge,
          child: StoryBlock(
            width: 350,
            source: source,
            channel: channel,
            playlist: playlist,
            dynamicContentParameters: dynamicContentParameters,
            onStoryBlockLoadFinished: _onStoryBlockLoadFinished,
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
    setState(() {
      _feedError = error;
    });
  }

  void _onStoryBlockLoadFinished(FWError? error) {
    FWExampleLoggerUtil.log(
        "_onStoryBlockLoadFinished error ${error?.displayString()}");
    setState(() {
      _feedError = error;
    });
  }

  void _refresh() {
    setState(() {
      _feedError = null;
    });
    _feedController?.refresh();
  }
}
