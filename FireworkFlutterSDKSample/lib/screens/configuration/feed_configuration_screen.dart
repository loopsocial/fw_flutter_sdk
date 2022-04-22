import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/states/feed_configuration_state.dart';
import 'package:fw_flutter_sdk_example/utils/validation_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../widgets/fw_app_bar.dart';
import '../../widgets/fw_text_form_field.dart';

class FeedConfigurationScreen extends StatefulWidget {
  const FeedConfigurationScreen({Key? key}) : super(key: key);

  @override
  _FeedConfigurationScreenState createState() =>
      _FeedConfigurationScreenState();
}

class _FeedConfigurationScreenState extends State<FeedConfigurationScreen> {
  final _formKey = GlobalKey<FormState>();
  VideoFeedConfiguration _initConfig = VideoFeedConfiguration();
  final _resultConfig = VideoFeedConfiguration();

  @override
  void initState() {
    super.initState();
    _initConfig = context.read<FeedConfigurationState>().feedConfiguration;
    _resultConfig.backgroundColor = _initConfig.backgroundColor;
    _resultConfig.cornerRadius = _initConfig.cornerRadius;
    _resultConfig.title = _initConfig.title;
    _resultConfig.titlePosition = _initConfig.titlePosition;
    _resultConfig.playIcon = _initConfig.playIcon;
    _resultConfig.showAdBadge = _initConfig.showAdBadge;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fwAppBar(
        context: context,
        titleText: S.of(context).feedConfiguration,
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
            Row(
              children: [
                Expanded(
                  child: _buildBackgroundColor(context),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: _buildCornerRadius(context),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: _buildTitleHidden(context),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: _buildTitleColor(context),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: _buildTitleFontSize(context),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: _buildTitlePositionSegmentedControl(context),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: _buildPlayIconHidden(context),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: _buildPlayIconWidth(context),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            _buildShowAdBadge(context),
            const SizedBox(
              height: 20,
            ),
            _buildButtonList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundColor(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).backgroundColor),
        FWTextFormField(
          initialValue: _initConfig.backgroundColor,
          hintText: S.of(context).backgroundColorHint,
          validator: (text) {
            return ValidationUtil.validateColor(
              text,
              context,
            );
          },
          onSaved: (text) {
            _resultConfig.backgroundColor = text;
          },
        ),
      ],
    );
  }

  Widget _buildCornerRadius(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).cornerRadius),
        FWTextFormField(
          initialValue: _initConfig.cornerRadius?.toStringAsFixed(0),
          hintText: S.of(context).cornerRadiusHint,
          validator: (text) {
            return ValidationUtil.validateNumber(
              context: context,
              text: text,
              min: 0,
              max: 50,
              errorMessage: S.of(context).cornerRadiusError,
              rangeErrorMessage: S.of(context).cornerRadiusRangeError,
            );
          },
          onSaved: (text) {
            _resultConfig.cornerRadius = int.tryParse(text ?? '')?.toDouble();
          },
        )
      ],
    );
  }

  Widget _buildTitleHidden(BuildContext context) {
    return CheckboxListTile(
      value: _resultConfig.title?.hidden ?? false,
      onChanged: (value) {
        setState(() {
          _resultConfig.title ??= VideoFeedTitleConfiguration();
          _resultConfig.title?.hidden = value;
        });
      },
      title: Text(
        S.of(context).hideTitle,
      ),
    );
  }

  Widget _buildTitleColor(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).titleColor),
        FWTextFormField(
          initialValue: _initConfig.title?.textColor,
          hintText: S.of(context).titleColorHint,
          validator: (text) {
            return ValidationUtil.validateColor(
              text,
              context,
            );
          },
          onSaved: (text) {
            _resultConfig.title ??= VideoFeedTitleConfiguration();
            _resultConfig.title?.textColor = text;
          },
        ),
      ],
    );
  }

  Widget _buildTitleFontSize(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).titleFontSize),
        FWTextFormField(
          initialValue: _initConfig.title?.fontSize?.toStringAsFixed(0),
          hintText: S.of(context).titleFontSizeHint,
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
            _resultConfig.title ??= VideoFeedTitleConfiguration();
            _resultConfig.title?.fontSize =
                int.tryParse(text ?? '')?.toDouble();
          },
        )
      ],
    );
  }

  Widget _buildTitlePositionSegmentedControl(BuildContext context) {
    return CupertinoSegmentedControl<VideoFeedTitlePosition>(
      onValueChanged: (value) {
        setState(() {
          _resultConfig.titlePosition = value;
        });
      },
      children: {
        VideoFeedTitlePosition.nested: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            S.of(context).nested,
          ),
        ),
        VideoFeedTitlePosition.stacked: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            S.of(context).stacked,
          ),
        ),
      },
      groupValue: _resultConfig.titlePosition,
    );
  }

  Widget _buildPlayIconHidden(BuildContext context) {
    return CheckboxListTile(
      value: _resultConfig.playIcon?.hidden ?? false,
      onChanged: (value) {
        setState(() {
          _resultConfig.playIcon ??= VideoFeedPlayIconConfiguration();
          _resultConfig.playIcon?.hidden = value;
        });
      },
      title: Text(
        S.of(context).hidePlayIcon,
      ),
    );
  }

  Widget _buildPlayIconWidth(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).playIconWidth),
        FWTextFormField(
          initialValue: _initConfig.playIcon?.iconWidth?.toStringAsFixed(0),
          hintText: S.of(context).playIconWidthHint,
          validator: (text) {
            return ValidationUtil.validateNumber(
              context: context,
              text: text,
              min: 0,
              max: 100,
              errorMessage: S.of(context).playIconWidthError,
              rangeErrorMessage: S.of(context).playIconWidthRangeError,
            );
          },
          onSaved: (text) {
            _resultConfig.playIcon ??= VideoFeedPlayIconConfiguration();
            _resultConfig.playIcon?.iconWidth =
                int.tryParse(text ?? '')?.toDouble();
          },
        )
      ],
    );
  }

  Widget _buildShowAdBadge(BuildContext context) {
    return CheckboxListTile(
      value: _resultConfig.showAdBadge ?? false,
      onChanged: (value) {
        setState(() {
          _resultConfig.showAdBadge = value;
        });
      },
      title: Text(
        S.of(context).showAdBadge,
      ),
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
                        context.read<FeedConfigurationState>().reset();
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
              context.read<FeedConfigurationState>().feedConfiguration =
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
