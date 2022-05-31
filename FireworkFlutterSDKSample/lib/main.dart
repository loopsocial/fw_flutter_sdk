import 'dart:io';
import 'package:fw_flutter_sdk_example/utils/fw_example_logger_util.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'my_app.dart';

void main() {
  FWExampleLoggerUtil.log("main: run app");

  if (Platform.isAndroid) {
    WebView.platform = AndroidWebView();
  }

  runApp(const MyApp());
}
