import 'package:flutter/material.dart';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';

import '../../widgets/fw_app_bar.dart';

/// A test screen for widget autoplay behavior.
///
/// Lets the tester switch between component types (VideoFeed / PlayerDeck /
/// StoryBlock), content sources (playlist / singleContent), and host
/// scroll containers (none / ListView / SingleChildScrollView /
/// CustomScrollView) to verify that autoplay starts and stops correctly as
/// the widget scrolls in and out of the viewport.
class AutoplayTestScreen extends StatefulWidget {
  const AutoplayTestScreen({Key? key}) : super(key: key);

  @override
  State<AutoplayTestScreen> createState() => _AutoplayTestScreenState();
}

enum _ComponentType { videoFeed, playerDeck, storyBlock }

enum _SourceType { playlist, singleContent }

enum _ContainerType { none, listView, singleChildScrollView, customScrollView }

class _AutoplayTestScreenState extends State<AutoplayTestScreen> {
  _ComponentType _componentType = _ComponentType.videoFeed;
  _SourceType _sourceType = _SourceType.playlist;
  _ContainerType _containerType = _ContainerType.listView;

  final _playlistChannelController = TextEditingController(text: "V3Wyyr4");
  final _playlistController = TextEditingController(text: "o8Nayj");
  final _contentController = TextEditingController();

  // Ids currently applied to the component. The text fields only take effect
  // after tapping "Apply", so a half-typed id never recreates the widget.
  String _appliedPlaylistChannel = "V3Wyyr4";
  String _appliedPlaylist = "o8Nayj";
  String _appliedContentId = "";

  @override
  void dispose() {
    _playlistChannelController.dispose();
    _playlistController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: fwAppBar(
        context: context,
        titleText: "Autoplay Test",
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildControls(),
            const Divider(height: 1),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildChoiceRow<_ComponentType>(
            label: "Component",
            values: _ComponentType.values,
            selected: _componentType,
            nameOf: (v) {
              switch (v) {
                case _ComponentType.videoFeed:
                  return "VideoFeed";
                case _ComponentType.playerDeck:
                  return "PlayerDeck";
                case _ComponentType.storyBlock:
                  return "StoryBlock";
              }
            },
            onSelected: (v) => setState(() => _componentType = v),
          ),
          _buildChoiceRow<_SourceType>(
            label: "Source",
            values: _SourceType.values,
            selected: _sourceType,
            nameOf: (v) => v.name,
            onSelected: (v) => setState(() => _sourceType = v),
          ),
          _buildChoiceRow<_ContainerType>(
            label: "Container",
            values: _ContainerType.values,
            selected: _containerType,
            nameOf: (v) {
              switch (v) {
                case _ContainerType.none:
                  return "None";
                case _ContainerType.listView:
                  return "ListView";
                case _ContainerType.singleChildScrollView:
                  return "SingleChildScrollView";
                case _ContainerType.customScrollView:
                  return "CustomScrollView";
              }
            },
            onSelected: (v) => setState(() => _containerType = v),
          ),
          _buildSourceInputs(),
          _buildSecondaryPageEntry(),
        ],
      ),
    );
  }

  Widget _buildSecondaryPageEntry() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: OutlinedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const _AutoplaySecondaryScreen(),
              ),
            );
          },
          style: OutlinedButton.styleFrom(
            visualDensity: VisualDensity.compact,
          ),
          child: const Text(
            "Push secondary page",
            style: TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildChoiceRow<T>({
    required String label,
    required List<T> values,
    required T selected,
    required String Function(T) nameOf,
    required ValueChanged<T> onSelected,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: values
                  .map(
                    (v) => Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: ChoiceChip(
                        label: Text(
                          nameOf(v),
                          style: const TextStyle(fontSize: 12),
                        ),
                        selected: v == selected,
                        onSelected: (_) => onSelected(v),
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSourceInputs() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ..._buildIdFields(),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: _applyIds,
          style: ElevatedButton.styleFrom(
            visualDensity: VisualDensity.compact,
          ),
          child: const Text("Apply", style: TextStyle(fontSize: 12)),
        ),
      ],
    );
  }

  List<Widget> _buildIdFields() {
    switch (_sourceType) {
      case _SourceType.playlist:
        return [
          Expanded(
            child: _buildIdField("Channel", _playlistChannelController),
          ),
          const SizedBox(width: 8),
          Expanded(child: _buildIdField("Playlist", _playlistController)),
        ];
      case _SourceType.singleContent:
        return [
          Expanded(child: _buildIdField("Content", _contentController)),
        ];
    }
  }

  Widget _buildIdField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        isDense: true,
      ),
      style: const TextStyle(fontSize: 13),
      onSubmitted: (_) => _applyIds(),
    );
  }

  // Commit the text fields to the applied ids, recreating the component.
  void _applyIds() {
    FocusScope.of(context).unfocus();
    setState(() {
      _appliedPlaylistChannel = _playlistChannelController.text.trim();
      _appliedPlaylist = _playlistController.text.trim();
      _appliedContentId = _contentController.text.trim();
    });
  }

  Widget _buildBody() {
    switch (_containerType) {
      case _ContainerType.none:
        return Column(
          children: [
            _fillerBlock(0),
            _buildComponent(),
            Expanded(child: _fillerBlock(1)),
          ],
        );
      case _ContainerType.listView:
        return ListView(
          children: _scrollChildren(),
        );
      case _ContainerType.singleChildScrollView:
        return SingleChildScrollView(
          child: Column(children: _scrollChildren()),
        );
      case _ContainerType.customScrollView:
        return CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(_scrollChildren()),
            ),
          ],
        );
    }
  }

  List<Widget> _scrollChildren() {
    return [
      _fillerBlock(0),
      _fillerBlock(1),
      _fillerBlock(2),
      _buildComponent(),
      _fillerBlock(3),
      _fillerBlock(4),
      _fillerBlock(5),
    ];
  }

  Widget _fillerBlock(int index) {
    final colors = [
      Colors.blueGrey.shade100,
      Colors.orange.shade100,
      Colors.green.shade100,
      Colors.purple.shade100,
      Colors.teal.shade100,
    ];
    return Container(
      height: 260,
      color: colors[index % colors.length],
      alignment: Alignment.center,
      child: Text(
        "Filler block ${index + 1}",
        style: const TextStyle(fontSize: 16, color: Colors.black54),
      ),
    );
  }

  // Recreate the platform view whenever any selection changes so the new
  // source/config takes effect from a clean state.
  Key get _componentKey => ValueKey(
        "${_componentType.name}_${_sourceType.name}_${_containerType.name}"
        "_${_appliedPlaylistChannel}_$_appliedPlaylist"
        "_$_appliedContentId",
      );

  Widget _buildComponent() {
    switch (_componentType) {
      case _ComponentType.videoFeed:
        return VideoFeed(
          key: _componentKey,
          height: 220,
          source: _videoFeedSource,
          channel: _channelValue,
          playlist: _playlistValue,
          contentId: _contentIdValue,
          mode: VideoFeedMode.row,
          videoFeedConfiguration: VideoFeedConfiguration(
            enableAutoplay: true,
          ),
        );
      case _ComponentType.playerDeck:
        return PlayerDeck(
          key: _componentKey,
          height: 420,
          source: _videoFeedSource,
          channel: _channelValue,
          playlist: _playlistValue,
          contentId: _contentIdValue,
        );
      case _ComponentType.storyBlock:
        return SizedBox(
          height: 420,
          child: StoryBlock(
            key: _componentKey,
            source: _storyBlockSource,
            channel: _channelValue,
            playlist: _playlistValue,
            contentId: _contentIdValue,
          ),
        );
    }
  }

  VideoFeedSource get _videoFeedSource {
    switch (_sourceType) {
      case _SourceType.playlist:
        return VideoFeedSource.playlist;
      case _SourceType.singleContent:
        return VideoFeedSource.singleContent;
    }
  }

  StoryBlockSource get _storyBlockSource {
    switch (_sourceType) {
      case _SourceType.playlist:
        return StoryBlockSource.playlist;
      case _SourceType.singleContent:
        return StoryBlockSource.singleContent;
    }
  }

  String? get _channelValue {
    switch (_sourceType) {
      case _SourceType.playlist:
        return _appliedPlaylistChannel;
      case _SourceType.singleContent:
        return null;
    }
  }

  String? get _playlistValue {
    switch (_sourceType) {
      case _SourceType.playlist:
        return _appliedPlaylist;
      case _SourceType.singleContent:
        return null;
    }
  }

  String? get _contentIdValue {
    switch (_sourceType) {
      case _SourceType.playlist:
        return null;
      case _SourceType.singleContent:
        return _appliedContentId;
    }
  }
}

/// A placeholder page pushed on top of the autoplay test screen.
///
/// Its only purpose is to cover the component under test so that you can check
/// whether autoplay stops when this page is pushed and resumes after popping
/// back.
class _AutoplaySecondaryScreen extends StatelessWidget {
  const _AutoplaySecondaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: fwAppBar(
        context: context,
        titleText: "Secondary Page",
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "This page covers the component under test.\n\n"
                "Autoplay should stop while this page is on top, and resume "
                "after going back.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).maybePop();
                },
                child: const Text("Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
