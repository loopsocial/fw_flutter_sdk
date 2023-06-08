import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../../utils/validation_util.dart';
import '../../widgets/fw_app_bar.dart';
import '../../widgets/fw_text_form_field.dart';

class PlaylistGroupConfigurationScreen extends StatefulWidget {
  const PlaylistGroupConfigurationScreen({Key? key}) : super(key: key);

  @override
  State<PlaylistGroupConfigurationScreen> createState() =>
      _PlaylistGroupConfigurationScreenState();
}

class _PlaylistGroupConfigurationScreenState
    extends State<PlaylistGroupConfigurationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _playlistGroupId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fwAppBar(
        context: context,
        titleText: S.of(context).playlistGroupInfo,
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
            _buildPlaylistGroupId(context),
            const SizedBox(
              height: 20,
            ),
            _buildButtonList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaylistGroupId(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).playlistGroupId),
        FWTextFormField(
          hintText: S.of(context).playlistGroupIdHint,
          validator: (text) {
            return ValidationUtil.validId(
              text: text,
              errorMessage: S.of(context).playlistGroupIdError,
              requiredError: S.of(context).playlistGroupIdRequiredError,
            );
          },
          onSaved: (text) {
            _playlistGroupId = text ?? "";
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
              Navigator.of(context).pop(_playlistGroupId);
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
