import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fw_flutter_sdk_example/utils/host_app_service.dart';
import '../../generated/l10n.dart';
import '../../widgets/fw_app_bar.dart';

class EnableQuestionTermsClickCallbackScreen extends StatefulWidget {
  const EnableQuestionTermsClickCallbackScreen({Key? key}) : super(key: key);

  @override
  State<EnableQuestionTermsClickCallbackScreen> createState() =>
      _EnableQuestionTermsClickCallbackScreenState();
}

class _EnableQuestionTermsClickCallbackScreenState
    extends State<EnableQuestionTermsClickCallbackScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _enableLivestreamQuestionTermsClickCallback = false;
  bool _enableVideoQuestionTermsClickCallback = false;

  @override
  void initState() {
    super.initState();

    _enableLivestreamQuestionTermsClickCallback = FireworkSDK.getInstance()
            .liveStream
            .onCustomQuestionTermsAndConditionsClick !=
        null;
    _enableVideoQuestionTermsClickCallback = FireworkSDK.getInstance()
            .onCustomVideoQuestionTermsAndConditionsClick !=
        null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fwAppBar(
        context: context,
        titleText: '',
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
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildLivestreamQuestionTermsClickCallbackEnable(context),
              const SizedBox(height: 10),
              _buildVideoQuestionTermsClickCallbackEnable(context),
              const SizedBox(height: 20),
              _buildActionButtonList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLivestreamQuestionTermsClickCallbackEnable(
      BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _enableLivestreamQuestionTermsClickCallback,
      onChanged: (value) {
        setState(() {
          _enableLivestreamQuestionTermsClickCallback = value ?? false;
        });
      },
      title: const Text(
        "Enable livestream question terms and conditions click callback",
      ),
    );
  }

  Widget _buildVideoQuestionTermsClickCallbackEnable(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _enableVideoQuestionTermsClickCallback,
      onChanged: (value) {
        setState(() {
          _enableVideoQuestionTermsClickCallback = value ?? false;
        });
      },
      title: const Text(
        "Enable video question terms and conditions click callback",
      ),
    );
  }

  Widget _buildActionButtonList(BuildContext context) {
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

              if (_enableLivestreamQuestionTermsClickCallback) {
                FireworkSDK.getInstance()
                        .liveStream
                        .onCustomQuestionTermsAndConditionsClick =
                    HostAppService.getInstance()
                        .onCustomQuestionTermsAndConditionsClick;
              } else {
                FireworkSDK.getInstance()
                    .liveStream
                    .onCustomQuestionTermsAndConditionsClick = null;
              }

              if (_enableVideoQuestionTermsClickCallback) {
                FireworkSDK.getInstance()
                        .onCustomVideoQuestionTermsAndConditionsClick =
                    HostAppService.getInstance()
                        .onCustomVideoQuestionTermsAndConditionsClick;
              } else {
                FireworkSDK.getInstance()
                    .onCustomVideoQuestionTermsAndConditionsClick = null;
              }

              EasyLoading.showToast(
                  "Question terms and conditions click callback settings saved successfully.");
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
