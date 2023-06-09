import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../extensions/fw_error_extension.dart';
import '../../generated/l10n.dart';
import '../../utils/fw_example_logger_util.dart';
import '../../widgets/fw_app_bar.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  VideoFeedController? _feedController;
  String? _channelId;
  String? _playlistId;
  FWError? _feedError;
  bool _enablePip = true;

  @override
  void initState() {
    super.initState();
    _readConfig();
  }

  Future<void> _readConfig() async {
    await _readFeedConfig();
  }

  Future<void> _readFeedConfig() async {
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
      }
    } catch (e) {
      FWExampleLoggerUtil.log(
          "_ShoppingScreenState _readShopifyConfig error: $e");
    }

    FWExampleLoggerUtil.log(
        "_ShoppingScreenState _channelId: $_channelId _playlistId: $_playlistId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: fwAppBar(
        context: context,
        titleText: S.of(context).shopping,
        actions: [
          IconButton(
            onPressed: () {
              _refresh();
            },
            icon: const Icon(
              Icons.refresh,
            ),
          ),
          IconButton(
            onPressed: () {
              _goPlaylistConfiguration();
            },
            icon: const Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
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

    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 20,
            ),
            _buildEnablePictureInPicture(context),
            const SizedBox(
              height: 20,
            ),
            _buildFeed(context),
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
        ),
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

  Widget _buildFeed(BuildContext context) {
    if (_feedError != null) {
      return _buildErrorWidget(context);
    }
    VideoFeedConfiguration feedConfiguration = VideoFeedConfiguration(
      titlePosition: VideoFeedTitlePosition.nested,
      title: VideoFeedTitleConfiguration(
        hidden: false,
      ),
      showAdBadge: true,
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
          ? const EdgeInsets.symmetric(horizontal: 10)
          : EdgeInsets.zero,
      child: VideoFeed(
        height: 220,
        source: VideoFeedSource.playlist,
        channel: _channelId,
        playlist: _playlistId,
        mode: VideoFeedMode.row,
        enablePictureInPicture: _enablePip,
        videoFeedConfiguration: feedConfiguration,
        videoPlayerConfiguration: playerConfiguration,
        onVideoFeedCreated: _onVideoFeedCreated,
        onVideoFeedLoadFinished: _onVideoFeedLoadFinished,
      ),
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
    if (_feedError != error && mounted) {
      setState(() {
        _feedError = error;
      });
    }
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
