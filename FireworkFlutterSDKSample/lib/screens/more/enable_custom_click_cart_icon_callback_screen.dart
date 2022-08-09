import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fw_flutter_sdk_example/my_app.dart';
import '../../generated/l10n.dart';
import '../../widgets/fw_app_bar.dart';

class EnableCustomClickCartIconCallbackScreen extends StatefulWidget {
  const EnableCustomClickCartIconCallbackScreen({Key? key}) : super(key: key);

  @override
  State<EnableCustomClickCartIconCallbackScreen> createState() =>
      _EnableCustomClickCartIconCallbackScreenState();
}

class _EnableCustomClickCartIconCallbackScreenState
    extends State<EnableCustomClickCartIconCallbackScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _enableCustomClickCartIconCallback = false;

  @override
  void initState() {
    super.initState();

    _enableCustomClickCartIconCallback =
        FireworkSDK.getInstance().shopping.onCustomClickCartIcon != null;
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
              _buildCustomClickCartIconEnable(context),
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

  Widget _buildCustomClickCartIconEnable(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _enableCustomClickCartIconCallback,
      onChanged: (value) {
        setState(() {
          _enableCustomClickCartIconCallback = value ?? false;
        });
      },
      title: Text(
        S.of(context).enableCustomClickCartIconCallback,
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
              if (_enableCustomClickCartIconCallback) {
                FireworkSDK.getInstance().shopping.onCustomClickCartIcon =
                    () async {
                  FireworkSDK.getInstance().navigator.popNativeContainer();
                  globalNavigatorKey.currentState?.pushNamed('/cart');
                };
                EasyLoading.showToast(S
                    .of(context)
                    .enableCustomClickCartIconCallbackSuccessfully);
              } else {
                FireworkSDK.getInstance().shopping.onCustomClickCartIcon = null;
                EasyLoading.showToast(S
                    .of(context)
                    .disableCustomClickCartIconCallbackSuccessfully);
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
