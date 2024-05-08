import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fw_flutter_sdk_example/utils/host_app_service.dart';
import '../../generated/l10n.dart';
import '../../widgets/fw_app_bar.dart';

class EnableOnVideoPlaybackLogScreen extends StatefulWidget {
  const EnableOnVideoPlaybackLogScreen({Key? key}) : super(key: key);

  @override
  State<EnableOnVideoPlaybackLogScreen> createState() =>
      _EnableOnVideoPlaybackLogScreenState();
}

class _EnableOnVideoPlaybackLogScreenState
    extends State<EnableOnVideoPlaybackLogScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _enableOnVideoPlaybackLog = false;

  @override
  void initState() {
    super.initState();

    _enableOnVideoPlaybackLog =
        FireworkSDK.getInstance().onVideoPlayback != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fwAppBar(
        context: context,
        titleText: S.of(context).enableOnVideoPlaybackLog,
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
              _buildOnVideoPlaybackEnable(context),
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

  Widget _buildOnVideoPlaybackEnable(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _enableOnVideoPlaybackLog,
      onChanged: (value) {
        setState(() {
          _enableOnVideoPlaybackLog = value ?? false;
        });
      },
      title: Text(
        S.of(context).enableOnVideoPlaybackLog,
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
              if (_enableOnVideoPlaybackLog) {
                FireworkSDK.getInstance().onVideoPlayback =
                    HostAppService.getInstance().onVideoPlayback;
                EasyLoading.showToast(
                    S.of(context).enableOnVideoPlaybackLogSuccessfully);
              } else {
                FireworkSDK.getInstance().onVideoPlayback = null;
                EasyLoading.showToast(
                    S.of(context).disableOnVideoPlaybackLogSuccessfully);
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
