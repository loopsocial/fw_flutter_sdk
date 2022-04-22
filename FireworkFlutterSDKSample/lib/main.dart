import 'dart:io';

import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/utils/fw_example_logger_util.dart';
import 'package:flutter/material.dart';
import 'my_app.dart';

void main() {
  FWExampleLoggerUtil.log("main: run app");
  if (Platform.isAndroid) {
    // Enable hybrid composition
    VideoFeed.useHybridCompositionForAndroid = true;
  }
  runApp(const MyApp());
}
