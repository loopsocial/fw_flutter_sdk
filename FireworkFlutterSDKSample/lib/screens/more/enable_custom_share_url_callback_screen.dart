import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fw_flutter_sdk_example/utils/host_app_service.dart';
import '../../generated/l10n.dart';
import '../../widgets/fw_app_bar.dart';

class EnableCustomShareUrlCallbackScreen extends StatefulWidget {
  const EnableCustomShareUrlCallbackScreen({Key? key}) : super(key: key);

  @override
  State<EnableCustomShareUrlCallbackScreen> createState() =>
      _EnableCustomShareUrlCallbackScreenState();
}

class _EnableCustomShareUrlCallbackScreenState
    extends State<EnableCustomShareUrlCallbackScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _enableCustomShareUrlCallback = false;

  @override
  void initState() {
    super.initState();

    _enableCustomShareUrlCallback =
        FireworkSDK.getInstance().onCustomShareUrl != null;
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
              _buildCustomShareUrlCallbackEnable(context),
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

  Widget _buildCustomShareUrlCallbackEnable(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _enableCustomShareUrlCallback,
      onChanged: (value) {
        setState(() {
          _enableCustomShareUrlCallback = value ?? false;
        });
      },
      title: const Text(
        "Enable custom share url callback",
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
              if (_enableCustomShareUrlCallback) {
                FireworkSDK.getInstance().onCustomShareUrl =
                    HostAppService.getInstance().onCustomShareUrl;
                EasyLoading.showToast(
                    "Enable custom share url callback successfully.");
              } else {
                FireworkSDK.getInstance().onCustomShareUrl = null;
                EasyLoading.showToast(
                    "Disable custom share url callback successfully.");
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
