import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../generated/l10n.dart';
import '../../widgets/fw_app_bar.dart';

class EnableCustomShareUrlScreen extends StatefulWidget {
  const EnableCustomShareUrlScreen({Key? key}) : super(key: key);

  @override
  State<EnableCustomShareUrlScreen> createState() =>
      _EnableCustomShareUrlScreenState();
}

class _EnableCustomShareUrlScreenState
    extends State<EnableCustomShareUrlScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _enableCustomShareUrl = false;

  @override
  void initState() {
    super.initState();

    _enableCustomShareUrl = FireworkSDK.getInstance().customShareUrl != null;
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
      value: _enableCustomShareUrl,
      onChanged: (value) {
        setState(() {
          _enableCustomShareUrl = value ?? false;
        });
      },
      title: const Text(
        "Enable custom share url",
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
              if (_enableCustomShareUrl) {
                FireworkSDK.getInstance().customShareUrl =
                    "https://example.com?a=b&link=${FWUrlUtil.getShareUrlPlaceholderValue(ShareUrlPlaceholder.encodedOriginalUrl)}&id=${FWUrlUtil.getShareUrlPlaceholderValue(ShareUrlPlaceholder.videoId)}";
                EasyLoading.showToast("Enable custom share url successfully.");
              } else {
                FireworkSDK.getInstance().customShareUrl = null;
                EasyLoading.showToast("Disable custom share url successfully.");
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
