import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/states/player_configuration_state.dart';
import 'package:fw_flutter_sdk_example/utils/fw_example_logger_util.dart';
import 'package:fw_flutter_sdk_example/widgets/fw_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../generated/l10n.dart';
import '../../utils/validation_util.dart';
import '../../widgets/fw_app_bar.dart';

class OpenVideoScreen extends StatefulWidget {
  const OpenVideoScreen({Key? key}) : super(key: key);

  @override
  State<OpenVideoScreen> createState() => _OpenVideoScreenState();
}

class _OpenVideoScreenState extends State<OpenVideoScreen> {
  final _formKey = GlobalKey<FormState>();
  String _url = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: fwAppBar(
          context: context,
          titleText: S.of(context).openVideoURL,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: _buildBody(context),
        ),
      ),
      onWillPop: () async {
        context.read<PlayerConfigurationState>().reset();
        FWExampleLoggerUtil.log("_OpenVideoScreenState will pop");
        return true;
      },
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
              _buildURL(context),
              const SizedBox(
                height: 20,
              ),
              _buildConfigButton(context),
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

  Widget _buildURL(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).videoURL),
        FWTextFormField(
          hintText: S.of(context).urlHint,
          validator: (text) {
            return ValidationUtil.validURL(
              text: text,
              errorMessage: S.of(context).urlError,
              requiredError: S.of(context).urlRequiredError,
            );
          },
          onSaved: (text) {
            _url = text ?? "";
          },
        )
      ],
    );
  }

  Widget _buildConfigButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamed("/player_configuration");
      },
      child: Text(
        S.of(context).playerConfiguration,
      ),
    );
  }

  Widget _buildActionButtonList(BuildContext context) {
    return Row(children: [
      Expanded(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).maybePop();
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
            FocusScope.of(context).unfocus();

            if (_formKey.currentState != null &&
                _formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final config =
                  context.read<PlayerConfigurationState>().playerConfiguration;
              FireworkSDK.getInstance().openVideoPlayer(
                url: _url,
                config: config,
              );
            }
          },
          child: Text(
            S.of(context).open,
          ),
        ),
      ),
    ]);
  }
}
