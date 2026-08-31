import 'package:flutter/material.dart';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';

import '../../widgets/fw_app_bar.dart';

/// Playground for the widget mute rules: card/fullscreen mute sync, the
/// first-display mute default, and the forced-mute + auto-restore arbitration
/// when another audible component appears.
///
/// Add any mix of Player Deck / Story Block / Video Feed widgets; each instance
/// gets its own source. Placeholders are plain spacers that push the next
/// component off screen, so viewport exit/re-entry (pause, newcomer-yields on
/// return, pending restore) can be exercised by scrolling.
///
/// Note: unlike the native SDKs, the Flutter SDK has no per-widget initial mute
/// option. The first-display mute state comes from the native SDK init
/// (`SDKInitOptions.videoLaunchBehavior` on iOS / `FWSDKInitOptionsModel` on
/// Android), which this example app sets to `muteOnFirstLaunch`.
class MuteLogicTestScreen extends StatefulWidget {
  const MuteLogicTestScreen({Key? key}) : super(key: key);

  @override
  State<MuteLogicTestScreen> createState() => _MuteLogicTestScreenState();
}

enum _ComponentType { playerDeck, storyBlock, videoFeed }

extension _ComponentTypeX on _ComponentType {
  String get title {
    switch (this) {
      case _ComponentType.playerDeck:
        return "Player Deck";
      case _ComponentType.storyBlock:
        return "Story Block";
      case _ComponentType.videoFeed:
        return "Video Feed";
    }
  }

  double get widgetHeight {
    switch (this) {
      case _ComponentType.playerDeck:
        return 400;
      case _ComponentType.storyBlock:
        return 360;
      case _ComponentType.videoFeed:
        return 260;
    }
  }
}

class _SourceOption {
  final String title;
  final String? channelId;
  final String? playlistId;
  final String? contentId;

  const _SourceOption.channelPlaylist({
    required this.title,
    required String this.channelId,
    required String this.playlistId,
  }) : contentId = null;

  const _SourceOption.singleContent({
    required this.title,
    required String this.contentId,
  })  : channelId = null,
        playlistId = null;

  bool get isSingleContent => contentId != null;

  VideoFeedSource get feedSource => isSingleContent
      ? VideoFeedSource.singleContent
      : VideoFeedSource.playlist;

  StoryBlockSource get storyBlockSource => isSingleContent
      ? StoryBlockSource.singleContent
      : StoryBlockSource.playlist;
}

/// One row in the content list: either a widget or a placeholder spacer.
class _CardEntry {
  final int id;
  final String title;
  final double height;
  final _ComponentType? type;
  final _SourceOption? source;

  const _CardEntry({
    required this.id,
    required this.title,
    required this.height,
    this.type,
    this.source,
  });

  bool get isPlaceholder => type == null;
}

class _MuteLogicTestScreenState extends State<MuteLogicTestScreen> {
  static const _sourceOptions = <_SourceOption>[
    _SourceOption.channelPlaylist(
      title: "Jayden (V3Wyyr4/oQzJbg)",
      channelId: "V3Wyyr4",
      playlistId: "oQzJbg",
    ),
    _SourceOption.channelPlaylist(
      title: "Home Shopping (7RXwK8k/gk1qx5)",
      channelId: "7RXwK8k",
      playlistId: "gk1qx5",
    ),
    _SourceOption.channelPlaylist(
      title: "Grace (V3GbMjA/5L1AXo)",
      channelId: "V3GbMjA",
      playlistId: "5L1AXo",
    ),
    _SourceOption.channelPlaylist(
      title: "PGA TOUR (A7qwdk/g4YN0v)",
      channelId: "A7qwdk",
      playlistId: "g4YN0v",
    ),
    _SourceOption.channelPlaylist(
      title: "Eggsy (m08mZk9/oPNeKr)",
      channelId: "m08mZk9",
      playlistId: "oPNeKr",
    ),
    _SourceOption.channelPlaylist(
      title: "Jiayao (OK1BXMy/5maAAm)",
      channelId: "OK1BXMy",
      playlistId: "5maAAm",
    ),
    _SourceOption.channelPlaylist(
      title: "Wayfair (xDzlrJJ/5R7pjZ)",
      channelId: "xDzlrJJ",
      playlistId: "5R7pjZ",
    ),
    _SourceOption.channelPlaylist(
      title: "Jayden SV Test (V3Wyyr4/o8Nayj)",
      channelId: "V3Wyyr4",
      playlistId: "o8Nayj",
    ),
  ];
  static const _placeholderHeights = <double>[400, 800, 1200];

  final List<_CardEntry> _entries = [];

  /// Rotates so consecutively added components default to different sources.
  int _nextSourceIndex = 0;
  int _nextEntryId = 0;
  bool _enablePip = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: fwAppBar(
        context: context,
        titleText: "Mute Logic Test",
        actions: [
          IconButton(
            tooltip: "Push secondary page",
            onPressed: _pushSecondaryPage,
            icon: const Icon(Icons.open_in_new),
          ),
          IconButton(
            tooltip: "Add component",
            onPressed: _showAddComponentSheet,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPipToggle(),
            const Divider(height: 1),
            Expanded(
              child: _entries.isEmpty ? _buildEmptyHint() : _buildList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPipToggle() {
    return SwitchListTile(
      dense: true,
      value: _enablePip,
      onChanged: (value) => setState(() => _enablePip = value),
      title: const Text("Enable Picture in Picture"),
      subtitle: const Text(
        "Initial mute state follows the native SDK init videoLaunchBehavior "
        "(muteOnFirstLaunch in this example app).",
        style: TextStyle(fontSize: 11),
      ),
    );
  }

  Widget _buildEmptyHint() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Text(
          "Tap + to add a Player Deck, Story Block or Video Feed.\n"
          "Combine several to test the mute arbitration rules.\n"
          "Add a Placeholder between components to scroll one off screen.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _entries.length,
      separatorBuilder: (_, __) => const SizedBox(height: 24),
      itemBuilder: (context, index) => _buildCard(_entries[index]),
    );
  }

  // MARK: - Card

  /// A removable row: a header with the title and a Remove button above the
  /// widget pinned to its height. Shared by the widgets and the placeholders.
  Widget _buildCard(_CardEntry entry) {
    return Column(
      key: ValueKey("card_${entry.id}"),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                entry.title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () => _removeEntry(entry),
              style: TextButton.styleFrom(
                visualDensity: VisualDensity.compact,
                foregroundColor: Colors.red,
              ),
              child: const Text(
                "Remove",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: entry.height,
          child: entry.isPlaceholder
              ? _buildPlaceholder(entry)
              : _buildComponent(entry),
        ),
      ],
    );
  }

  Widget _buildPlaceholder(_CardEntry entry) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      alignment: Alignment.center,
      child: Text(
        entry.title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  Widget _buildComponent(_CardEntry entry) {
    final source = entry.source!;
    final key = ValueKey("widget_${entry.id}");
    switch (entry.type!) {
      case _ComponentType.playerDeck:
        return PlayerDeck(
          key: key,
          height: entry.height,
          source: source.feedSource,
          channel: source.channelId,
          playlist: source.playlistId,
          contentId: source.contentId,
          enablePictureInPicture: _enablePip,
        );
      case _ComponentType.storyBlock:
        return StoryBlock(
          key: key,
          height: entry.height,
          source: source.storyBlockSource,
          channel: source.channelId,
          playlist: source.playlistId,
          contentId: source.contentId,
          enablePictureInPicture: _enablePip,
        );
      case _ComponentType.videoFeed:
        return VideoFeed(
          key: key,
          height: entry.height,
          source: source.feedSource,
          channel: source.channelId,
          playlist: source.playlistId,
          contentId: source.contentId,
          mode: VideoFeedMode.row,
          enablePictureInPicture: _enablePip,
          videoFeedConfiguration: VideoFeedConfiguration(
            enableAutoplay: true,
          ),
        );
    }
  }

  /// Covers the components under test so that mute/pause behavior on push and
  /// the restore behavior on pop can be checked.
  void _pushSecondaryPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const _MuteLogicSecondaryScreen(),
      ),
    );
  }

  // MARK: - Add / Remove

  void _addComponent(_ComponentType type, _SourceOption source) {
    setState(() {
      _nextSourceIndex += 1;
      _entries.add(
        _CardEntry(
          id: _nextEntryId++,
          title: "${type.title} · ${source.title}",
          height: type.widgetHeight,
          type: type,
          source: source,
        ),
      );
    });
  }

  void _addPlaceholder(double height) {
    setState(() {
      _entries.add(
        _CardEntry(
          id: _nextEntryId++,
          title: "Placeholder · ${height.toInt()} pt",
          height: height,
        ),
      );
    });
  }

  void _removeEntry(_CardEntry entry) {
    setState(() {
      _entries.removeWhere((e) => e.id == entry.id);
    });
  }

  // MARK: - Pickers

  Future<void> _showAddComponentSheet() async {
    final picked = await _showOptionSheet<Object>(
      title: "Add Component",
      options: [
        for (final t in _ComponentType.values) _SheetOption(t.title, t),
        const _SheetOption("Placeholder (spacer)", _CustomPick.placeholder),
      ],
    );
    if (!mounted) return;
    if (picked is _ComponentType) {
      await _pickSource(picked);
    } else if (picked == _CustomPick.placeholder) {
      await _pickPlaceholderHeight();
    }
  }

  Future<void> _pickPlaceholderHeight() async {
    final height = await _showOptionSheet<double>(
      title: "Placeholder Height",
      message: "Tall enough to push the next component out of the viewport",
      options: [
        for (final h in _placeholderHeights) _SheetOption("${h.toInt()} pt", h),
      ],
    );
    if (height != null) {
      _addPlaceholder(height);
    }
  }

  Future<void> _pickSource(_ComponentType type) async {
    final defaultIndex = _nextSourceIndex % _sourceOptions.length;
    final picked = await _showOptionSheet<Object>(
      title: "Source for ${type.title}",
      message: "Use a different source per component",
      options: [
        for (var i = 0; i < _sourceOptions.length; i++)
          _SheetOption(
            i == defaultIndex
                ? "${_sourceOptions[i].title} — next"
                : _sourceOptions[i].title,
            _sourceOptions[i],
          ),
        const _SheetOption("Custom Channel/Playlist…", _CustomPick.playlist),
        const _SheetOption("Custom Single Content…", _CustomPick.single),
      ],
    );
    if (!mounted || picked == null) return;

    _SourceOption? source;
    if (picked is _SourceOption) {
      source = picked;
    } else if (picked == _CustomPick.playlist) {
      source = await _promptCustomChannelPlaylist();
    } else if (picked == _CustomPick.single) {
      source = await _promptCustomSingleContent();
    }
    if (source != null) {
      _addComponent(type, source);
    }
  }

  Future<_SourceOption?> _promptCustomChannelPlaylist() async {
    final values = await _showTextPrompt(
      title: "Custom Channel/Playlist",
      message: "Enter the encoded channel ID and playlist ID",
      fields: const ["Channel ID", "Playlist ID"],
    );
    if (values == null) return null;
    final channelId = values[0];
    final playlistId = values[1];
    if (channelId.isEmpty || playlistId.isEmpty) return null;
    return _SourceOption.channelPlaylist(
      title: "Custom ($channelId/$playlistId)",
      channelId: channelId,
      playlistId: playlistId,
    );
  }

  Future<_SourceOption?> _promptCustomSingleContent() async {
    final values = await _showTextPrompt(
      title: "Custom Single Content",
      message: "Enter the video or live stream content ID",
      fields: const ["Content ID"],
    );
    if (values == null) return null;
    final contentId = values[0];
    if (contentId.isEmpty) return null;
    return _SourceOption.singleContent(
      title: "Single ($contentId)",
      contentId: contentId,
    );
  }

  Future<T?> _showOptionSheet<T>({
    required String title,
    String? message,
    required List<_SheetOption<T>> options,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (message != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const Divider(height: 1),
                for (final option in options)
                  ListTile(
                    dense: true,
                    title: Text(option.title, textAlign: TextAlign.center),
                    onTap: () => Navigator.of(sheetContext).pop(option.value),
                  ),
                const Divider(height: 1),
                ListTile(
                  dense: true,
                  title: const Text(
                    "Cancel",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  onTap: () => Navigator.of(sheetContext).pop(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Shows an alert with one text field per entry in [fields]. Resolves to the
  /// trimmed values on "Add", or null on cancel.
  Future<List<String>?> _showTextPrompt({
    required String title,
    required String message,
    required List<String> fields,
  }) {
    return showDialog<List<String>>(
      context: context,
      builder: (_) => _TextPromptDialog(
        title: title,
        message: message,
        fields: fields,
      ),
    );
  }
}

/// Owns its text controllers so they outlive the dialog's exit transition;
/// disposing them right after `showDialog` resolves would tear them down while
/// the text fields are still mounted.
class _TextPromptDialog extends StatefulWidget {
  final String title;
  final String message;
  final List<String> fields;

  const _TextPromptDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.fields,
  }) : super(key: key);

  @override
  State<_TextPromptDialog> createState() => _TextPromptDialogState();
}

class _TextPromptDialogState extends State<_TextPromptDialog> {
  late final List<TextEditingController> _controllers = [
    for (final _ in widget.fields) TextEditingController(),
  ];

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.message, style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 8),
          for (var i = 0; i < widget.fields.length; i++)
            TextField(
              controller: _controllers[i],
              autocorrect: false,
              enableSuggestions: false,
              textCapitalization: TextCapitalization.none,
              decoration: InputDecoration(hintText: widget.fields[i]),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(
            [for (final c in _controllers) c.text.trim()],
          ),
          child: const Text("Add"),
        ),
      ],
    );
  }
}

enum _CustomPick { playlist, single, placeholder }

/// A placeholder page pushed on top of the mute logic test screen.
///
/// Its only purpose is to cover the components under test so that you can
/// check whether playback stops when this page is pushed and whether the
/// mute state is restored correctly after popping back.
class _MuteLogicSecondaryScreen extends StatelessWidget {
  const _MuteLogicSecondaryScreen({Key? key}) : super(key: key);

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
                "This page covers the components under test.\n\n"
                "Playback should stop while this page is on top, and the "
                "mute state should be restored after going back.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text("Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SheetOption<T> {
  final String title;
  final T value;
  const _SheetOption(this.title, this.value);
}
