import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../generated/l10n.dart';
import '../../utils/validation_util.dart';
import '../../widgets/fw_app_bar.dart';
import '../../widgets/fw_text_form_field.dart';

class SetShareBaseURLScreen extends StatefulWidget {
  const SetShareBaseURLScreen({Key? key}) : super(key: key);

  @override
  _SetShareBaseURLScreenState createState() => _SetShareBaseURLScreenState();
}

class _SetShareBaseURLScreenState extends State<SetShareBaseURLScreen> {
  final _formKey = GlobalKey<FormState>();
  String _url = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fwAppBar(
        context: context,
        titleText: S.of(context).setShareBaseURL,
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
              _buildURL(context),
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
    final currentShareBaseURL = FireworkSDK.getInstance().shareBaseURL;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).setShareBaseURL),
        const SizedBox(
          height: 10,
        ),
        Text(
          S.of(context).currentShareBaseURLTip(currentShareBaseURL ?? ''),
        ),
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

              FireworkSDK.getInstance().shareBaseURL = _url;
              setState(() {});
              Navigator.of(context).pop();
              EasyLoading.showToast(S.of(context).setShareBaseURLSuccessfully);
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
