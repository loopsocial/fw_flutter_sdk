import 'package:flutter/material.dart';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';

import '../generated/l10n.dart';
import '../utils/validation_util.dart';
import 'fw_text_form_field.dart';

class PinMessageStyleForm extends StatelessWidget {
  final PinMessageStyle? initialStyle;
  final FormFieldSetter<String> onTextColorSaved;
  final FormFieldSetter<String> onBackgroundColorSaved;

  const PinMessageStyleForm({
    super.key,
    required this.initialStyle,
    required this.onTextColorSaved,
    required this.onBackgroundColorSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildColorField(
            context: context,
            label: S.of(context).pinMessageTextColor,
            hintText: S.of(context).pinMessageTextColorHint,
            initialValue: initialStyle?.textColor,
            onSaved: onTextColorSaved,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _buildColorField(
            context: context,
            label: S.of(context).pinMessageBackgroundColor,
            hintText: S.of(context).pinMessageBackgroundColorHint,
            initialValue: initialStyle?.backgroundColor,
            onSaved: onBackgroundColorSaved,
          ),
        ),
      ],
    );
  }

  Widget _buildColorField({
    required BuildContext context,
    required String label,
    required String hintText,
    required String? initialValue,
    required FormFieldSetter<String> onSaved,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label),
        FWTextFormField(
          initialValue: initialValue,
          hintText: hintText,
          validator: (text) => ValidationUtil.validateColor(text, context),
          onSaved: onSaved,
        ),
      ],
    );
  }
}
