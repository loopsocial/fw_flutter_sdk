import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../../utils/validation_util.dart';
import '../../widgets/fw_app_bar.dart';
import '../../widgets/fw_text_form_field.dart';

class HashtagPlaylistConfigurationScreen extends StatefulWidget {
  const HashtagPlaylistConfigurationScreen({Key? key}) : super(key: key);

  @override
  State<HashtagPlaylistConfigurationScreen> createState() =>
      _HashtagPlaylistConfigurationScreenState();
}

class _HashtagPlaylistConfigurationScreenState
    extends State<HashtagPlaylistConfigurationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _channelId = "";
  String _hashtagFilterExpression = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fwAppBar(
        context: context,
        titleText: S.of(context).hashtagPlaylistInfo,
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
            _buildChannelId(context),
            const SizedBox(
              height: 20,
            ),
            _buildHashtagFilterExpression(context),
            const SizedBox(
              height: 20,
            ),
            _buildButtonList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildChannelId(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).channelId),
        FWTextFormField(
          hintText: S.of(context).channelIdHint,
          validator: (text) {
            return ValidationUtil.validId(
              text: text,
              errorMessage: S.of(context).channelIdError,
              requiredError: S.of(context).channelIdRequiredError,
            );
          },
          onSaved: (text) {
            _channelId = text ?? "";
          },
        )
      ],
    );
  }

  Widget _buildHashtagFilterExpression(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).hashtagFilterExpression),
        FWTextFormField(
          hintText: S.of(context).hashtagFilterExpressionHint,
          validator: (text) {
            if ((text ?? '').isEmpty) {
              return S.of(context).hashtagFilterExpressionRequiredError;
            }
            return null;
          },
          onSaved: (text) {
            _hashtagFilterExpression = text ?? "";
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
              Navigator.of(context).pop(<String, String>{
                "channelId": _channelId,
                "hashtagFilterExpression": _hashtagFilterExpression,
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
