import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';

extension FWErrorExtension on FWError {
  String displayString() {
    return "name: $name reason: $reason";
  }
}
