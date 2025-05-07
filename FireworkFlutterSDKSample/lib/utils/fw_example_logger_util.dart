import 'package:flutter/material.dart';

class FWExampleLoggerUtil {
  static final messageList = <String>[];
  static void log(
    String message, {
    String name = 'com.loopnow.fondor_example',
    bool shouldCache = false,
  }) {
    debugPrint("[$name] $message");
    if (shouldCache) {
      messageList.add(message);
    }
  }
}
