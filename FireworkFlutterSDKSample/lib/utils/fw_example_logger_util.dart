import 'dart:developer' as developer;

class FWExampleLoggerUtil {
  static final messageList = <String>[];
  static void log(
    String message, {
    String name = 'com.loopnow.fondor_example',
    bool shouldCache = false,
  }) {
    developer.log(message, name: name);
    if (shouldCache) {
      messageList.add(message);
    }
  }
}
