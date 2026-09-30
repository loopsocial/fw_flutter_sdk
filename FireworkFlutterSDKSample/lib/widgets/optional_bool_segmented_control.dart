import 'package:flutter/cupertino.dart';

import '../generated/l10n.dart';

enum _OptionalBool { unset, show, hide }

/// Three-way picker for a nullable bool option.
///
/// Default leaves the option unset (null) so the native SDK default or fallback
/// applies; Show and Hide set it to true and false.
class OptionalBoolSegmentedControl extends StatelessWidget {
  final String title;
  final bool? value;
  final ValueChanged<bool?> onChanged;

  /// Label for the unset segment; defaults to "Default".
  final String? defaultLabel;

  const OptionalBoolSegmentedControl({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.defaultLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title),
        const SizedBox(
          height: 10,
        ),
        CupertinoSegmentedControl<_OptionalBool>(
          padding: EdgeInsets.zero,
          onValueChanged: (selected) {
            onChanged(_toBool(selected));
          },
          children: {
            _OptionalBool.unset: _buildSegment(
              defaultLabel ?? S.of(context).optionalBoolDefault,
            ),
            _OptionalBool.show: _buildSegment(S.of(context).optionalBoolShow),
            _OptionalBool.hide: _buildSegment(S.of(context).optionalBoolHide),
          },
          groupValue: _fromBool(value),
        ),
      ],
    );
  }

  static _OptionalBool _fromBool(bool? value) {
    if (value == null) {
      return _OptionalBool.unset;
    }
    return value ? _OptionalBool.show : _OptionalBool.hide;
  }

  static bool? _toBool(_OptionalBool selected) {
    if (selected == _OptionalBool.unset) {
      return null;
    }
    return selected == _OptionalBool.show;
  }

  Widget _buildSegment(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(label),
    );
  }
}
