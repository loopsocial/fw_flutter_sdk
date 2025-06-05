import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fw_flutter_sdk_example/utils/host_app_service.dart';
import '../../generated/l10n.dart';
import '../../widgets/fw_app_bar.dart';

class EnableGiveawayTermsClickCallbackScreen extends StatefulWidget {
  const EnableGiveawayTermsClickCallbackScreen({Key? key}) : super(key: key);

  @override
  State<EnableGiveawayTermsClickCallbackScreen> createState() =>
      _EnableGiveawayTermsClickCallbackScreenState();
}

class _EnableGiveawayTermsClickCallbackScreenState
    extends State<EnableGiveawayTermsClickCallbackScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _enableGiveawayTermsClickCallback = false;

  @override
  void initState() {
    super.initState();

    _enableGiveawayTermsClickCallback = FireworkSDK.getInstance()
            .liveStream
            .onCustomGiveawayTermsAndConditionsClick !=
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
              _buildGiveawayTermsClickCallbackEnable(context),
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

  Widget _buildGiveawayTermsClickCallbackEnable(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _enableGiveawayTermsClickCallback,
      onChanged: (value) {
        setState(() {
          _enableGiveawayTermsClickCallback = value ?? false;
        });
      },
      title: const Text(
        "Enable giveaway terms and conditions click callback",
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
              if (_enableGiveawayTermsClickCallback) {
                FireworkSDK.getInstance()
                        .liveStream
                        .onCustomGiveawayTermsAndConditionsClick =
                    HostAppService.getInstance()
                        .onCustomGiveawayTermsAndConditionsClick;
                EasyLoading.showToast(
                    "Enable giveaway terms and conditions click callback successfully.");
              } else {
                FireworkSDK.getInstance()
                    .liveStream
                    .onCustomGiveawayTermsAndConditionsClick = null;
                EasyLoading.showToast(
                    "Disable giveaway terms and conditions click callback successfully.");
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
