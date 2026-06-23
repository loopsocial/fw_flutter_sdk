import 'package:flutter/foundation.dart';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../extensions/fw_error_extension.dart';
import '../../generated/l10n.dart';
import '../../states/player_configuration_state.dart';
import '../../states/player_deck_configuration_state.dart';
import '../../utils/fw_example_logger_util.dart';
import '../../widgets/fw_app_bar.dart';

class PlayerDeckScreen extends StatefulWidget {
  final RouteSettings settings;
  const PlayerDeckScreen({
    Key? key,
    required this.settings,
  }) : super(key: key);

  @override
  State<PlayerDeckScreen> createState() => _PlayerDeckScreenState();
}

class _PlayerDeckScreenState extends State<PlayerDeckScreen>
    with SingleTickerProviderStateMixin {
  PlayerDeckController? _controller;
  FWError? _feedError;
  bool _enablePip = true;
  bool _enableKeepingAlive = true;
  late final TabController _tabController;

  String? _source;
  String? _channel;
  String? _playlist;
  String? _playlistGroup;
  Map<String, List<String>>? _dynamicContentParameters;
  String? _hashtagFilterExpression;
  List<String>? _productIds;
  String? _contentId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? titleText;
    if (widget.settings.arguments is Map<dynamic, dynamic>) {
      final arg = widget.settings.arguments as Map<dynamic, dynamic>;
      if (arg["title"] is String && (arg["title"] as String).isNotEmpty) {
        titleText = arg["title"] as String;
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: fwAppBar(
        context: context,
        titleText: titleText ?? S.of(context).playerDeck,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/player_deck_configuration');
            },
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/player_configuration');
            },
            icon: const Icon(Icons.video_settings),
          ),
          Semantics(
            label: 'Refresh',
            child: IconButton(
              onPressed: _refreshPlayerDeck,
              icon: const Icon(Icons.refresh),
            ),
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          _buildSourceInfo(context),
          _buildEnablePictureInPicture(context),
          _buildEnableKeepingAlive(context),
          const SizedBox(height: 10),
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: S.of(context).playerDeck),
              const Tab(text: 'Tab Test'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              // Disable swipe-to-switch so a horizontal swipe on the player
              // deck scrolls the deck itself instead of changing tabs. Tabs are
              // switched only by tapping the TabBar.
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildPlayerDeck(context),
                _buildTabSwitchTest(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Text(
        'Source: ${_source ?? "discover"}'
        '${_channel != null ? " | Channel: $_channel" : ""}'
        '${_playlist != null ? " | Playlist: $_playlist" : ""}',
        style: const TextStyle(fontSize: 12, color: Colors.grey),
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
        title: const Text("Enable Picture in Picture"),
      ),
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
        title: Text(S.of(context).enableKeepingAlive),
      ),
    );
  }

  Widget _buildPlayerDeck(BuildContext context) {
    if (_feedError != null) {
      return _buildErrorWidget(context);
    }

    VideoFeedSource source =
        VideoFeedSource.values.asNameMap()[_source ?? ""] ??
            VideoFeedSource.discover;

    final deckConfig =
        context.watch<PlayerDeckConfigurationState>().playerDeckConfiguration;
    final playerConfig =
        context.watch<PlayerConfigurationState>().playerConfiguration;

    final deckWidget = PlayerDeck(
      height: 381,
      source: source,
      channel: _channel,
      playlist: _playlist,
      playlistGroup: _playlistGroup,
      dynamicContentParameters: _dynamicContentParameters,
      hashtagFilterExpression: _hashtagFilterExpression,
      productIds: _productIds,
      contentId: _contentId,
      enablePictureInPicture: _enablePip,
      wantKeepAlive: _enableKeepingAlive,
      playerDeckConfiguration: deckConfig,
      videoPlayerConfiguration: playerConfig,
      onPlayerDeckCreated: _onPlayerDeckCreated,
      onPlayerDeckLoadFinished: _onPlayerDeckLoadFinished,
      onPlayerDeckEmpty: _onPlayerDeckEmpty,
      onPlayerDeckDidStartPictureInPicture:
          _onPlayerDeckDidStartPictureInPicture,
      onPlayerDeckDidStopPictureInPicture: _onPlayerDeckDidStopPictureInPicture,
      onPlayerDeckGetFeedId: _onPlayerDeckGetFeedId,
    );

    return ListView(
      key: const PageStorageKey<String>('player-deck-scroll-list'),
      children: [
        _buildListItemPlaceholder(context),
        _buildListItemPlaceholder(context),
        _buildListItemPlaceholder(context),
        _buildListItemPlaceholder(context),
        Padding(
          padding: defaultTargetPlatform == TargetPlatform.android
              ? const EdgeInsets.symmetric(horizontal: 10)
              : EdgeInsets.zero,
          child: deckWidget,
        ),
        _buildListItemPlaceholder(context),
        _buildListItemPlaceholder(context),
        _buildListItemPlaceholder(context),
        _buildListItemPlaceholder(context),
        _buildListItemPlaceholder(context),
        _buildListItemPlaceholder(context),
        _buildListItemPlaceholder(context),
        _buildListItemPlaceholder(context),
      ],
    );
  }

  Widget _buildTabSwitchTest(BuildContext context) {
    return ListView(
      key: const PageStorageKey<String>('player-deck-tab-test-scroll-list'),
      children: [
        _buildListItemPlaceholder(context),
        _buildListItemPlaceholder(context),
        _buildListItemPlaceholder(context),
      ],
    );
  }

  Widget _buildListItemPlaceholder(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      color: Colors.grey,
      height: 200,
      child: const Center(
        child: Text('List item placeholder'),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: _refreshPlayerDeck,
              child: const Text("Refresh"),
            ),
            const SizedBox(height: 15),
            Text(_feedError?.reason ?? "Player deck failed to load"),
          ],
        ),
      ),
    );
  }

  void _onPlayerDeckCreated(PlayerDeckController controller) {
    FWExampleLoggerUtil.log("_onPlayerDeckCreated");
    _controller = controller;
  }

  void _onPlayerDeckLoadFinished(FWError? error) {
    FWExampleLoggerUtil.log(
        "_onPlayerDeckLoadFinished error ${error?.displayString()}");
    if (_feedError != error && mounted) {
      setState(() {
        _feedError = error;
      });
    }
  }

  void _onPlayerDeckEmpty(FWError? error) {
    FWExampleLoggerUtil.log(
        "_onPlayerDeckEmpty error ${error?.displayString()}");
  }

  void _onPlayerDeckDidStartPictureInPicture(FWError? error) {
    FWExampleLoggerUtil.log(
        "_onPlayerDeckDidStartPictureInPicture error ${error?.displayString()}");
  }

  void _onPlayerDeckDidStopPictureInPicture(FWError? error) {
    FWExampleLoggerUtil.log(
        "_onPlayerDeckDidStopPictureInPicture error ${error?.displayString()}");
  }

  void _onPlayerDeckGetFeedId(String feedId) {
    FWExampleLoggerUtil.log("_onPlayerDeckGetFeedId feedId $feedId");
  }

  void _refreshPlayerDeck() {
    if (_feedError != null && mounted) {
      setState(() {
        _feedError = null;
      });
    }
    _controller?.refresh();
  }
}
