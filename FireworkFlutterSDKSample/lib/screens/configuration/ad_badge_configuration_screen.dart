import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/utils/validation_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../generated/l10n.dart';
import '../../widgets/fw_app_bar.dart';
import '../../widgets/fw_text_form_field.dart';

class AdBadgeConfigurationScreen extends StatefulWidget {
  const AdBadgeConfigurationScreen({Key? key}) : super(key: key);

  @override
  State<AdBadgeConfigurationScreen> createState() =>
      _AdBadgeConfigurationScreenState();
}

class _AdBadgeConfigurationScreenState
    extends State<AdBadgeConfigurationScreen> {
  final _formKey = GlobalKey<FormState>();
  AdBadgeConfiguration _initConfig = AdBadgeConfiguration();
  final _resultConfig = AdBadgeConfiguration();

  @override
  void initState() {
    super.initState();
    if (FireworkSDK.getInstance().adBadgeConfiguration != null) {
      _initConfig = FireworkSDK.getInstance().adBadgeConfiguration!;
    }

    _resultConfig.badgeTextType = _initConfig.badgeTextType;
    _resultConfig.backgroundColor = _initConfig.backgroundColor;
    _resultConfig.textColor = _initConfig.textColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fwAppBar(
        context: context,
        titleText: S.of(context).setAdBadgeConfiguration,
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
            _buildBackgroundColor(context),
            const SizedBox(
              height: 20,
            ),
            _buildTextColor(context),
            const SizedBox(
              height: 20,
            ),
            _buildBadgeTextTypeSegmentedControl(context),
            const SizedBox(
              height: 20,
            ),
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

  Widget _buildTextColor(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).titleColor),
        FWTextFormField(
          initialValue: _initConfig.textColor,
          hintText: S.of(context).titleColorHint,
          validator: (text) {
            return ValidationUtil.validateColor(
              text,
              context,
            );
          },
          onSaved: (text) {
            _resultConfig.textColor = text;
          },
        ),
      ],
    );
  }

  Widget _buildBadgeTextTypeSegmentedControl(BuildContext context) {
    return CupertinoSegmentedControl<AdBadgeTextType>(
      onValueChanged: (value) {
        setState(() {
          _resultConfig.badgeTextType = value;
        });
      },
      children: {
        AdBadgeTextType.ad: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            S.of(context).ad,
          ),
        ),
        AdBadgeTextType.sponsored: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            S.of(context).sponsored,
          ),
        ),
      },
      groupValue: _resultConfig.badgeTextType,
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
          onPressed: () {
            if (_formKey.currentState != null &&
                _formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              FireworkSDK.getInstance().adBadgeConfiguration = _resultConfig;
              Navigator.of(context).pop();
              EasyLoading.showToast(
                  S.of(context).setAdBadgeConfigurationSuccessfully);
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
