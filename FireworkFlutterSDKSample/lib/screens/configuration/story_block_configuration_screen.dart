import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/states/player_configuration_state.dart';
import 'package:fw_flutter_sdk_example/states/story_block_configuration_state.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../utils/validation_util.dart';
import '../../widgets/fw_app_bar.dart';
import '../../widgets/fw_text_form_field.dart';

class StoryBlockConfigurationScreen extends StatefulWidget {
  const StoryBlockConfigurationScreen({Key? key}) : super(key: key);

  @override
  State<StoryBlockConfigurationScreen> createState() =>
      _StoryBlockConfigurationScreenState();
}

class _StoryBlockConfigurationScreenState
    extends State<StoryBlockConfigurationScreen> {
  final _formKey = GlobalKey<FormState>();
  StoryBlockConfiguration _initConfig = StoryBlockConfiguration();
  StoryBlockConfiguration _resultConfig = StoryBlockConfiguration();

  @override
  void initState() {
    super.initState();
    _initConfig =
        context.read<StoryBlockConfigurationState>().storyBlockConfiguration;
    _resultConfig = _initConfig.deepCopy();
    _resultConfig.ctaDelay ??=
        VideoPlayerCTADelay(type: VideoPlayerCTADelayType.constant, value: 3);
    _resultConfig.ctaHighlightDelay ??=
        VideoPlayerCTADelay(type: VideoPlayerCTADelayType.constant, value: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fwAppBar(
        context: context,
        titleText: S.of(context).storyBlockConfiguration,
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
              _buildPlayerStyleSegmentedControl(context),
              const SizedBox(
                height: 20,
              ),
              _buildVideoCompleteActionSegmentedControl(context),
              const SizedBox(
                height: 20,
              ),
              _buildCtaShapeSegmentedControl(context),
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
                  Expanded(
                    child: _buildCTAUseIOSFontInfo(context),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              _buildCTADelayTypeSegmentedControl(context),
              const SizedBox(
                height: 20,
              ),
              _buildCTADelayValueSlider(context),
              const SizedBox(
                height: 20,
              ),
              _buildCTAHighlightDelayTypeSegmentedControl(context),
              const SizedBox(
                height: 20,
              ),
              _buildCTAHighlightDelayValueSlider(context),
              const SizedBox(
                height: 20,
              ),
              _buildCTAWidthSegmentedControl(context),
              const SizedBox(
                height: 20,
              ),
              _buildActionButtonShapeSegmentedControl(context),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildActionButtonBackgroundColor(context),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: _buildActionButtonTextColor(context),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              _buildActionButtonDividingLineColor(context),
              const SizedBox(
                height: 20,
              ),
              _buildCancelButtonShapeSegmentedControl(context),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildCancelButtonBackgroundColor(context),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: _buildCancelButtonTextColor(context),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              _buildCountdownTimerStyleSegmentedControl(context),
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
                    child: _buildCustomButtons(context),
                  ),
                ],
              ),
              if (defaultTargetPlatform == TargetPlatform.android)
                const SizedBox(
                  height: 20,
                ),
              Row(
                children: [
                  Expanded(
                    child: _buildPlaybackButtonShow(context),
                  ),
                  if (defaultTargetPlatform == TargetPlatform.android)
                    const SizedBox(
                      width: 20,
                    ),
                  Expanded(
                    child: _buildMuteButtonShow(context),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildVideoDetailTitleShow(context),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: _buildHideReplayBadge(context),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildHideCountdownTimer(context),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              _buildShareURL(context),
              const SizedBox(
                height: 20,
              ),
              _buildPlayerLogoOptionSegmentedControl(context),
              const SizedBox(
                height: 20,
              ),
              _buildLogoClickable(context),
              const SizedBox(
                height: 20,
              ),
              _buildEncodedId(context),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildAutoplayEnable(context),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: _buildAutopauseEnable(context),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildAutoFullScreenEnable(context),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              _buildButtonList(context),
            ],
          ),
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
          defaultTargetPlatform == TargetPlatform.android
              ? S.of(context).videoPlayerCompleteAction
              : S.of(context).videoPlayerCompleteAction2,
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

  Widget _buildActionButtonShapeSegmentedControl(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          S.of(context).actionButtonShape,
        ),
        const SizedBox(
          height: 10,
        ),
        CupertinoSegmentedControl<ButtonShape>(
          padding: EdgeInsets.zero,
          onValueChanged: (value) {
            setState(() {
              _resultConfig.actionButtonStyle?.shape = value;
            });
          },
          children: {
            ButtonShape.roundRectangle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).roundRectangle,
              ),
            ),
            ButtonShape.oval: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).oval,
              ),
            ),
          },
          groupValue: _resultConfig.actionButtonStyle?.shape,
        ),
      ],
    );
  }

  Widget _buildCancelButtonShapeSegmentedControl(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          S.of(context).cancelButtonShape,
        ),
        const SizedBox(
          height: 10,
        ),
        CupertinoSegmentedControl<ButtonShape>(
          padding: EdgeInsets.zero,
          onValueChanged: (value) {
            setState(() {
              _resultConfig.cancelButtonStyle?.shape = value;
            });
          },
          children: {
            ButtonShape.roundRectangle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).roundRectangle,
              ),
            ),
            ButtonShape.oval: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).oval,
              ),
            ),
          },
          groupValue: _resultConfig.cancelButtonStyle?.shape,
        ),
      ],
    );
  }

  Widget _buildCtaShapeSegmentedControl(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          S.of(context).ctaShape,
        ),
        const SizedBox(
          height: 10,
        ),
        CupertinoSegmentedControl<ButtonShape>(
          padding: EdgeInsets.zero,
          onValueChanged: (value) {
            setState(() {
              _resultConfig.ctaButtonStyle?.shape = value;
            });
          },
          children: {
            ButtonShape.roundRectangle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).roundRectangle,
              ),
            ),
            ButtonShape.oval: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).oval,
              ),
            ),
          },
          groupValue: _resultConfig.ctaButtonStyle?.shape,
        ),
      ],
    );
  }

  Widget _buildShareButtonShow(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultConfig.showShareButton,
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
        defaultTargetPlatform == TargetPlatform.iOS
            ? Text(
                S.of(context).ctaBackgroundColor2,
              )
            : Text(
                S.of(context).ctaBackgroundColor,
              ),
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
            if ((text ?? "").isNotEmpty) {
              _resultConfig.ctaButtonStyle?.backgroundColor = text;
            } else {
              _resultConfig.ctaButtonStyle?.backgroundColor = null;
            }
          },
        ),
      ],
    );
  }

  Widget _buildActionButtonBackgroundColor(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).actionButtonBackgroundColor),
        FWTextFormField(
          initialValue:
              _initConfig.actionButtonStyle?.backgroundColor?.toString(),
          hintText: S.of(context).ctaBackgroundColorHint,
          validator: (text) {
            return ValidationUtil.validateColor(
              text,
              context,
            );
          },
          onSaved: (text) {
            _resultConfig.actionButtonStyle ??= VideoPlayerActionButtonStyle();
            if ((text ?? "").isNotEmpty) {
              _resultConfig.actionButtonStyle?.backgroundColor = text;
            } else {
              _resultConfig.actionButtonStyle?.backgroundColor = null;
            }
          },
        ),
      ],
    );
  }

  Widget _buildCancelButtonBackgroundColor(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).cancelButtonBackgroundColor),
        FWTextFormField(
          initialValue:
              _initConfig.cancelButtonStyle?.backgroundColor?.toString(),
          hintText: S.of(context).ctaBackgroundColorHint,
          validator: (text) {
            return ValidationUtil.validateColor(
              text,
              context,
            );
          },
          onSaved: (text) {
            _resultConfig.cancelButtonStyle ??= VideoPlayerActionButtonStyle();
            if ((text ?? "").isNotEmpty) {
              _resultConfig.cancelButtonStyle?.backgroundColor = text;
            } else {
              _resultConfig.cancelButtonStyle?.backgroundColor = null;
            }
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
        defaultTargetPlatform == TargetPlatform.iOS
            ? Text(
                S.of(context).ctaTextColor2,
              )
            : Text(
                S.of(context).ctaTextColor,
              ),
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
            if ((text ?? "").isNotEmpty) {
              _resultConfig.ctaButtonStyle?.textColor = text;
            } else {
              _resultConfig.ctaButtonStyle?.textColor = null;
            }
          },
        ),
      ],
    );
  }

  Widget _buildActionButtonTextColor(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).actionButtonTextColor),
        FWTextFormField(
          initialValue: _initConfig.actionButtonStyle?.textColor?.toString(),
          hintText: S.of(context).ctaTextColorHint,
          validator: (text) {
            return ValidationUtil.validateColor(
              text,
              context,
            );
          },
          onSaved: (text) {
            _resultConfig.actionButtonStyle ??= VideoPlayerActionButtonStyle();
            if ((text ?? "").isNotEmpty) {
              _resultConfig.actionButtonStyle?.textColor = text;
            } else {
              _resultConfig.actionButtonStyle?.textColor = null;
            }
          },
        ),
      ],
    );
  }

  Widget _buildCancelButtonTextColor(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).cancelButtonTextColor),
        FWTextFormField(
          initialValue: _initConfig.cancelButtonStyle?.textColor?.toString(),
          hintText: S.of(context).ctaTextColorHint,
          validator: (text) {
            return ValidationUtil.validateColor(
              text,
              context,
            );
          },
          onSaved: (text) {
            _resultConfig.cancelButtonStyle ??= VideoPlayerActionButtonStyle();
            if ((text ?? "").isNotEmpty) {
              _resultConfig.cancelButtonStyle?.textColor = text;
            } else {
              _resultConfig.cancelButtonStyle?.textColor = null;
            }
          },
        ),
      ],
    );
  }

  Widget _buildActionButtonDividingLineColor(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).actionButtonDividerLineColor),
        FWTextFormField(
          initialValue:
              _initConfig.actionButtonStyle?.dividingLineColor?.toString(),
          hintText: S.of(context).ctaTextColorHint,
          validator: (text) {
            return ValidationUtil.validateColor(
              text,
              context,
            );
          },
          onSaved: (text) {
            _resultConfig.actionButtonStyle ??= VideoPlayerActionButtonStyle();
            if ((text ?? "").isNotEmpty) {
              _resultConfig.actionButtonStyle?.dividingLineColor = text;
            } else {
              _resultConfig.actionButtonStyle?.dividingLineColor = null;
            }
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
        defaultTargetPlatform == TargetPlatform.iOS
            ? Text(
                S.of(context).ctaFontSize2,
              )
            : Text(
                S.of(context).ctaFontSize,
              ),
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

  Widget _buildCTAUseIOSFontInfo(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultConfig.ctaButtonStyle?.iOSFontInfo != null,
      onChanged: (value) {
        setState(() {
          if (value == true) {
            _resultConfig.ctaButtonStyle ??= VideoPlayerCTAStyle();
            _resultConfig.ctaButtonStyle?.iOSFontInfo = IOSFontInfo(
              fontName: "TimesNewRomanPS-ItalicMT",
            );
          } else {
            _resultConfig.ctaButtonStyle?.iOSFontInfo = null;
          }
        });
      },
      title: Text(
        S.of(context).useIOSFontInfoForCTA,
      ),
    );
  }

  Widget _buildCTADelayTypeSegmentedControl(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          S.of(context).ctaDelayType,
        ),
        const SizedBox(
          height: 10,
        ),
        CupertinoSegmentedControl<VideoPlayerCTADelayType>(
          padding: EdgeInsets.zero,
          onValueChanged: (value) {
            setState(() {
              _resultConfig.ctaDelay?.type = value;
              if (value == VideoPlayerCTADelayType.percentage) {
                _resultConfig.ctaDelay?.value = 0.3;
              } else {
                _resultConfig.ctaDelay?.value = 3;
              }
            });
          },
          children: {
            VideoPlayerCTADelayType.constant: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).constant,
              ),
            ),
            VideoPlayerCTADelayType.percentage: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).percentage,
              ),
            ),
          },
          groupValue: _resultConfig.ctaDelay?.type,
        )
      ],
    );
  }

  Widget _buildCTADelayValueSlider(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          S.of(context).ctaDelayValue(_resultConfig.ctaDelay?.value ?? 3),
        ),
        const SizedBox(
          height: 10,
        ),
        Slider(
            min: 0,
            max: _resultConfig.ctaDelay?.type ==
                    VideoPlayerCTADelayType.percentage
                ? 1.0
                : 10.0,
            divisions: 10,
            value: _resultConfig.ctaDelay?.value ?? 3,
            onChanged: (double changedValue) {
              setState(() {
                _resultConfig.ctaDelay?.value = changedValue;
              });
            }),
      ],
    );
  }

  Widget _buildCTAHighlightDelayTypeSegmentedControl(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          S.of(context).ctaHighlightDelayType,
        ),
        const SizedBox(
          height: 10,
        ),
        CupertinoSegmentedControl<VideoPlayerCTADelayType>(
          padding: EdgeInsets.zero,
          onValueChanged: (value) {
            setState(() {
              _resultConfig.ctaHighlightDelay?.type = value;
              if (value == VideoPlayerCTADelayType.percentage) {
                _resultConfig.ctaHighlightDelay?.value = 0.3;
              } else {
                _resultConfig.ctaHighlightDelay?.value = 2;
              }
            });
          },
          children: {
            VideoPlayerCTADelayType.constant: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).constant,
              ),
            ),
            VideoPlayerCTADelayType.percentage: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).percentage,
              ),
            ),
          },
          groupValue: _resultConfig.ctaHighlightDelay?.type,
        )
      ],
    );
  }

  Widget _buildCTAHighlightDelayValueSlider(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          S.of(context).ctaHighlightDelayValue(
              _resultConfig.ctaHighlightDelay?.value ?? 2),
        ),
        const SizedBox(
          height: 10,
        ),
        Slider(
            min: 0,
            max: _resultConfig.ctaHighlightDelay?.type ==
                    VideoPlayerCTADelayType.percentage
                ? 1.0
                : 10.0,
            divisions: 10,
            value: _resultConfig.ctaHighlightDelay?.value ?? 2,
            onChanged: (double changedValue) {
              setState(() {
                _resultConfig.ctaHighlightDelay?.value = changedValue;
              });
            }),
      ],
    );
  }

  Widget _buildCTAWidthSegmentedControl(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          S.of(context).ctaWidth,
        ),
        const SizedBox(
          height: 10,
        ),
        CupertinoSegmentedControl<VideoPlayerCTAWidth>(
          padding: EdgeInsets.zero,
          onValueChanged: (value) {
            setState(() {
              _resultConfig.ctaWidth = value;
            });
          },
          children: {
            VideoPlayerCTAWidth.fullWidth: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).fullWidth,
              ),
            ),
            VideoPlayerCTAWidth.compact: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).compact,
              ),
            ),
            VideoPlayerCTAWidth.sizeToFit: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).sizeToFit,
              ),
            ),
          },
          groupValue: _resultConfig.ctaWidth,
        ),
      ],
    );
  }

  Widget _buildCountdownTimerStyleSegmentedControl(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          S.of(context).livestreamCountdownTimerTheme,
        ),
        const SizedBox(
          height: 10,
        ),
        CupertinoSegmentedControl<CountdownTimerAppearanceMode>(
          padding: EdgeInsets.zero,
          onValueChanged: (value) {
            setState(() {
              _resultConfig.countdownTimerConfiguration?.appearance = value;
            });
          },
          children: {
            CountdownTimerAppearanceMode.dark: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).dark,
              ),
            ),
            CountdownTimerAppearanceMode.light: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).light,
              ),
            ),
          },
          groupValue: _resultConfig.countdownTimerConfiguration?.appearance,
        ),
      ],
    );
  }

  Widget _buildPlaybackButtonShow(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultConfig.showPlaybackButton,
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
      value: _resultConfig.showMuteButton,
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

  Widget _buildCustomButtons(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultConfig.buttonConfiguration != null,
      onChanged: (value) {
        setState(() {
          if (value == true) {
            _resultConfig.buttonConfiguration = VideoPlayerButtonConfiguration(
              videoDetailButton: ButtonInfo(imageName: "custom_more"),
              closeButton: ButtonInfo(imageName: "custom_close"),
              pipButton: ButtonInfo(imageName: "custom_pip"),
              muteButton: ButtonInfo(imageName: "custom_mute"),
              unmuteButton: ButtonInfo(imageName: "custom_unmute"),
              playButton: ButtonInfo(imageName: "custom_play"),
              pauseButton: ButtonInfo(imageName: "custom_pause"),
            );
          } else {
            _resultConfig.buttonConfiguration = null;
          }
        });
      },
      title: Text(
        S.of(context).enableCustomButtons,
      ),
    );
  }

  Widget _buildVideoDetailTitleShow(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultConfig.showVideoDetailTitle,
      onChanged: (value) {
        setState(() {
          _resultConfig.showVideoDetailTitle = value;
        });
      },
      title: Text(
        S.of(context).showVideoDetailTitle,
      ),
    );
  }

  Widget _buildHideReplayBadge(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultConfig.replayBadgeConfiguration?.isHidden ?? true,
      onChanged: (value) {
        setState(() {
          _resultConfig.replayBadgeConfiguration ??=
              ReplayBadgeConfiguration(isHidden: true);
          _resultConfig.replayBadgeConfiguration!.isHidden = value ?? true;
        });
      },
      title: Text(
        S.of(context).hideReplayBadge,
      ),
    );
  }

  Widget _buildHideCountdownTimer(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultConfig.countdownTimerConfiguration?.isHidden ?? false,
      onChanged: (value) {
        setState(() {
          _resultConfig.countdownTimerConfiguration ??=
              CountdownTimerConfiguration(isHidden: false);
          _resultConfig.countdownTimerConfiguration!.isHidden = value ?? false;
        });
      },
      title: Text(
        S.of(context).hideCountdownTimer,
      ),
    );
  }

  Widget _buildShareURL(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).shareBaseURL),
        const SizedBox(
          height: 10,
        ),
        FWTextFormField(
          initialValue: _resultConfig.shareBaseURL,
          hintText: S.of(context).urlHint,
          validator: (text) {
            if ((text ?? "").isEmpty) {
              return null;
            }

            return ValidationUtil.validURL(
              text: text,
              errorMessage: S.of(context).urlError,
              requiredError: S.of(context).urlRequiredError,
            );
          },
          onSaved: (text) {
            if ((text ?? "").isNotEmpty) {
              _resultConfig.shareBaseURL = text;
            } else {
              _resultConfig.shareBaseURL = null;
            }
          },
        )
      ],
    );
  }

  Widget _buildPlayerLogoOptionSegmentedControl(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          S.of(context).playerLogoOption,
        ),
        const SizedBox(
          height: 10,
        ),
        CupertinoSegmentedControl<VideoPlayerLogoOption>(
          padding: EdgeInsets.zero,
          onValueChanged: (value) {
            setState(() {
              _resultConfig.videoPlayerLogoConfiguration =
                  VideoPlayerLogoConfiguration(
                option: value,
              );
            });
          },
          children: {
            VideoPlayerLogoOption.disabled: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).disabled,
              ),
            ),
            VideoPlayerLogoOption.creator: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).creator,
              ),
            ),
            VideoPlayerLogoOption.channelAggregator: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).channelAggregator,
              ),
            ),
          },
          groupValue: _resultConfig.videoPlayerLogoConfiguration?.option,
        ),
      ],
    );
  }

  Widget _buildEncodedId(BuildContext context) {
    final option = _resultConfig.videoPlayerLogoConfiguration?.option;
    final enabled = option == VideoPlayerLogoOption.creator ||
        option == VideoPlayerLogoOption.channelAggregator;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).playerLogoEncodedId),
        FWTextFormField(
          initialValue: _resultConfig.videoPlayerLogoConfiguration?.encodedId,
          hintText: S.of(context).channelIdHint,
          enabled: enabled,
          validator: (text) {
            if (!enabled) {
              return null;
            }

            return ValidationUtil.validId(
              text: text,
              errorMessage: S.of(context).channelIdError,
              requiredError: S.of(context).channelIdRequiredError,
            );
          },
          onSaved: (text) {
            if (enabled) {
              _resultConfig.videoPlayerLogoConfiguration?.encodedId = text;
            } else {
              _resultConfig.videoPlayerLogoConfiguration?.encodedId = null;
            }
          },
        )
      ],
    );
  }

  Widget _buildLogoClickable(BuildContext context) {
    final option = _resultConfig.videoPlayerLogoConfiguration?.option;
    final enabled = option == VideoPlayerLogoOption.creator ||
        option == VideoPlayerLogoOption.channelAggregator;
    return CheckboxListTile(
      enabled: enabled,
      contentPadding: EdgeInsets.zero,
      value: _resultConfig.videoPlayerLogoConfiguration?.isClickable ?? true,
      onChanged: (value) {
        setState(() {
          _resultConfig.videoPlayerLogoConfiguration!.isClickable =
              value ?? true;
        });
      },
      title: Text(
        S.of(context).playerLogoClickable,
      ),
    );
  }

  Widget _buildButtonList(BuildContext context) {
    final navigator = Navigator.of(context);
    return Row(children: [
      Expanded(
        child: ElevatedButton(
          onPressed: () {
            navigator.pop();
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
                        navigator.pop();
                      },
                      child: Text(S.of(context).cancel),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () {
                        context.read<PlayerConfigurationState>().reset();
                        navigator.pop(true);
                      },
                      isDestructiveAction: true,
                      child: Text(S.of(context).reset),
                    ),
                  ],
                );
              },
            );
            if (needToPop == true) {
              navigator.pop();
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
              navigator.pop();
              context
                  .read<StoryBlockConfigurationState>()
                  .storyBlockConfiguration = _resultConfig;
            }
          },
          child: Text(
            S.of(context).save,
          ),
        ),
      ),
    ]);
  }

  Widget _buildAutoplayEnable(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultConfig.enableAutoplay,
      onChanged: (value) {
        setState(() {
          _resultConfig.enableAutoplay = value;
        });
      },
      title: Text(
        S.of(context).enableAutoplay2,
      ),
    );
  }

  Widget _buildAutopauseEnable(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultConfig.enableAutopause,
      onChanged: (value) {
        setState(() {
          _resultConfig.enableAutopause = value;
        });
      },
      title: Text(
        S.of(context).enableAutopause,
      ),
    );
  }

  Widget _buildAutoFullScreenEnable(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultConfig.enableFullScreen,
      onChanged: (value) {
        setState(() {
          _resultConfig.enableFullScreen = value;
        });
      },
      title: Text(
        S.of(context).enableFullScreen,
      ),
    );
  }
}
