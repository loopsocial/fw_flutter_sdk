import 'package:flutter/material.dart';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:provider/provider.dart';
import '../../generated/l10n.dart';
import '../../widgets/fw_app_bar.dart';
import '../../utils/fw_example_logger_util.dart';
import '../../states/player_configuration_state.dart';
import '../../states/circle_story_configuration_state.dart';
import '../../states/circle_story_source_state.dart';

class CircleStoryScreen extends StatefulWidget {
  const CircleStoryScreen({Key? key}) : super(key: key);

  @override
  State<CircleStoryScreen> createState() => _CircleStoryScreenState();
}

class _CircleStoryScreenState extends State<CircleStoryScreen> {
  FWError? _loadError;
  double _height = 120.0;
  bool _enablePictureInPicture = true;

  @override
  Widget build(BuildContext context) {
    final playerConfiguration =
        context.watch<PlayerConfigurationState>().playerConfiguration;
    final circleStoryConfiguration = context
        .watch<CircleStoryConfigurationState>()
        .circleStoryConfiguration;
    final circleStorySource = context.watch<CircleStorySourceState>();

    return Scaffold(
      appBar: fwAppBar(
        context: context,
        titleText: S.of(context).circleStoryView,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/player_configuration');
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Configuration controls
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Height slider
                    Text(
                      'Height: ${_height.toInt()}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Slider(
                      value: _height,
                      min: 80,
                      max: 200,
                      divisions: 24,
                      label: _height.toInt().toString(),
                      onChanged: (value) {
                        setState(() {
                          _height = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),

                    // Source configuration
                    const Text(
                      '📡 Source Configuration',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Source:',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                circleStorySource.source.name,
                                style: TextStyle(color: Colors.blue[700]),
                              ),
                            ],
                          ),
                          if (circleStorySource.channel != null) ...[
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Channel:',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Flexible(
                                  child: Text(
                                    circleStorySource.channel!,
                                    style:
                                        const TextStyle(color: Colors.black87),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          if (circleStorySource.playlist != null) ...[
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Playlist:',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Flexible(
                                  child: Text(
                                    circleStorySource.playlist!,
                                    style:
                                        const TextStyle(color: Colors.black87),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          '/circle_story_source_configuration',
                        );
                        if (result is Map<String, String>) {
                          final channel = result["channelId"] ?? "";
                          final playlist = result["playlistId"] ?? "";
                          if (channel.isNotEmpty && playlist.isNotEmpty) {
                            // ignore: use_build_context_synchronously
                            context
                                .read<CircleStorySourceState>()
                                .updateSource(
                                  source: VideoFeedSource.playlist,
                                  channel: channel,
                                  playlist: playlist,
                                );
                          }
                        }
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit Source'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 44),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Picture in Picture toggle
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      value: _enablePictureInPicture,
                      onChanged: (value) {
                        setState(() {
                          _enablePictureInPicture = value ?? true;
                        });
                      },
                      title: Text(S.of(context).enablePictureInPicture),
                    ),

                    const Divider(),
                    const SizedBox(height: 10),

                    // Circle Story Configuration info
                    const Text(
                      '🎨 Circle Story Configuration',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, '/circle_story_configuration');
                      },
                      icon: const Icon(Icons.palette),
                      label: const Text('Configure Circle Story'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                      ),
                    ),

                    const SizedBox(height: 15),
                    const Divider(),
                    const SizedBox(height: 10),

                    // Video Player Configuration info
                    const Text(
                      '🎬 Video Player Configuration',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/player_configuration');
                      },
                      icon: const Icon(Icons.settings),
                      label: const Text('Configure Video Player'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                  ],
                ),
              ),
            ),

            const Divider(height: 1, thickness: 2),

            // Error message
            if (_loadError != null)
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Error: ${_loadError?.reason ?? "Unknown error"}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),

            // CircleStory widget
            Container(
              color: Colors.grey[200],
              child: SizedBox(
                height: _height,
                child: CircleStory(
                  height: _height,
                  width: double.infinity,
                  source: circleStorySource.source,
                  channel: circleStorySource.channel,
                  playlist: circleStorySource.playlist,
                  enablePictureInPicture: _enablePictureInPicture,
                  circleStoryConfiguration:
                      circleStoryConfiguration.deepCopy(),
                  videoPlayerConfiguration: playerConfiguration.deepCopy(),
                  onCircleStoryCreated: _onCircleStoryCreated,
                  onCircleStoryLoadFinished: _onCircleStoryLoadFinished,
                  onCircleStoryEmpty: _onCircleStoryEmpty,
                  onCircleStoryDidStartPictureInPicture:
                      _onCircleStoryDidStartPictureInPicture,
                  onCircleStoryDidStopPictureInPicture:
                      _onCircleStoryDidStopPictureInPicture,
                  onCircleStoryGetFeedId: _onCircleStoryGetFeedId,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onCircleStoryCreated(CircleStoryController controller) {
    FWExampleLoggerUtil.log("_onCircleStoryCreated");
  }

  void _onCircleStoryLoadFinished(FWError? error) {
    FWExampleLoggerUtil.log(
        "_onCircleStoryLoadFinished error: ${error?.reason}");
    if (mounted) {
      setState(() {
        _loadError = error;
      });
    }
  }

  void _onCircleStoryEmpty(FWError? error) {
    FWExampleLoggerUtil.log("_onCircleStoryEmpty error: ${error?.reason}");
  }

  void _onCircleStoryDidStartPictureInPicture(FWError? error) {
    FWExampleLoggerUtil.log(
        "_onCircleStoryDidStartPictureInPicture error: ${error?.reason}");
  }

  void _onCircleStoryDidStopPictureInPicture(FWError? error) {
    FWExampleLoggerUtil.log(
        "_onCircleStoryDidStopPictureInPicture error: ${error?.reason}");
  }

  void _onCircleStoryGetFeedId(String feedId) {
    FWExampleLoggerUtil.log("_onCircleStoryGetFeedId feedId: $feedId");
  }
}
