import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../states/player_deck_configuration_state.dart';
import '../../widgets/fw_app_bar.dart';

class PlayerDeckConfigurationScreen extends StatefulWidget {
  const PlayerDeckConfigurationScreen({Key? key}) : super(key: key);

  @override
  State<PlayerDeckConfigurationScreen> createState() =>
      _PlayerDeckConfigurationScreenState();
}

class _PlayerDeckConfigurationScreenState
    extends State<PlayerDeckConfigurationScreen> {
  late PlayerDeckConfiguration _config;

  @override
  void initState() {
    super.initState();
    _config = context
        .read<PlayerDeckConfigurationState>()
        .playerDeckConfiguration
        .deepCopy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fwAppBar(
        context: context,
        titleText: S.of(context).playerDeckConfiguration,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('Appearance'),
                  _buildBackgroundColorSelector(),
                  const SizedBox(height: 16),
                  _buildSliderRow(
                    label: 'Corner Radius',
                    value: _config.cornerRadius ?? 8,
                    min: 0,
                    max: 30,
                    onChanged: (v) => setState(() => _config.cornerRadius = v),
                  ),
                  const Divider(height: 32),
                  _buildSectionHeader('Playback'),
                  _buildSwitchRow(
                    label: 'Enable Autoplay',
                    value: _config.enableAutoplay ?? true,
                    onChanged: (v) =>
                        setState(() => _config.enableAutoplay = v),
                  ),
                  _buildMuteStateSelector(),
                  const Divider(height: 32),
                  _buildSectionHeader('Item Controls'),
                  _buildSwitchRow(
                    label: 'Show Play Button',
                    value: !(_config.hidePlayIcon ?? false),
                    onChanged: (v) => setState(() => _config.hidePlayIcon = !v),
                  ),
                  if (!(_config.hidePlayIcon ?? false))
                    _buildSliderRow(
                      label: 'Play Icon Width',
                      value: _config.playIconWidth ?? 50,
                      min: 20,
                      max: 100,
                      onChanged: (v) =>
                          setState(() => _config.playIconWidth = v),
                    ),
                  _buildSwitchRow(
                    label: 'Show Mute Button (iOS)',
                    value: _config.showMuteButton ?? true,
                    onChanged: (v) =>
                        setState(() => _config.showMuteButton = v),
                  ),
                  _buildSwitchRow(
                    label: 'Show Share Button',
                    value: _config.showShareButton ?? true,
                    onChanged: (v) =>
                        setState(() => _config.showShareButton = v),
                  ),
                  _buildSwitchRow(
                    label: 'Enable Full Screen',
                    value: _config.enableFullScreen ?? true,
                    onChanged: (v) =>
                        setState(() => _config.enableFullScreen = v),
                  ),
                  const Divider(height: 32),
                  _buildSectionHeader('Badges'),
                  _buildSwitchRow(
                    label: 'Show Sponsored Label',
                    value: _config.showAdBadge ?? false,
                    onChanged: (v) => setState(() => _config.showAdBadge = v),
                  ),
                  const Divider(height: 32),
                  _buildSectionHeader('Subtitle'),
                  _buildSwitchRow(
                    label: 'Swap Mute & Subtitle Buttons (iOS)',
                    value: _config.subtitleConfiguration
                            ?.swapMuteAndSubtitleButtons ??
                        false,
                    onChanged: (v) => setState(() {
                      _config.subtitleConfiguration ??=
                          PlayerDeckSubtitleConfiguration();
                      _config.subtitleConfiguration!
                          .swapMuteAndSubtitleButtons = v;
                    }),
                  ),
                  _buildSubtitleColorSelector(
                    label: 'Subtitle Text Color',
                    current: _config.subtitleConfiguration?.textColor ?? '',
                    onChanged: (v) => setState(() {
                      _config.subtitleConfiguration ??=
                          PlayerDeckSubtitleConfiguration();
                      _config.subtitleConfiguration!.textColor =
                          v.isEmpty ? null : v;
                    }),
                  ),
                  const SizedBox(height: 8),
                  _buildSubtitleColorSelector(
                    label: 'Subtitle Background Color',
                    current:
                        _config.subtitleConfiguration?.backgroundColor ?? '',
                    onChanged: (v) => setState(() {
                      _config.subtitleConfiguration ??=
                          PlayerDeckSubtitleConfiguration();
                      _config.subtitleConfiguration!.backgroundColor =
                          v.isEmpty ? null : v;
                    }),
                  ),
                  const Divider(height: 32),
                  _buildSectionHeader('Layout'),
                  _buildSliderRow(
                    label: 'Item Spacing',
                    value: _config.itemSpacing ?? 16,
                    min: 0,
                    max: 50,
                    onChanged: (v) => setState(() => _config.itemSpacing = v),
                  ),
                  _buildSliderRow(
                    label: 'Content Insets',
                    value: _config.contentPadding?.left ?? 10,
                    min: 0,
                    max: 50,
                    onChanged: (v) => setState(() {
                      _config.contentPadding = PlayerDeckPadding(
                        top: v,
                        right: v,
                        bottom: v,
                        left: v,
                      );
                    }),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          _buildButtons(context),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSwitchRow({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildSliderRow({
    required String label,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ${value.toInt()}', style: const TextStyle(fontSize: 14)),
        Slider(
          value: value.clamp(min, max),
          min: min,
          max: max,
          divisions: (max - min).toInt(),
          label: value.toInt().toString(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildBackgroundColorSelector() {
    final colors = <String, String>{
      'Default': '',
      'White': '#FFFFFF',
      'Blue': '#007AFF',
      'Green': '#34C759',
      'Red': '#FF3B30',
    };
    final current = _config.backgroundColor ?? '';
    return Wrap(
      spacing: 8,
      children: colors.entries.map((entry) {
        final isSelected =
            current == entry.value || (current.isEmpty && entry.value.isEmpty);
        return ChoiceChip(
          label: Text(entry.key),
          selected: isSelected,
          onSelected: (_) {
            setState(() {
              _config.backgroundColor =
                  entry.value.isEmpty ? null : entry.value;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildSubtitleColorSelector({
    required String label,
    required String current,
    required ValueChanged<String> onChanged,
  }) {
    final colors = <String, String>{
      'Default': '',
      'White': '#FFFFFF',
      'Black': '#000000',
      'Yellow': '#FFD60A',
      'Blue': '#007AFF',
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 4),
        Wrap(
          spacing: 8,
          children: colors.entries.map((entry) {
            final isSelected = current == entry.value ||
                (current.isEmpty && entry.value.isEmpty);
            return ChoiceChip(
              label: Text(entry.key),
              selected: isSelected,
              onSelected: (_) => onChanged(entry.value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMuteStateSelector() {
    return Row(
      children: [
        const Text('First Display Mute State (iOS):'),
        const SizedBox(width: 12),
        Expanded(
          child: SegmentedButton<PlayerDeckMuteState>(
            segments: const [
              ButtonSegment(
                value: PlayerDeckMuteState.defaultMuted,
                label: Text('Muted', style: TextStyle(fontSize: 12)),
              ),
              ButtonSegment(
                value: PlayerDeckMuteState.unmuted,
                label: Text('Unmuted', style: TextStyle(fontSize: 12)),
              ),
            ],
            selected: {
              _config.onFirstDisplayMuteState ?? PlayerDeckMuteState.unmuted
            },
            onSelectionChanged: (s) {
              setState(() => _config.onFirstDisplayMuteState = s.first);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _onReset,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  minimumSize: const Size(double.infinity, 48),
                ),
                child:
                    const Text('Reset', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: ElevatedButton(
                onPressed: _onSave,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onReset() {
    context.read<PlayerDeckConfigurationState>().reset();
    Navigator.pop(context);
  }

  void _onSave() {
    context.read<PlayerDeckConfigurationState>().playerDeckConfiguration =
        _config;
    Navigator.pop(context);
  }
}
