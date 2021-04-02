
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;

class FireworkLib {
  static const MethodChannel _channel = const MethodChannel('com.exemplo.app_flutter/firework');
  static const MethodChannel _channel_ios = const MethodChannel('com.exemplo.app_flutter/firework_ios');

  static Future<String> get getFirework async {
    if (Platform.isAndroid) {
      final String version = await _channel.invokeMethod('getFirework');
      return version;
    } else if (Platform.isIOS) {
      final String version = await _channel_ios.invokeMethod('getFirework');
      return version;
    }
  }
}

