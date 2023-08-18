import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

class ValidationUtil {
  static String? validateColor(String? text, BuildContext context) {
    if (text == null) {
      return null;
    }

    if (text.isEmpty) {
      return null;
    }

    RegExp reg =
        RegExp(r'^(0x|#)(?:[0-9a-fA-F]{3,4}){1,2}$', caseSensitive: false);

    if (!reg.hasMatch(text)) {
      return S.of(context).colorError;
    }

    return null;
  }

  static String? validateNumber({
    required BuildContext context,
    String? text,
    required String errorMessage,
    required int min,
    required int max,
    required String rangeErrorMessage,
  }) {
    if (text == null) {
      return null;
    }

    if (text.isEmpty) {
      return null;
    }

    final number = int.tryParse(text);
    if (number == null) {
      return errorMessage;
    }

    if (number >= min && number <= max) {
      return null;
    }

    return rangeErrorMessage;
  }

  static String? validId({
    String? text,
    String? requiredError,
    required String errorMessage,
  }) {
    if (text == null) {
      return requiredError;
    }

    if (text.isEmpty) {
      return requiredError;
    }

    RegExp reg = RegExp(r'^\S+$');

    if (!reg.hasMatch(text)) {
      return errorMessage;
    }

    return null;
  }

  static String? validURL({
    String? text,
    String? requiredError,
    required String errorMessage,
  }) {
    if (text == null) {
      return requiredError;
    }

    if (text.isEmpty) {
      return requiredError;
    }

    RegExp reg = RegExp(
        r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$');

    if (!reg.hasMatch(text)) {
      return errorMessage;
    }

    return null;
  }
}
