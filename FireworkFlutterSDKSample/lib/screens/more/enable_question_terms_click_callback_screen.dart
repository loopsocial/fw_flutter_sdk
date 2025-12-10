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
  bool _enableQuestionTermsClickCallback = false;

  @override
  void initState() {
    super.initState();

    _enableQuestionTermsClickCallback = FireworkSDK.getInstance()
            .liveStream
            .onCustomQuestionTermsAndConditionsClick !=
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
              _buildQuestionTermsClickCallbackEnable(context),
              const SizedBox(
                height: 20,
              ),
              _buildActionButtonList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionTermsClickCallbackEnable(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _enableQuestionTermsClickCallback,
      onChanged: (value) {
        setState(() {
          _enableQuestionTermsClickCallback = value ?? false;
        });
      },
      title: const Text(
        "Enable question terms and conditions click callback",
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
              if (_enableQuestionTermsClickCallback) {
                FireworkSDK.getInstance()
                        .liveStream
                        .onCustomQuestionTermsAndConditionsClick =
                    HostAppService.getInstance()
                        .onCustomQuestionTermsAndConditionsClick;
                EasyLoading.showToast(
                    "Enable question terms and conditions click callback successfully.");
              } else {
                FireworkSDK.getInstance()
                    .liveStream
                    .onCustomQuestionTermsAndConditionsClick = null;
                EasyLoading.showToast(
                    "Disable question terms and conditions click callback successfully.");
              }
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

