import 'dart:developer' as developer;

class FWExampleLoggerUtil {
  static void log(
    String message, {
    String name = 'com.loopnow.fondor_example',
  }) {
    developer.log(message, name: name);
  }
}
