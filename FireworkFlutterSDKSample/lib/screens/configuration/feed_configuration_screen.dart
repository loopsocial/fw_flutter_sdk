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
              // Content Padding Section Header
              const Text(
                'Content Padding',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildContentPaddingTop(context),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: _buildContentPaddingRight(context),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildContentPaddingBottom(context),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: _buildContentPaddingLeft(context),
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
              _buildTitleTextAlignment(context),
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

  Widget _buildContentPaddingTop(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Padding Top'),
        FWTextFormField(
          initialValue: _initConfig.contentPadding?.top?.toStringAsFixed(0),
          hintText: 'Enter top padding (e.g., 10)',
          validator: (text) {
            return ValidationUtil.validateNumber(
              context: context,
              text: text,
              min: 0,
              max: 100,
              errorMessage: 'Invalid padding top value',
              rangeErrorMessage: 'Padding top must be between 0 and 100',
            );
          },
          onSaved: (text) {
            _resultConfig.contentPadding ??= VideoFeedPadding();
            _resultConfig.contentPadding?.top =
                int.tryParse(text ?? '')?.toDouble();
          },
        )
      ],
    );
  }

  Widget _buildContentPaddingRight(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Padding Right'),
        FWTextFormField(
          initialValue: _initConfig.contentPadding?.right?.toStringAsFixed(0),
          hintText: 'Enter right padding (e.g., 10)',
          validator: (text) {
            return ValidationUtil.validateNumber(
              context: context,
              text: text,
              min: 0,
              max: 100,
              errorMessage: 'Invalid padding right value',
              rangeErrorMessage: 'Padding right must be between 0 and 100',
            );
          },
          onSaved: (text) {
            _resultConfig.contentPadding ??= VideoFeedPadding();
            _resultConfig.contentPadding?.right =
                int.tryParse(text ?? '')?.toDouble();
          },
        )
      ],
    );
  }

  Widget _buildContentPaddingBottom(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Padding Bottom'),
        FWTextFormField(
          initialValue: _initConfig.contentPadding?.bottom?.toStringAsFixed(0),
          hintText: 'Enter bottom padding (e.g., 10)',
          validator: (text) {
            return ValidationUtil.validateNumber(
              context: context,
              text: text,
              min: 0,
              max: 100,
              errorMessage: 'Invalid padding bottom value',
              rangeErrorMessage: 'Padding bottom must be between 0 and 100',
            );
          },
          onSaved: (text) {
            _resultConfig.contentPadding ??= VideoFeedPadding();
            _resultConfig.contentPadding?.bottom =
                int.tryParse(text ?? '')?.toDouble();
          },
        )
      ],
    );
  }

  Widget _buildContentPaddingLeft(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Padding Left'),
        FWTextFormField(
          initialValue: _initConfig.contentPadding?.left?.toStringAsFixed(0),
          hintText: 'Enter left padding (e.g., 10)',
          validator: (text) {
            return ValidationUtil.validateNumber(
              context: context,
              text: text,
              min: 0,
              max: 100,
              errorMessage: 'Invalid padding left value',
              rangeErrorMessage: 'Padding left must be between 0 and 100',
            );
          },
          onSaved: (text) {
            _resultConfig.contentPadding ??= VideoFeedPadding();
            _resultConfig.contentPadding?.left =
                int.tryParse(text ?? '')?.toDouble();
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
    final fontInfo = _resultConfig.title?.iOSFontInfo;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          value: fontInfo != null,
          onChanged: (value) {
            setState(() {
              if (value == true) {
                _resultConfig.title ??= VideoFeedTitleConfiguration();
                _resultConfig.title?.iOSFontInfo = IOSFontInfo(
                  fontName: null,
                  systemFontWeight: IOSSystemFontWeight.regular,
                  systemFontStyle: IOSSystemFontStyle.normal,
                );
              } else {
                _resultConfig.title?.iOSFontInfo = null;
              }
            });
          },
          title: Text(
            S.of(context).useIOSFontInfoForTitle,
          ),
        ),
        if (fontInfo != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
            child: Row(
              children: [
                const Text('iOS font name: '),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButton<String?>(
                    isExpanded: true,
                    value: fontInfo.fontName,
                    items: const [
                      DropdownMenuItem(
                          value: null, child: Text('System Default')),
                      DropdownMenuItem(
                          value: 'TimesNewRomanPS-ItalicMT',
                          child: Text('TimesNewRomanPS-ItalicMT')),
                      DropdownMenuItem(
                          value: 'Helvetica', child: Text('Helvetica')),
                      DropdownMenuItem(
                          value: 'Helvetica-Bold',
                          child: Text('Helvetica-Bold')),
                      DropdownMenuItem(
                          value: 'Courier', child: Text('Courier')),
                      DropdownMenuItem(
                          value: 'Georgia', child: Text('Georgia')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _resultConfig.title?.iOSFontInfo = IOSFontInfo(
                          fontName: value,
                          systemFontWeight: fontInfo.systemFontWeight,
                          systemFontStyle: fontInfo.systemFontStyle,
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
            child: Row(
              children: [
                const Text('iOS weight: '),
                const SizedBox(width: 12),
                DropdownButton<IOSSystemFontWeight>(
                  value: fontInfo.systemFontWeight ??
                      IOSSystemFontWeight.regular,
                  items: const [
                    DropdownMenuItem(
                        value: IOSSystemFontWeight.ultraLight,
                        child: Text('ultraLight')),
                    DropdownMenuItem(
                        value: IOSSystemFontWeight.thin,
                        child: Text('thin')),
                    DropdownMenuItem(
                        value: IOSSystemFontWeight.light,
                        child: Text('light')),
                    DropdownMenuItem(
                        value: IOSSystemFontWeight.regular,
                        child: Text('regular')),
                    DropdownMenuItem(
                        value: IOSSystemFontWeight.medium,
                        child: Text('medium')),
                    DropdownMenuItem(
                        value: IOSSystemFontWeight.semibold,
                        child: Text('semibold')),
                    DropdownMenuItem(
                        value: IOSSystemFontWeight.bold,
                        child: Text('bold')),
                    DropdownMenuItem(
                        value: IOSSystemFontWeight.heavy,
                        child: Text('heavy')),
                    DropdownMenuItem(
                        value: IOSSystemFontWeight.black,
                        child: Text('black')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _resultConfig.title?.iOSFontInfo = IOSFontInfo(
                        fontName: fontInfo.fontName,
                        systemFontWeight: value,
                        systemFontStyle: fontInfo.systemFontStyle,
                      );
                    });
                  },
                ),
              ],
            ),
          ),
          CheckboxListTile(
            contentPadding: const EdgeInsets.only(left: 16),
            value: fontInfo.systemFontStyle == IOSSystemFontStyle.italic,
            onChanged: (value) {
              setState(() {
                _resultConfig.title?.iOSFontInfo = IOSFontInfo(
                  fontName: fontInfo.fontName,
                  systemFontWeight: fontInfo.systemFontWeight,
                  systemFontStyle: value == true
                      ? IOSSystemFontStyle.italic
                      : IOSSystemFontStyle.normal,
                );
              });
            },
            title: const Text('iOS italic style'),
          ),
        ],
      ],
    );
  }

  Widget _buildTitleUseAndroidFontInfo(BuildContext context) {
    final fontInfo = _resultConfig.title?.androidFontInfo;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          value: fontInfo != null,
          onChanged: (value) {
            setState(() {
              if (value == true) {
                _resultConfig.title ??= VideoFeedTitleConfiguration();
                _resultConfig.title?.androidFontInfo = AndroidFontInfo(
                  isCustom: false,
                  typefaceName: "DEFAULT",
                  weight: FontWeight.w400,
                  style: FontStyle.normal,
                );
              } else {
                _resultConfig.title?.androidFontInfo = null;
              }
            });
          },
          title: Text(
            S.of(context).useAndroidFontInfoForTitle,
          ),
        ),
        if (fontInfo != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
            child: Row(
              children: [
                const Text('Android typeface: '),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: fontInfo.typefaceName ?? 'DEFAULT',
                  items: const [
                    DropdownMenuItem(
                        value: 'DEFAULT', child: Text('DEFAULT')),
                    DropdownMenuItem(
                        value: 'DEFAULT_BOLD', child: Text('DEFAULT_BOLD')),
                    DropdownMenuItem(
                        value: 'SANS_SERIF', child: Text('SANS_SERIF')),
                    DropdownMenuItem(
                        value: 'SERIF', child: Text('SERIF')),
                    DropdownMenuItem(
                        value: 'MONOSPACE', child: Text('MONOSPACE')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _resultConfig.title?.androidFontInfo = AndroidFontInfo(
                        isCustom: false,
                        typefaceName: value,
                        weight: fontInfo.weight,
                        style: fontInfo.style,
                      );
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
            child: Row(
              children: [
                const Text('Android weight: '),
                const SizedBox(width: 12),
                DropdownButton<FontWeight>(
                  value: fontInfo.weight ?? FontWeight.w400,
                  items: const [
                    DropdownMenuItem(
                        value: FontWeight.w100, child: Text('w100')),
                    DropdownMenuItem(
                        value: FontWeight.w200, child: Text('w200')),
                    DropdownMenuItem(
                        value: FontWeight.w300, child: Text('w300 (light)')),
                    DropdownMenuItem(
                        value: FontWeight.w400, child: Text('w400 (normal)')),
                    DropdownMenuItem(
                        value: FontWeight.w500, child: Text('w500 (medium)')),
                    DropdownMenuItem(
                        value: FontWeight.w600, child: Text('w600')),
                    DropdownMenuItem(
                        value: FontWeight.w700, child: Text('w700 (bold)')),
                    DropdownMenuItem(
                        value: FontWeight.w800, child: Text('w800')),
                    DropdownMenuItem(
                        value: FontWeight.w900, child: Text('w900 (black)')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _resultConfig.title?.androidFontInfo = AndroidFontInfo(
                        isCustom: fontInfo.isCustom,
                        typefaceName: fontInfo.typefaceName,
                        weight: value,
                        style: fontInfo.style,
                      );
                    });
                  },
                ),
              ],
            ),
          ),
          CheckboxListTile(
            contentPadding: const EdgeInsets.only(left: 16),
            value: fontInfo.style == FontStyle.italic,
            onChanged: (value) {
              setState(() {
                _resultConfig.title?.androidFontInfo = AndroidFontInfo(
                  isCustom: fontInfo.isCustom,
                  typefaceName: fontInfo.typefaceName,
                  weight: fontInfo.weight,
                  style: value == true ? FontStyle.italic : FontStyle.normal,
                );
              });
            },
            title: const Text('Android italic style'),
          ),
        ],
      ],
    );
  }

  Widget _buildTitleTextAlignment(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Title text alignment'),
        const SizedBox(height: 8),
        CupertinoSegmentedControl<VideoFeedTitleTextAlignment>(
          onValueChanged: (value) {
            setState(() {
              _resultConfig.title ??= VideoFeedTitleConfiguration();
              _resultConfig.title?.textAlignment = value;
            });
          },
          children: const {
            VideoFeedTitleTextAlignment.left: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text('Left'),
            ),
            VideoFeedTitleTextAlignment.center: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text('Center'),
            ),
            VideoFeedTitleTextAlignment.right: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text('Right'),
            ),
          },
          groupValue: _resultConfig.title?.textAlignment,
        ),
        const SizedBox(height: 4),
        TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: _resultConfig.title?.textAlignment == null
              ? null
              : () {
                  setState(() {
                    _resultConfig.title?.textAlignment = null;
                  });
                },
          child: const Text('Clear (use SDK default)'),
        ),
      ],
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
      value: _resultConfig.replayBadge?.isHidden ?? true,
      onChanged: (value) {
        setState(() {
          _resultConfig.replayBadge ??= ReplayBadgeConfiguration(
            isHidden: true,
          );
          _resultConfig.replayBadge!.isHidden = value ?? true;
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
                if (vastAttributes == null && context.mounted) {
                  EasyLoading.showError(
                      S.of(context).vastAttributesFormatError);
                  return;
                }
                _resultAdConfig.vastAttributes = vastAttributes;
                if (context.mounted) {
                  context.read<FeedConfigurationState>().feedConfiguration =
                      _resultConfig;
                  context.read<FeedConfigurationState>().adConfiguration =
                      _resultAdConfig;
                  Navigator.of(context).pop();
                }
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
