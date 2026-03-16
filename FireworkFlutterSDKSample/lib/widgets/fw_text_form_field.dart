import 'package:flutter/material.dart';

class FWTextFormField extends StatefulWidget {
  /// Initial value, used when [text] is null and only in initState.
  final String? initialValue;
  /// External text: when non-null and updated by parent, the field content is synced to this value.
  final String? text;
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
    this.text,
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
  void didUpdateWidget(covariant FWTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != oldWidget.text) {
      final controller = widget.controller ?? _defaultController;
      final value = widget.text ?? '';
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        controller.text = value;
      });
    }
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
