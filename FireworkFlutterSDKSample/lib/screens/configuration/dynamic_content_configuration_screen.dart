import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fw_flutter_sdk_example/utils/fw_example_logger_util.dart';
import '../../generated/l10n.dart';
import '../../utils/validation_util.dart';
import '../../widgets/fw_app_bar.dart';
import '../../widgets/fw_text_form_field.dart';

class DynamicContentConfigurationScreen extends StatefulWidget {
  const DynamicContentConfigurationScreen({Key? key}) : super(key: key);

  @override
  _DynamicContentConfigurationScreenState createState() =>
      _DynamicContentConfigurationScreenState();
}

class _DynamicContentConfigurationScreenState
    extends State<DynamicContentConfigurationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _channelId = "";
  String _dynamicContentParametersString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fwAppBar(
        context: context,
        titleText: S.of(context).dynamicContentInfo,
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
            _buildChannelId(context),
            const SizedBox(
              height: 20,
            ),
            _buildDynamicContentParameters(context),
            const SizedBox(
              height: 20,
            ),
            _buildButtonList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildChannelId(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).channelId),
        FWTextFormField(
          hintText: S.of(context).channelIdHint,
          validator: (text) {
            return ValidationUtil.validId(
              text: text,
              errorMessage: S.of(context).channelIdError,
              requiredError: S.of(context).channelIdRequiredError,
            );
          },
          onSaved: (text) {
            _channelId = text ?? "";
          },
        )
      ],
    );
  }

  Widget _buildDynamicContentParameters(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).dynamicContentParameters),
        FWTextFormField(
          hintText: S.of(context).dynamicContentParametersHint,
          minLines: 5,
          maxLines: 5,
          validator: (text) {
            if ((text ?? "").isEmpty) {
              return S.of(context).dynamicContentParametersRequiredError;
            }

            return null;
          },
          onSaved: (text) {
            _dynamicContentParametersString = text ?? "";
          },
        )
      ],
    );
  }

  Future<Map<String, List<String>>?>
      _parseDynamicContentParametersString() async {
    try {
      final jsonData = await json.decode(_dynamicContentParametersString);
      FWExampleLoggerUtil.log(
          "_parseDynamicContentParametersString jsonData: $jsonData ${jsonData.runtimeType}");
      if (jsonData is Map<String, dynamic>) {
        final tmpParameters = Map<String, List<dynamic>>.from(jsonData);
        var resultParameters = <String, List<String>>{};

        tmpParameters.forEach((key, value) {
          resultParameters[key] = List<String>.from(value);
        });

        return resultParameters;
      }
    } catch (e) {
      FWExampleLoggerUtil.log("_parseDynamicContentParametersString error: $e");
    }

    return null;
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
              _parseDynamicContentParametersString()
                  .then((dynamicContentParameters) {
                if (dynamicContentParameters == null) {
                  EasyLoading.showError(
                      S.of(context).dynamicContentParametersFormatError);
                  return;
                }
                FWExampleLoggerUtil.log(
                    "dynamicContentParameters $dynamicContentParameters");
                Navigator.of(context).pop(<String, dynamic>{
                  "dynamicContentParameters": dynamicContentParameters,
                  "channelId": _channelId,
                });
              });
            }
          },
          child: Text(
            S.of(context).use,
          ),
        ),
      ),
    ]);
  }
}
