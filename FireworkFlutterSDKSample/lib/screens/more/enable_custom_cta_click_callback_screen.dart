import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../generated/l10n.dart';
import '../../my_app.dart';
import '../../widgets/fw_app_bar.dart';

class EnableCustomCTAClickCallbackScreen extends StatefulWidget {
  const EnableCustomCTAClickCallbackScreen({Key? key}) : super(key: key);

  @override
  _EnableCustomCTAClickCallbackScreenState createState() =>
      _EnableCustomCTAClickCallbackScreenState();
}

class _EnableCustomCTAClickCallbackScreenState
    extends State<EnableCustomCTAClickCallbackScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _enableCustomCTAClickCallback = false;

  @override
  void initState() {
    super.initState();

    _enableCustomCTAClickCallback =
        FireworkSDK.getInstance().onCustomCTAClick != null;
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
              _buildCustomCTAClickCallbackEnable(context),
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

  Widget _buildCustomCTAClickCallbackEnable(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _enableCustomCTAClickCallback,
      onChanged: (value) {
        setState(() {
          _enableCustomCTAClickCallback = value ?? false;
        });
      },
      title: Text(
        S.of(context).enableCustomCTAClickCallback,
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
              if (_enableCustomCTAClickCallback) {
                FireworkSDK.getInstance().onCustomCTAClick = (event) {
                  final url = event?.url;
                  if (url != null) {
                    FireworkSDK.getInstance().navigator.popNativeContainer();
                    globalNavigatorKey.currentState
                        ?.pushNamed('/cta_link_content', arguments: {
                      "url": url,
                    });
                  }
                };
                EasyLoading.showToast(
                    S.of(context).enableCustomCTAClickCallbackSuccessfully);
              } else {
                FireworkSDK.getInstance().onCustomCTAClick = null;
                EasyLoading.showToast(
                    S.of(context).disableCustomCTAClickCallbackSuccessfully);
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
