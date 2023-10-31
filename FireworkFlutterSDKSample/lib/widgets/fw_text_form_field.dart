import 'package:flutter/material.dart';

class FWTextFormField extends StatefulWidget {
  final String? initialValue;
  final String? hintText;
  final int? maxLines;
  final int? minLines;
  final bool? enabled;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;

  const FWTextFormField({
    Key? key,
    this.initialValue,
    this.hintText,
    this.maxLines,
    this.minLines,
    this.onSaved,
    this.validator,
    this.controller,
    this.enabled,
  }) : super(key: key);

  @override
  State<FWTextFormField> createState() => _FWTextFormFieldState();
}

class _FWTextFormFieldState extends State<FWTextFormField> {
  final TextEditingController _defaultController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _defaultController.text = widget.initialValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final controller = (widget.controller ?? _defaultController);
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        errorMaxLines: 2,
        suffixIcon: IconButton(
          onPressed: controller.clear,
          icon: const Icon(Icons.clear),
        ),
      ),
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      enabled: widget.enabled,
      validator: widget.validator,
      onSaved: widget.onSaved,
    );
  }
}
