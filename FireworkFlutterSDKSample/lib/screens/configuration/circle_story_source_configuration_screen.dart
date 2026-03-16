import 'package:flutter/material.dart';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:provider/provider.dart';
import '../../states/circle_story_source_state.dart';
import '../../widgets/fw_app_bar.dart';
import '../../widgets/fw_text_form_field.dart';

class CircleStorySourceConfigurationScreen extends StatefulWidget {
  const CircleStorySourceConfigurationScreen({Key? key}) : super(key: key);

  @override
  State<CircleStorySourceConfigurationScreen> createState() =>
      _CircleStorySourceConfigurationScreenState();
}

/// Feed.json demo defaults (aligned with Feed Layouts tab).
class _CircleStorySourceConfigurationScreenState
    extends State<CircleStorySourceConfigurationScreen> {
  static const String _feedDefaultChannel = "bJDywZ";
  static const String _feedDefaultPlaylistId = "g206q5";
  static const String _feedDefaultPlaylistGroupId = "9glb5G";
  static const String _feedDefaultDynamicChannelId = "23LBMWN";
  static const String _feedDefaultDynamicKey = "category";
  static const String _feedDefaultDynamicValues = "dessert";
  static const String _feedDefaultHashtagChannelId = "BKQlqD";
  static const String _feedDefaultHashtagExpression = "powder";

  final _formKey = GlobalKey<FormState>();
  VideoFeedSource _selectedSource = VideoFeedSource.playlist;

  String _channelId = _feedDefaultChannel;
  String _playlistId = _feedDefaultPlaylistId;
  String _playlistGroupId = _feedDefaultPlaylistGroupId;
  String _hashtagFilterExpression = _feedDefaultHashtagExpression;
  String _productIds = "";
  String _contentId = "";
  String _dynamicContentKey = _feedDefaultDynamicKey;
  String _dynamicContentValues = _feedDefaultDynamicValues;

  bool _initializedFromState = false;

  void _applyFeedDefaultsForSource(VideoFeedSource source) {
    setState(() {
      _selectedSource = source;
      switch (source) {
        case VideoFeedSource.discover:
          break;
        case VideoFeedSource.channel:
          _channelId = _feedDefaultChannel;
          break;
        case VideoFeedSource.playlist:
          _channelId = _feedDefaultChannel;
          _playlistId = _feedDefaultPlaylistId;
          break;
        case VideoFeedSource.playlistGroup:
          _playlistGroupId = _feedDefaultPlaylistGroupId;
          break;
        case VideoFeedSource.dynamicContent:
          _channelId = _feedDefaultDynamicChannelId;
          _dynamicContentKey = _feedDefaultDynamicKey;
          _dynamicContentValues = _feedDefaultDynamicValues;
          break;
        case VideoFeedSource.hashtagPlaylist:
          _channelId = _feedDefaultHashtagChannelId;
          _hashtagFilterExpression = _feedDefaultHashtagExpression;
          break;
        case VideoFeedSource.sku:
        case VideoFeedSource.singleContent:
          break;
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initializedFromState) return;
    _initializedFromState = true;
    final state = context.read<CircleStorySourceState>();
    setState(() {
      _selectedSource = state.source;
      switch (state.source) {
        case VideoFeedSource.discover:
          break;
        case VideoFeedSource.channel:
          _channelId = state.channel?.isNotEmpty == true
              ? state.channel!
              : _feedDefaultChannel;
          break;
        case VideoFeedSource.playlist:
          _channelId = state.channel?.isNotEmpty == true
              ? state.channel!
              : _feedDefaultChannel;
          _playlistId = state.playlist?.isNotEmpty == true
              ? state.playlist!
              : _feedDefaultPlaylistId;
          break;
        case VideoFeedSource.playlistGroup:
          _playlistGroupId = state.playlistGroup?.isNotEmpty == true
              ? state.playlistGroup!
              : _feedDefaultPlaylistGroupId;
          break;
        case VideoFeedSource.dynamicContent:
          if (state.dynamicContentParameters != null &&
              state.dynamicContentParameters!.isNotEmpty) {
            final entry = state.dynamicContentParameters!.entries.first;
            _channelId = state.channel ?? _feedDefaultDynamicChannelId;
            _dynamicContentKey = entry.key;
            _dynamicContentValues = entry.value.join(", ");
          } else {
            _channelId = _feedDefaultDynamicChannelId;
            _dynamicContentKey = _feedDefaultDynamicKey;
            _dynamicContentValues = _feedDefaultDynamicValues;
          }
          break;
        case VideoFeedSource.hashtagPlaylist:
          _channelId = state.channel?.isNotEmpty == true
              ? state.channel!
              : _feedDefaultHashtagChannelId;
          _hashtagFilterExpression =
              state.hashtagFilterExpression?.isNotEmpty == true
                  ? state.hashtagFilterExpression!
                  : _feedDefaultHashtagExpression;
          break;
        case VideoFeedSource.sku:
          _channelId = state.channel ?? "";
          _productIds = state.productIds?.join(", ") ?? "";
          break;
        case VideoFeedSource.singleContent:
          _contentId = state.contentId ?? "";
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fwAppBar(
        context: context,
        titleText: 'Circle Story Source',
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Configure Circle Story Source',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Select a source type and fill in the required parameters.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            _buildSourceDropdown(),
            const SizedBox(height: 20),
            ..._buildFieldsForSource(),
            const SizedBox(height: 30),
            _buildButtonList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Source Type',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<VideoFeedSource>(
          value: _selectedSource,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: VideoFeedSource.values.map((source) {
            return DropdownMenuItem(
              value: source,
              child: Text(source.name),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              _applyFeedDefaultsForSource(value);
            }
          },
        ),
      ],
    );
  }

  List<Widget> _buildFieldsForSource() {
    switch (_selectedSource) {
      case VideoFeedSource.discover:
        return [];

      case VideoFeedSource.channel:
        return [
          _buildTextField(
            label: 'Channel ID',
            hint: 'Enter channel ID',
            initialValue: _channelId,
            onSaved: (v) => _channelId = v ?? "",
            required: true,
          ),
        ];

      case VideoFeedSource.playlist:
        return [
          _buildTextField(
            label: 'Channel ID',
            hint: 'Enter channel ID',
            initialValue: _channelId,
            onSaved: (v) => _channelId = v ?? "",
            required: true,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            label: 'Playlist ID',
            hint: 'Enter playlist ID',
            initialValue: _playlistId,
            onSaved: (v) => _playlistId = v ?? "",
            required: true,
          ),
        ];

      case VideoFeedSource.playlistGroup:
        return [
          _buildTextField(
            label: 'Playlist Group ID',
            hint: 'Enter playlist group ID',
            initialValue: _playlistGroupId,
            onSaved: (v) => _playlistGroupId = v ?? "",
            required: true,
          ),
        ];

      case VideoFeedSource.dynamicContent:
        return [
          _buildTextField(
            label: 'Channel ID',
            hint: 'Enter channel ID',
            initialValue: _channelId,
            onSaved: (v) => _channelId = v ?? "",
            required: true,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            label: 'Parameter Key',
            hint: 'e.g. category',
            initialValue: _dynamicContentKey,
            onSaved: (v) => _dynamicContentKey = v ?? "",
            required: true,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            label: 'Parameter Values (comma separated)',
            hint: 'e.g. sports,news',
            initialValue: _dynamicContentValues,
            onSaved: (v) => _dynamicContentValues = v ?? "",
            required: true,
          ),
        ];

      case VideoFeedSource.hashtagPlaylist:
        return [
          _buildTextField(
            label: 'Channel ID',
            hint: 'Enter channel ID',
            initialValue: _channelId,
            onSaved: (v) => _channelId = v ?? "",
            required: true,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            label: 'Hashtag Filter Expression',
            hint: 'e.g. (and sport food)',
            initialValue: _hashtagFilterExpression,
            onSaved: (v) => _hashtagFilterExpression = v ?? "",
            required: true,
          ),
        ];

      case VideoFeedSource.sku:
        return [
          _buildTextField(
            label: 'Channel ID',
            hint: 'Enter channel ID',
            initialValue: _channelId,
            onSaved: (v) => _channelId = v ?? "",
            required: true,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            label: 'Product IDs (comma separated)',
            hint: 'e.g. sku1,sku2,sku3',
            initialValue: _productIds,
            onSaved: (v) => _productIds = v ?? "",
            required: true,
          ),
        ];

      case VideoFeedSource.singleContent:
        return [
          _buildTextField(
            label: 'Content ID',
            hint: 'Enter video or livestream content ID',
            initialValue: _contentId,
            onSaved: (v) => _contentId = v ?? "",
            required: true,
          ),
        ];
    }
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    String initialValue = "",
    required FormFieldSetter<String> onSaved,
    bool required = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        FWTextFormField(
          initialValue: initialValue,
          text: initialValue,
          hintText: hint,
          validator: required
              ? (text) {
                  if (text == null || text.trim().isEmpty) {
                    return '$label is required';
                  }
                  return null;
                }
              : null,
          onSaved: onSaved,
        ),
      ],
    );
  }

  Widget _buildButtonList(BuildContext context) {
    return Row(children: [
      Expanded(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ),
      const SizedBox(width: 20),
      Expanded(
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState != null &&
                _formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              Navigator.of(context).pop(_buildResult());
            }
          },
          child: const Text('Use'),
        ),
      ),
    ]);
  }

  Map<String, dynamic> _buildResult() {
    final result = <String, dynamic>{
      "source": _selectedSource.name,
    };

    switch (_selectedSource) {
      case VideoFeedSource.discover:
        break;

      case VideoFeedSource.channel:
        result["channelId"] = _channelId;
        break;

      case VideoFeedSource.playlist:
        result["channelId"] = _channelId;
        result["playlistId"] = _playlistId;
        break;

      case VideoFeedSource.playlistGroup:
        result["playlistGroupId"] = _playlistGroupId;
        break;

      case VideoFeedSource.dynamicContent:
        result["channelId"] = _channelId;
        result["dynamicContentParameters"] = <String, List<String>>{
          _dynamicContentKey: _dynamicContentValues
              .split(',')
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList(),
        };
        break;

      case VideoFeedSource.hashtagPlaylist:
        result["channelId"] = _channelId;
        result["hashtagFilterExpression"] = _hashtagFilterExpression;
        break;

      case VideoFeedSource.sku:
        result["channelId"] = _channelId;
        result["productIds"] = _productIds
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();
        break;

      case VideoFeedSource.singleContent:
        result["contentId"] = _contentId;
        break;
    }

    return result;
  }
}
