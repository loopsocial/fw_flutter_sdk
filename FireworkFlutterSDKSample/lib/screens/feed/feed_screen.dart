import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/states/feed_configuration_state.dart';
import 'package:fw_flutter_sdk_example/states/player_configuration_state.dart';
import 'package:fw_flutter_sdk_example/utils/fw_example_logger_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../generated/l10n.dart';
import '../../extensions/fw_error_extensions.dart';
import '../../widgets/fw_app_bar.dart';

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
  VideoFeedController? _feedController;
  FWError? _feedError;

  @override
  void initState() {
    super.initState();
    FWExampleLoggerUtil.log("FeedConfigurationState initState");
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
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
        ],
      ),
    );
  }

  Widget _buildModeSegmentedControl(BuildContext context) {
    return CupertinoSegmentedControl<VideoFeedMode>(
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
    final playerConfiguration =
        context.watch<PlayerConfigurationState>().playerConfiguration;
    VideoFeedSource source = VideoFeedSource.discover;
    String? channel;
    String? playlist;
    String? playlistGroup;

    if (widget.settings.arguments is Map<dynamic, dynamic>) {
      final arg = widget.settings.arguments as Map<dynamic, dynamic>;

      if (arg["source"] is VideoFeedSource) {
        source = arg["source"] as VideoFeedSource;
      }

      if (arg["channel"] is String) {
        channel = arg["channel"] as String;
      }

      if (arg["playlist"] is String) {
        playlist = arg["playlist"] as String;
      }

      if (arg["playlistGroup"] is String) {
        playlistGroup = arg["playlistGroup"] as String;
      }
    }
    final feedWidget = VideoFeed(
      height: 200,
      source: source,
      channel: channel,
      playlist: playlist,
      playlistGroup: playlistGroup,
      mode: _mode,
      videoFeedConfiguration: feedConfiguration,
      videoPlayerConfiguration: playerConfiguration,
      onVideoFeedLoadFinished: _onVideoFeedLoadFinished,
      onVideoFeedCreated: _onVideoFeedCreated,
    );

    return Expanded(
      flex: _mode == VideoFeedMode.row ? 0 : 1,
      child: feedWidget,
    );
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

  void _refresh() {
    setState(() {
      _feedError = null;
    });
    _feedController?.refresh();
  }
}
