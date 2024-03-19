import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/states/feed_configuration_state.dart';
import 'package:fw_flutter_sdk_example/utils/validation_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../utils/fw_example_logger_util.dart';
import '../../widgets/fw_app_bar.dart';
import '../../widgets/fw_text_form_field.dart';

class FeedConfigurationScreen extends StatefulWidget {
  const FeedConfigurationScreen({Key? key}) : super(key: key);

  @override
  State<FeedConfigurationScreen> createState() =>
      _FeedConfigurationScreenState();
}

class _FeedConfigurationScreenState extends State<FeedConfigurationScreen> {
  final _formKey = GlobalKey<FormState>();
  VideoFeedConfiguration _initConfig = VideoFeedConfiguration();
  VideoFeedConfiguration _resultConfig = VideoFeedConfiguration();
  AdConfiguration _initAdConfig = AdConfiguration();
  AdConfiguration _resultAdConfig = AdConfiguration();
  String _initVastAttributesString = "";
  String _vastAttributesString = "";

  @override
  void initState() {
    super.initState();
    _initConfig = context.read<FeedConfigurationState>().feedConfiguration;
    _resultConfig = _initConfig.deepCopy();

    _initAdConfig = context.read<FeedConfigurationState>().adConfiguration;
    _resultAdConfig = _initAdConfig.deepCopy();

    if (_initAdConfig.vastAttributes != null) {
      final vastAttributes = _initAdConfig.vastAttributes!;
      Map<String, dynamic> vastAttributesJson = {};
      for (var element in vastAttributes) {
        if (element.name != null && element.value != null) {
          vastAttributesJson[element.name!] = element.value!;
        }
      }
      if (vastAttributesJson.isNotEmpty) {
        try {
          final vastAttributesString = json.encode(vastAttributesJson);
          if (vastAttributesString.isNotEmpty) {
            _initVastAttributesString = vastAttributesString;
            _vastAttributesString = vastAttributesString;
          }
        } catch (_) {}
      }
    }
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildShadowOpacity(context),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: _buildShadowColor(context),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildShadowWidth(context),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: _buildShadowHeight(context),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
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
              _buildTitleNumberOfLines(context),
              const SizedBox(
                height: 20,
              ),
              _buildTitleUseIOSFontInfo(context),
              const SizedBox(
                height: 20,
              ),
              _buildTitleUseAndroidFontInfo(context),
              const SizedBox(
                height: 20,
              ),
              _buildTitleGradientDrawable(context),
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
              _buildGridColumns(context),
              const SizedBox(
                height: 20,
              ),
              _buildShowAdBadge(context),
              const SizedBox(
                height: 20,
              ),
              _buildHideReplayBadge(context),
              const SizedBox(
                height: 20,
              ),
              _buildEnableAutoplay(context),
              const SizedBox(
                height: 20,
              ),
              _buildRequiresAds(context),
              const SizedBox(
                height: 20,
              ),
              _buildVastAttributes(context),
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
          hintText: S.of(context).titleFontSizeHint1,
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

  Widget _buildTitleNumberOfLines(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).numberOfTitleLines),
        FWTextFormField(
          initialValue: _initConfig.title?.numberOfLines?.toStringAsFixed(0),
          hintText: S.of(context).numberOfTitleLinesHint,
          validator: (text) {
            return ValidationUtil.validateNumber(
              context: context,
              text: text,
              min: 1,
              max: 5,
              errorMessage: S.of(context).numberOfTitleLinesError,
              rangeErrorMessage: S.of(context).numberOfTitleLinesRangeError,
            );
          },
          onSaved: (text) {
            _resultConfig.title ??= VideoFeedTitleConfiguration();
            _resultConfig.title?.numberOfLines =
                int.tryParse(text ?? '')?.toInt();
          },
        )
      ],
    );
  }

  Widget _buildTitleUseIOSFontInfo(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultConfig.title?.iOSFontInfo != null,
      onChanged: (value) {
        setState(() {
          if (value == true) {
            _resultConfig.title ??= VideoFeedTitleConfiguration();
            _resultConfig.title?.iOSFontInfo = IOSFontInfo(
              fontName: "TimesNewRomanPS-ItalicMT",
            );
          } else {
            _resultConfig.title?.iOSFontInfo = null;
          }
        });
      },
      title: Text(
        S.of(context).useIOSFontInfoForTitle,
      ),
    );
  }

  Widget _buildTitleUseAndroidFontInfo(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultConfig.title?.androidFontInfo != null,
      onChanged: (value) {
        setState(() {
          if (value == true) {
            _resultConfig.title ??= VideoFeedTitleConfiguration();
            _resultConfig.title?.androidFontInfo = AndroidFontInfo(
              isCustom: false,
              typefaceName: "DEFAULT_BOLD",
            );
          } else {
            _resultConfig.title?.androidFontInfo = null;
          }
        });
      },
      title: Text(
        S.of(context).useAndroidFontInfoForTitle,
      ),
    );
  }

  Widget _buildTitleGradientDrawable(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultConfig.title?.gradientDrawable != null,
      onChanged: (value) {
        setState(() {
          if (value == true) {
            _resultConfig.title ??= VideoFeedTitleConfiguration();
            _resultConfig.title?.gradientDrawable = GradientDrawable(
              orientation: GradientDrawableOrientation.rightLeft,
              colors: <String>[
                "#FF48C9B0",
                "#FFD98880",
                "#FFF4D03F",
              ],
            );
          } else {
            _resultConfig.title?.gradientDrawable = null;
          }
        });
      },
      title: Text(
        S.of(context).useAndroidGradientDrawableForTitle,
      ),
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

  Widget _buildGridColumns(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).gridColumns),
        FWTextFormField(
          initialValue: _initConfig.gridColumns?.toStringAsFixed(0),
          hintText: S.of(context).gridColumnsHint,
          validator: (text) {
            return ValidationUtil.validateNumber(
              context: context,
              text: text,
              min: 2,
              max: 8,
              errorMessage: S.of(context).gridColumnsError,
              rangeErrorMessage: S.of(context).gridColumnsRangeError,
            );
          },
          onSaved: (text) {
            _resultConfig.gridColumns = int.tryParse(text ?? '')?.toInt();
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

  Widget _buildHideReplayBadge(BuildContext context) {
    return CheckboxListTile(
      value: _resultConfig.replayBadge?.isHidden ?? false,
      onChanged: (value) {
        setState(() {
          _resultConfig.replayBadge ??= ReplayBadgeConfiguration(
            isHidden: false,
          );
          _resultConfig.replayBadge!.isHidden = value ?? false;
        });
      },
      title: Text(
        S.of(context).hideReplayBadge,
      ),
    );
  }

  Widget _buildEnableAutoplay(BuildContext context) {
    return CheckboxListTile(
      value: _resultConfig.enableAutoplay ?? false,
      onChanged: (value) {
        setState(() {
          _resultConfig.enableAutoplay = value;
        });
      },
      title: Text(
        S.of(context).enableAutoplay,
      ),
    );
  }

  Widget _buildRequiresAds(BuildContext context) {
    return CheckboxListTile(
      value: _resultAdConfig.requiresAds ?? false,
      onChanged: (value) {
        setState(() {
          _resultAdConfig.requiresAds = value;
        });
      },
      title: Text(
        S.of(context).requiresAds,
      ),
    );
  }

  Widget _buildVastAttributes(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).vastAttributes),
        FWTextFormField(
          initialValue: _initVastAttributesString,
          hintText: S.of(context).vastAttributesHint,
          minLines: 5,
          maxLines: 5,
          onSaved: (text) {
            _vastAttributesString = text ?? "";
          },
        )
      ],
    );
  }

  Future<List<VastAttribute>?> _parseVastAttributesString() async {
    if (_vastAttributesString.isEmpty) {
      return [];
    }
    try {
      final jsonData = await json.decode(_vastAttributesString);
      FWExampleLoggerUtil.log(
          "_parseVastAttributesString jsonData: $jsonData ${jsonData.runtimeType}");
      final vastAttributeListJson = jsonData as Map<String, dynamic>;
      List<VastAttribute> vastAttributeList = [];
      vastAttributeListJson.forEach((key, value) {
        if (value is String) {
          vastAttributeList.add(VastAttribute(
            name: key,
            value: value,
          ));
        }
      });
      return vastAttributeList;
    } catch (e) {
      FWExampleLoggerUtil.log("_parseVastAttributesString error: $e");
    }

    return null;
  }

  Widget _buildShadowOpacity(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).shadowOpacity),
        FWTextFormField(
          initialValue: _initConfig.shadow?.opacity?.toString(),
          hintText: S.of(context).shadowOpacityHint,
          validator: (text) {
            return ValidationUtil.validateDoubleNumber(
              context: context,
              text: text,
              min: 0,
              max: 1,
              errorMessage: S.of(context).shadowOpacityError,
              rangeErrorMessage: S.of(context).shadowOpacityRangeError,
            );
          },
          onSaved: (text) {
            _resultConfig.shadow ??= VideoFeedShadowConfiguration();
            _resultConfig.shadow?.opacity = double.tryParse(text ?? '');
          },
        )
      ],
    );
  }

  Widget _buildShadowColor(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).shadowColor),
        FWTextFormField(
          initialValue: _initConfig.shadow?.color,
          hintText: S.of(context).shadowColorHint,
          validator: (text) {
            return ValidationUtil.validateColor(
              text,
              context,
            );
          },
          onSaved: (text) {
            _resultConfig.shadow ??= VideoFeedShadowConfiguration();
            _resultConfig.shadow?.color = text;
          },
        ),
      ],
    );
  }

  Widget _buildShadowWidth(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).shadowWidth),
        FWTextFormField(
          initialValue: _initConfig.shadow?.width?.toStringAsFixed(0),
          hintText: S.of(context).shadowWidthHint,
          validator: (text) {
            return ValidationUtil.validateNumber(
              context: context,
              text: text,
              min: 0,
              max: 100,
              errorMessage: S.of(context).shadowWidthError,
              rangeErrorMessage: S.of(context).shadowWidthRangeError,
            );
          },
          onSaved: (text) {
            _resultConfig.shadow ??= VideoFeedShadowConfiguration();
            _resultConfig.shadow?.width = int.tryParse(text ?? '')?.toDouble();
          },
        )
      ],
    );
  }

  Widget _buildShadowHeight(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).shadowHeight),
        FWTextFormField(
          initialValue: _initConfig.shadow?.height?.toStringAsFixed(0),
          hintText: S.of(context).shadowHeightHint,
          validator: (text) {
            return ValidationUtil.validateNumber(
              context: context,
              text: text,
              min: 0,
              max: 100,
              errorMessage: S.of(context).shadowHeightError,
              rangeErrorMessage: S.of(context).shadowHeightRangeError,
            );
          },
          onSaved: (text) {
            _resultConfig.shadow ??= VideoFeedShadowConfiguration();
            _resultConfig.shadow?.height = int.tryParse(text ?? '')?.toDouble();
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
              _parseVastAttributesString().then((vastAttributes) {
                if (vastAttributes == null) {
                  EasyLoading.showError(
                      S.of(context).vastAttributesFormatError);
                  return;
                }
                _resultAdConfig.vastAttributes = vastAttributes;
                context.read<FeedConfigurationState>().feedConfiguration =
                    _resultConfig;
                context.read<FeedConfigurationState>().adConfiguration =
                    _resultAdConfig;
                Navigator.of(context).pop();
              });
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
