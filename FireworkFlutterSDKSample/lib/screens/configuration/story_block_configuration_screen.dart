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
              _buildVideoCompleteActionSegmentedControl(context),
              const SizedBox(
                height: 20,
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
                    child: _buildVideoDetailTitleShow(context),
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
              _buildShareURL(context),
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
}
