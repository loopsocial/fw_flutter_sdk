import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/states/circle_story_configuration_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../widgets/fw_app_bar.dart';
import '../../widgets/fw_text_form_field.dart';

class CircleStoryConfigurationScreen extends StatefulWidget {
  const CircleStoryConfigurationScreen({Key? key}) : super(key: key);

  @override
  State<CircleStoryConfigurationScreen> createState() =>
      _CircleStoryConfigurationScreenState();
}

class _CircleStoryConfigurationScreenState
    extends State<CircleStoryConfigurationScreen> {
  final _formKey = GlobalKey<FormState>();
  CircleStoryConfiguration _initConfig = CircleStoryConfiguration();
  CircleStoryConfiguration _resultConfig = CircleStoryConfiguration();

  @override
  void initState() {
    super.initState();
    _initConfig = context.read<CircleStoryConfigurationState>()
        .circleStoryConfiguration;
    _resultConfig = _initConfig.deepCopy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fwAppBar(
        context: context,
        titleText: 'Circle Story Configuration',
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildBackgroundColor(context),
              const SizedBox(height: 20),
              _buildEnableAutoplay(context),
              const SizedBox(height: 20),
              _buildShowAdBadge(context),
              const SizedBox(height: 20),
              _buildPlayIconHidden(context),
              const SizedBox(height: 20),
              if (!(_resultConfig.playIcon?.hidden ?? false))
                _buildPlayIconWidth(context),
              const SizedBox(height: 20),
              _buildItemSpacing(context),
              const SizedBox(height: 40),
              _buildButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundColor(BuildContext context) {
    final controller = TextEditingController(text: _resultConfig.backgroundColor);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Background Color',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        FWTextFormField(
          controller: controller,
          hintText: 'Enter background color (e.g., #F5F5F5)',
          validator: (value) {
            if (value != null && value.isNotEmpty) {
              if (!RegExp(r'^#[0-9A-Fa-f]{6}$').hasMatch(value)) {
                return 'Invalid hex color format (e.g., #F5F5F5)';
              }
            }
            return null;
          },
          onSaved: (value) {
            _resultConfig.backgroundColor = value?.isEmpty == true ? null : value;
          },
        ),
      ],
    );
  }

  Widget _buildEnableAutoplay(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultConfig.enableAutoplay ?? true,
      onChanged: (value) {
        setState(() {
          _resultConfig.enableAutoplay = value ?? true;
        });
      },
      title: const Text('Enable Autoplay'),
      subtitle: const Text('Automatically play videos when scrolling'),
    );
  }

  Widget _buildShowAdBadge(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultConfig.showAdBadge ?? true,
      onChanged: (value) {
        setState(() {
          _resultConfig.showAdBadge = value ?? true;
        });
      },
      title: const Text('Show Ad Badge'),
      subtitle: const Text('Display sponsored label on ads'),
    );
  }

  Widget _buildPlayIconHidden(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultConfig.playIcon?.hidden ?? false,
      onChanged: (value) {
        setState(() {
          _resultConfig.playIcon ??= VideoFeedPlayIconConfiguration();
          _resultConfig.playIcon!.hidden = value ?? false;
        });
      },
      title: const Text('Hide Play Icon'),
      subtitle: const Text('Hide the play icon overlay on thumbnails'),
    );
  }

  Widget _buildPlayIconWidth(BuildContext context) {
    final controller = TextEditingController(
        text: _resultConfig.playIcon?.iconWidth?.toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Play Icon Width',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        FWTextFormField(
          controller: controller,
          hintText: 'Enter play icon width (e.g., 48)',
          validator: (value) {
            if (value != null && value.isNotEmpty) {
              final width = double.tryParse(value);
              if (width == null || width <= 0) {
                return 'Please enter a valid positive number';
              }
            }
            return null;
          },
          onSaved: (value) {
            if (value == null || value.isEmpty) {
              _resultConfig.playIcon?.iconWidth = null;
            } else {
              final width = double.tryParse(value);
              if (width != null) {
                _resultConfig.playIcon ??= VideoFeedPlayIconConfiguration();
                _resultConfig.playIcon!.iconWidth = width;
              }
            }
          },
        ),
      ],
    );
  }

  Widget _buildItemSpacing(BuildContext context) {
    final controller =
        TextEditingController(text: _resultConfig.itemSpacing?.toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Item Spacing',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        FWTextFormField(
          controller: controller,
          hintText: 'Enter item spacing (e.g., 10)',
          validator: (value) {
            if (value != null && value.isNotEmpty) {
              final spacing = double.tryParse(value);
              if (spacing == null || spacing < 0) {
                return 'Please enter a valid non-negative number';
              }
            }
            return null;
          },
          onSaved: (value) {
            if (value == null || value.isEmpty) {
              _resultConfig.itemSpacing = null;
            } else {
              final spacing = double.tryParse(value);
              if (spacing != null) {
                _resultConfig.itemSpacing = spacing;
              }
            }
          },
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: _onResetButtonClick,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              minimumSize: const Size(double.infinity, 48),
            ),
            child: Text(
              S.of(context).reset,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: ElevatedButton(
            onPressed: _onSaveButtonClick,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
            ),
            child: Text(S.of(context).save),
          ),
        ),
      ],
    );
  }

  void _onResetButtonClick() {
    context.read<CircleStoryConfigurationState>().reset();
    Navigator.pop(context);
  }

  void _onSaveButtonClick() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context
          .read<CircleStoryConfigurationState>()
          .circleStoryConfiguration = _resultConfig;
      Navigator.pop(context);
    }
  }
}
