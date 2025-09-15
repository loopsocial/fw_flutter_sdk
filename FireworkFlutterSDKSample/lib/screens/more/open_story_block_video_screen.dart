import 'package:flutter/material.dart';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/states/story_block_configuration_state.dart';
import 'package:fw_flutter_sdk_example/utils/fw_example_logger_util.dart';
import 'package:provider/provider.dart';
import '../../generated/l10n.dart';
import '../../extensions/fw_error_extension.dart';
import '../../widgets/fw_app_bar.dart';

class OpenStoryBlockVideoScreen extends StatefulWidget {
  final RouteSettings settings;

  const OpenStoryBlockVideoScreen({
    Key? key,
    required this.settings,
  }) : super(key: key);

  @override
  State<OpenStoryBlockVideoScreen> createState() =>
      _OpenStoryBlockVideoScreenState();
}

class _OpenStoryBlockVideoScreenState extends State<OpenStoryBlockVideoScreen> {
  FWError? _storyBlockError;
  String? _videoId;

  @override
  void initState() {
    super.initState();
    if (widget.settings.arguments is Map<dynamic, dynamic>) {
      final arg = widget.settings.arguments as Map<dynamic, dynamic>;
      if (arg["videoId"] is String) {
        _videoId = arg["videoId"] as String;
      }
    }

    // Add debug logging
    FWExampleLoggerUtil.log(
        "OpenStoryBlockVideoScreen initState - videoId: $_videoId");

    // Check if videoId is valid
    if (_videoId == null || _videoId!.isEmpty) {
      FWExampleLoggerUtil.log("WARNING: videoId is null or empty!");
    } else {
      FWExampleLoggerUtil.log("Using videoId: $_videoId");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fwAppBar(
        context: context,
        titleText:
            '${S.of(context).videoId}: ${_videoId ?? S.of(context).unknown}',
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_videoId == null) {
      return Center(
        child: Text(
          S.of(context).noVideoIdProvided,
          style: const TextStyle(fontSize: 16),
        ),
      );
    }

    if (_storyBlockError != null) {
      return _buildErrorWidget(context);
    }

    final storyBlockConfiguration =
        context.watch<StoryBlockConfigurationState>().storyBlockConfiguration;

    // Create custom configuration to ensure video plays properly
    final customStoryBlockConfiguration = storyBlockConfiguration.deepCopy()
      ..enableAutoplay = true
      ..enableAutopause = false
      ..enableFullScreen = true
      ..showPlaybackButton = true
      ..showMuteButton = true
      ..showShareButton = true;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Page header introduction text
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🎥 ${S.of(context).videoPlayerDemo}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${S.of(context).videoId}: $_videoId',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  S.of(context).storyBlockVideoDescription,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // StoryBlock component
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Center(
              child: Container(
                width: 360,
                height: 640,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: StoryBlock(
                    source: StoryBlockSource.singleContent,
                    contentId: _videoId,
                    width: 360,
                    height: 640,
                    wantKeepAlive: true,
                    adConfiguration: AdConfiguration(requiresAds: false),
                    storyBlockConfiguration: customStoryBlockConfiguration,
                    enablePictureInPicture: true,
                    onStoryBlockLoadFinished: _onStoryBlockLoadFinished,
                    onStoryBlockEmpty: _onStoryBlockEmpty,
                    onStoryBlockCreated: _onStoryBlockCreated,
                    onStoryBlockDidStartPictureInPicture:
                        _onStoryBlockDidStartPictureInPicture,
                    onStoryBlockDidStopPictureInPicture:
                        _onStoryBlockDidStopPictureInPicture,
                    onStoryBlockGetFeedId: _onStoryBlockGetFeedId,
                  ),
                ),
              ),
            ),
          ),

          // Video information card
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.purple.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).videoInformation,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                    S.of(context).videoId, _videoId ?? S.of(context).unknown),
                _buildInfoRow(
                    S.of(context).status,
                    _storyBlockError == null
                        ? S.of(context).loaded
                        : S.of(context).error),
                _buildInfoRow(S.of(context).autoplay, S.of(context).enabled),
                _buildInfoRow(
                    S.of(context).pictureInPicture, S.of(context).supported),
                _buildInfoRow(
                    S.of(context).fullScreen, S.of(context).supported),
              ],
            ),
          ),

          // Features list
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).features,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(height: 12),
                _buildFeatureItem(S.of(context).interactiveControls,
                    S.of(context).playPauseMuteShare),
                _buildFeatureItem(S.of(context).pictureInPicture,
                    S.of(context).continueWatchingOtherApps),
                _buildFeatureItem(S.of(context).fullScreenMode,
                    S.of(context).immersiveViewing),
                _buildFeatureItem(S.of(context).audioControls,
                    S.of(context).muteUnmuteFunction),
                _buildFeatureItem(S.of(context).shareOptions,
                    S.of(context).shareVideoContent),
              ],
            ),
          ),

          // Bottom description text
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).tips,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  S.of(context).videoTips,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
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
                setState(() {
                  _storyBlockError = null;
                });
              },
              child: Text(
                S.of(context).refresh,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              _storyBlockError?.reason ?? S.of(context).failedToLoadVideo,
            ),
          ],
        ),
      ),
    );
  }

  void _onStoryBlockLoadFinished(FWError? error) {
    FWExampleLoggerUtil.log(
        "_onStoryBlockLoadFinished error ${error?.displayString()}");
    FWExampleLoggerUtil.log("_onStoryBlockLoadFinished videoId: $_videoId");

    // Add detailed error logging
    if (error != null) {
      FWExampleLoggerUtil.log("Error reason: ${error.reason}");
      FWExampleLoggerUtil.log("Error display: ${error.displayString()}");
    } else {
      FWExampleLoggerUtil.log(
          "StoryBlock loaded successfully for videoId: $_videoId");
    }

    if (_storyBlockError != error && mounted) {
      setState(() {
        _storyBlockError = error;
      });
    }
  }

  void _onStoryBlockEmpty(FWError? error) {
    FWExampleLoggerUtil.log(
        "_onStoryBlockEmpty error ${error?.displayString()}");
    FWExampleLoggerUtil.log("_onStoryBlockEmpty videoId: $_videoId");

    // Add detailed empty state logging
    if (error != null) {
      FWExampleLoggerUtil.log("Empty state - Error reason: ${error.reason}");
      FWExampleLoggerUtil.log(
          "Empty state - Error display: ${error.displayString()}");
    } else {
      FWExampleLoggerUtil.log(
          "StoryBlock is empty - no content found for videoId: $_videoId");
    }
  }

  void _onStoryBlockCreated(StoryBlockController controller) {
    FWExampleLoggerUtil.log("_onStoryBlockCreated");
    FWExampleLoggerUtil.log("_onStoryBlockCreated videoId: $_videoId");
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
    FWExampleLoggerUtil.log("_onStoryBlockGetFeedId videoId: $_videoId");
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
