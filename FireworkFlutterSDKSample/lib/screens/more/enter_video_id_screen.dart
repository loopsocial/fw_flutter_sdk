import 'package:flutter/material.dart';
import 'package:fw_flutter_sdk_example/widgets/fw_app_bar.dart';
import 'package:fw_flutter_sdk_example/widgets/fw_text_form_field.dart';
import '../../generated/l10n.dart';

class EnterVideoIdScreen extends StatefulWidget {
  const EnterVideoIdScreen({Key? key}) : super(key: key);

  @override
  State<EnterVideoIdScreen> createState() => _EnterVideoIdScreenState();
}

class _EnterVideoIdScreenState extends State<EnterVideoIdScreen> {
  final _formKey = GlobalKey<FormState>();
  String _videoId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fwAppBar(
        context: context,
        titleText: 'Enter Video ID',
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
              _buildVideoIdInput(context),
              const SizedBox(height: 20),
              _buildActionButtonList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoIdInput(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Video ID'),
        const SizedBox(height: 10),
        const Text(
          'Please enter a video ID to display the StoryBlock component',
          style: TextStyle(color: Colors.grey),
        ),
        FWTextFormField(
          hintText: 'Enter video ID here',
          validator: (text) {
            if (text == null || text.trim().isEmpty) {
              return 'Please enter a video ID';
            }
            return null;
          },
          onSaved: (text) {
            _videoId = text ?? "";
          },
        ),
      ],
    );
  }

  Widget _buildActionButtonList(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(S.of(context).cancel),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: ElevatedButton(
            onPressed: _onConfirmPressed,
            child: const Text('Confirm'),
          ),
        ),
      ],
    );
  }

  void _onConfirmPressed() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pushNamed(
        '/story_block_video',
        arguments: {'videoId': _videoId},
      );
    }
  }
}
