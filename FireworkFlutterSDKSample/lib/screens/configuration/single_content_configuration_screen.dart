import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../../utils/validation_util.dart';
import '../../widgets/fw_app_bar.dart';
import '../../widgets/fw_text_form_field.dart';

class SingleContentConfigurationScreen extends StatefulWidget {
  const SingleContentConfigurationScreen({Key? key}) : super(key: key);

  @override
  State<SingleContentConfigurationScreen> createState() =>
      _SingleContentConfigurationScreenState();
}

class _SingleContentConfigurationScreenState
    extends State<SingleContentConfigurationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _contentId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fwAppBar(
        context: context,
        titleText: S.of(context).singleContentFeedInfo,
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
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildContentId(context),
            const SizedBox(
              height: 20,
            ),
            _buildButtonList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildContentId(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).contentId),
        FWTextFormField(
          hintText: S.of(context).contentIdHint,
          validator: (text) {
            return ValidationUtil.validId(
              text: text,
              errorMessage: S.of(context).contentIdError,
              requiredError: S.of(context).contentIdRequiredError,
            );
          },
          onSaved: (text) {
            _contentId = text ?? "";
          },
        )
      ],
    );
  }

  Widget _buildButtonList(BuildContext context) {
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
              Navigator.of(context).pop(<String, dynamic>{
                "contentId": _contentId,
              });
            }
          },
          child: Text(
            S.of(context).use,
          ),
        ),
      ),
    ]);
  }
}
