import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/states/player_configuration_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import 'package:provider/provider.dart';

import '../../utils/validation_util.dart';
import '../../widgets/fw_app_bar.dart';
import '../../widgets/fw_text_form_field.dart';

class PlayerConfigurationScreen extends StatefulWidget {
  const PlayerConfigurationScreen({Key? key}) : super(key: key);

  @override
  _PlayerConfigurationScreenState createState() =>
      _PlayerConfigurationScreenState();
}

class _PlayerConfigurationScreenState extends State<PlayerConfigurationScreen> {
  final _formKey = GlobalKey<FormState>();
  VideoPlayerConfiguration _initConfig = VideoPlayerConfiguration();
  final _resultConfig = VideoPlayerConfiguration();

  @override
  void initState() {
    super.initState();
    _initConfig = context.read<PlayerConfigurationState>().playerConfiguration;
    _resultConfig.playerStyle = _initConfig.playerStyle;
    _resultConfig.videoCompleteAction = _initConfig.videoCompleteAction;
    _resultConfig.showShareButton = _initConfig.showShareButton;
    _resultConfig.ctaButtonStyle = _initConfig.ctaButtonStyle;
    _resultConfig.showPlaybackButton = _initConfig.showPlaybackButton;
    _resultConfig.showMuteButton = _initConfig.showMuteButton;
    _resultConfig.launchBehavior = _initConfig.launchBehavior;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fwAppBar(
        context: context,
        titleText: S.of(context).playerConfiguration,
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
            _buildPlayerStyleSegmentedControl(context),
            const SizedBox(
              height: 20,
            ),
            _buildVideoCompleteActionSegmentedControl(context),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: _buildCTABackgroundColor(context),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: _buildCTATextColor(context),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: _buildCTAFontSize(context),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: _buildShareButtonShow(context),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: _buildPlaybackButtonShow(context),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: _buildMuteButtonShow(context),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            _buildVideoLaunchBehaviorSegmentedControl(context),
            const SizedBox(
              height: 20,
            ),
            _buildButtonList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerStyleSegmentedControl(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          S.of(context).videoPlayerStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        CupertinoSegmentedControl<VideoPlayerStyle>(
          padding: EdgeInsets.zero,
          onValueChanged: (value) {
            setState(() {
              _resultConfig.playerStyle = value;
            });
          },
          children: {
            VideoPlayerStyle.full: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).full,
              ),
            ),
            VideoPlayerStyle.fit: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).fit,
              ),
            ),
          },
          groupValue: _resultConfig.playerStyle,
        )
      ],
    );
  }

  Widget _buildVideoCompleteActionSegmentedControl(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          S.of(context).videoPlayerCompleteAction,
        ),
        const SizedBox(
          height: 10,
        ),
        CupertinoSegmentedControl<VideoPlayerCompleteAction>(
          padding: EdgeInsets.zero,
          onValueChanged: (value) {
            setState(() {
              _resultConfig.videoCompleteAction = value;
            });
          },
          children: {
            VideoPlayerCompleteAction.advanceToNext: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).advanceToNext,
              ),
            ),
            VideoPlayerCompleteAction.loop: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).loop,
              ),
            ),
          },
          groupValue: _resultConfig.videoCompleteAction,
        ),
      ],
    );
  }

  Widget _buildShareButtonShow(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultConfig.showShareButton ?? false,
      onChanged: (value) {
        setState(() {
          _resultConfig.showShareButton = value;
        });
      },
      title: Text(
        S.of(context).showShareButton,
      ),
    );
  }

  Widget _buildCTABackgroundColor(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).ctaBackgroundColor),
        FWTextFormField(
          initialValue: _initConfig.ctaButtonStyle?.backgroundColor?.toString(),
          hintText: S.of(context).ctaBackgroundColorHint,
          validator: (text) {
            return ValidationUtil.validateColor(
              text,
              context,
            );
          },
          onSaved: (text) {
            _resultConfig.ctaButtonStyle ??= VideoPlayerCTAStyle();
            _resultConfig.ctaButtonStyle?.backgroundColor = text;
          },
        ),
      ],
    );
  }

  Widget _buildCTATextColor(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).ctaTextColor),
        FWTextFormField(
          initialValue: _initConfig.ctaButtonStyle?.textColor?.toString(),
          hintText: S.of(context).ctaTextColorHint,
          validator: (text) {
            return ValidationUtil.validateColor(
              text,
              context,
            );
          },
          onSaved: (text) {
            _resultConfig.ctaButtonStyle ??= VideoPlayerCTAStyle();
            _resultConfig.ctaButtonStyle?.textColor = text;
          },
        ),
      ],
    );
  }

  Widget _buildCTAFontSize(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).ctaFontSize),
        FWTextFormField(
          initialValue:
              _initConfig.ctaButtonStyle?.fontSize?.toStringAsFixed(0),
          hintText: S.of(context).ctaFontHint,
          validator: (text) {
            return ValidationUtil.validateNumber(
              context: context,
              text: text,
              min: 8,
              max: 30,
              errorMessage: S.of(context).fontSizeError,
              rangeErrorMessage: S.of(context).fontSizeRangeError,
            );
          },
          onSaved: (text) {
            _resultConfig.ctaButtonStyle ??= VideoPlayerCTAStyle();
            _resultConfig.ctaButtonStyle?.fontSize =
                int.tryParse(text ?? '')?.toDouble();
          },
        )
      ],
    );
  }

  Widget _buildPlaybackButtonShow(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultConfig.showPlaybackButton ?? false,
      onChanged: (value) {
        setState(() {
          _resultConfig.showPlaybackButton = value;
        });
      },
      title: Text(
        S.of(context).showPlaybackButton,
      ),
    );
  }

  Widget _buildMuteButtonShow(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultConfig.showMuteButton ?? false,
      onChanged: (value) {
        setState(() {
          _resultConfig.showMuteButton = value;
        });
      },
      title: Text(
        S.of(context).showMuteButton,
      ),
    );
  }

  Widget _buildVideoLaunchBehaviorSegmentedControl(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).videolaunchBehavior),
        const SizedBox(
          height: 20,
        ),
        CupertinoSegmentedControl<VideoLaunchBehavior>(
          padding: EdgeInsets.zero,
          onValueChanged: (value) {
            setState(() {
              _resultConfig.launchBehavior = value;
            });
          },
          children: {
            VideoLaunchBehavior.defaultBehavior: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).defaultBehavior,
              ),
            ),
            VideoLaunchBehavior.muteOnFirstLaunch: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).muteOnFirstLaunch,
              ),
            ),
          },
          groupValue: _resultConfig.launchBehavior,
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
          child: Text(
            S.of(context).cancel,
          ),
        ),
      ),
      const SizedBox(
        width: 20,
      ),
      Expanded(
        child: ElevatedButton(
          onPressed: () async {
            final needToPop = await showCupertinoDialog<bool>(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: Text(
                    S.of(context).resetTip,
                  ),
                  actions: [
                    CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(S.of(context).cancel),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () {
                        context.read<PlayerConfigurationState>().reset();
                        Navigator.of(context).pop(true);
                      },
                      child: Text(S.of(context).reset),
                      isDestructiveAction: true,
                    ),
                  ],
                );
              },
            );
            if (needToPop == true) {
              Navigator.of(context).pop();
            }
          },
          child: Text(
            S.of(context).reset,
          ),
        ),
      ),
      const SizedBox(
        width: 20,
      ),
      Expanded(
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState != null &&
                _formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              context.read<PlayerConfigurationState>().playerConfiguration =
                  _resultConfig;
              Navigator.of(context).pop();
            }
          },
          child: Text(
            S.of(context).save,
          ),
        ),
      ),
    ]);
  }
}
