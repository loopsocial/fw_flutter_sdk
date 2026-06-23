import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/states/player_configuration_state.dart';
import 'package:fw_flutter_sdk_example/widgets/fw_app_bar.dart';
import 'package:fw_flutter_sdk_example/widgets/fw_text_form_field.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';

enum _SourceType {
  channel,
  playlist,
  dynamicContent,
  hashtagPlaylist,
  sku,
  singleContent,
}

class OpenVideoWithSourceScreen extends StatefulWidget {
  const OpenVideoWithSourceScreen({Key? key}) : super(key: key);

  @override
  State<OpenVideoWithSourceScreen> createState() =>
      _OpenVideoWithSourceScreenState();
}

class _OpenVideoWithSourceScreenState extends State<OpenVideoWithSourceScreen> {
  final _formKey = GlobalKey<FormState>();

  _SourceType _selectedSource = _SourceType.channel;
  bool _enablePip = true;
  String _channel = '';
  String _playlist = '';
  String _hashtagFilterExpression = '';
  String _contentId = '';
  String _productIds = '';
  String _dynamicContentKey = '';
  String _dynamicContentValues = '';

  static const _sourceLabels = <_SourceType, String>{
    _SourceType.channel: 'Channel',
    _SourceType.playlist: 'Playlist',
    _SourceType.dynamicContent: 'Dynamic Content',
    _SourceType.hashtagPlaylist: 'Hashtag Playlist',
    _SourceType.sku: 'SKU',
    _SourceType.singleContent: 'Single Content',
  };

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: fwAppBar(
          context: context,
          titleText: 'Open Video Player (Source)',
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: _buildBody(context),
        ),
      ),
      onPopInvokedWithResult: (_, __) {
        context.read<PlayerConfigurationState>().reset();
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSourceSelector(),
              const SizedBox(height: 16),
              ..._buildDynamicFields(),
              const SizedBox(height: 16),
              _buildEnablePictureInPicture(context),
              _buildConfigButton(context),
              const SizedBox(height: 20),
              _buildActionButtonList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSourceSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Content Source',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _showSourcePicker(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _sourceLabels[_selectedSource] ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showSourcePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) {
        return CupertinoActionSheet(
          title: const Text('Select Content Source'),
          actions: _sourceLabels.keys.map((source) {
            return CupertinoActionSheetAction(
              isDefaultAction: source == _selectedSource,
              onPressed: () {
                setState(() => _selectedSource = source);
                Navigator.of(ctx).pop();
              },
              child: Text(_sourceLabels[source] ?? source.name),
            );
          }).toList(),
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
        );
      },
    );
  }

  List<Widget> _buildDynamicFields() {
    switch (_selectedSource) {
      case _SourceType.channel:
        return [
          _buildTextField('Channel ID',
              initialValue: 'OK1BXMy',
              required: true,
              onSaved: (v) => _channel = v ?? ''),
        ];
      case _SourceType.playlist:
        return [
          _buildTextField('Channel ID',
              initialValue: 'OK1BXMy',
              required: true,
              onSaved: (v) => _channel = v ?? ''),
          const SizedBox(height: 12),
          _buildTextField('Playlist ID',
              initialValue: '5maAAm',
              required: true,
              onSaved: (v) => _playlist = v ?? ''),
        ];
      case _SourceType.dynamicContent:
        return [
          _buildTextField('Channel ID',
              initialValue: '23LBMWN',
              required: true,
              onSaved: (v) => _channel = v ?? ''),
          const SizedBox(height: 12),
          _buildTextField('Parameter Key',
              initialValue: 'category',
              hintText: 'e.g. category',
              required: true,
              onSaved: (v) => _dynamicContentKey = v ?? ''),
          const SizedBox(height: 12),
          _buildTextField('Parameter Values',
              initialValue: 'dessert',
              hintText: 'Comma-separated, e.g. sport,food',
              required: true,
              onSaved: (v) => _dynamicContentValues = v ?? ''),
        ];
      case _SourceType.hashtagPlaylist:
        return [
          _buildTextField('Channel ID',
              initialValue: 'BKQlqD',
              required: true,
              onSaved: (v) => _channel = v ?? ''),
          const SizedBox(height: 12),
          _buildTextField('Hashtag Filter Expression',
              initialValue: 'powder',
              hintText: 'e.g. (and sport food)',
              required: true,
              onSaved: (v) => _hashtagFilterExpression = v ?? ''),
        ];
      case _SourceType.sku:
        return [
          _buildTextField('Channel ID',
              initialValue: 'OK1BXMy',
              required: true,
              onSaved: (v) => _channel = v ?? ''),
          const SizedBox(height: 12),
          _buildTextField('Product IDs',
              initialValue: 'yw9q6NG',
              hintText: 'Comma-separated, e.g. sku1,sku2',
              required: true,
              onSaved: (v) => _productIds = v ?? ''),
        ];
      case _SourceType.singleContent:
        return [
          _buildTextField('Content ID',
              initialValue: 'gwkaR1',
              required: true,
              onSaved: (v) => _contentId = v ?? ''),
        ];
    }
  }

  Widget _buildTextField(
    String label, {
    String? hintText,
    String? initialValue,
    bool required = false,
    FormFieldSetter<String>? onSaved,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        FWTextFormField(
          key: ValueKey('${_selectedSource.name}_$label'),
          hintText: hintText ?? 'Enter $label',
          initialValue: initialValue,
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

  Widget _buildEnablePictureInPicture(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _enablePip,
      onChanged: (value) {
        setState(() {
          _enablePip = value ?? false;
        });
      },
      title: Text(S.of(context).enablePictureInPicture),
    );
  }

  Widget _buildConfigButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamed("/player_configuration");
      },
      child: const Text('Player Configuration'),
    );
  }

  Widget _buildActionButtonList(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).maybePop(),
            child: const Text('Cancel'),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: ElevatedButton(
            onPressed: () => _openVideoPlayer(context),
            child: const Text('Open'),
          ),
        ),
      ],
    );
  }

  void _openVideoPlayer(BuildContext context) {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    final playerConfig =
        context.read<PlayerConfigurationState>().playerConfiguration;

    final source = _buildSource();
    if (source == null) return;

    FireworkSDK.getInstance().openVideoPlayerWithSource(
      source: source,
      config: OpenVideoPlayerConfiguration.withPlayerConfiguration(
        playerConfiguration: playerConfig,
        enablePictureInPicture: _enablePip,
      ),
    );
  }

  OpenVideoPlayerSource? _buildSource() {
    switch (_selectedSource) {
      case _SourceType.channel:
        return OpenVideoPlayerSource.channel(channelId: _channel);
      case _SourceType.playlist:
        return OpenVideoPlayerSource.playlist(
          channelId: _channel,
          playlistId: _playlist,
        );
      case _SourceType.dynamicContent:
        return OpenVideoPlayerSource.dynamicContent(
          channelId: _channel,
          parameters: {
            _dynamicContentKey: _dynamicContentValues
                .split(',')
                .map((s) => s.trim())
                .where((s) => s.isNotEmpty)
                .toList(),
          },
        );
      case _SourceType.hashtagPlaylist:
        return OpenVideoPlayerSource.hashtagPlaylist(
          channelId: _channel,
          filterExpression: _hashtagFilterExpression,
        );
      case _SourceType.sku:
        return OpenVideoPlayerSource.sku(
          channelId: _channel,
          productIds: _productIds
              .split(',')
              .map((s) => s.trim())
              .where((s) => s.isNotEmpty)
              .toList(),
        );
      case _SourceType.singleContent:
        return OpenVideoPlayerSource.singleContent(contentId: _contentId);
    }
  }
}
