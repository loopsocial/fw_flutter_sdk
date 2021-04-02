import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fireworktv_lib_android/fireworktv_lib_android.dart';

void main() {
  const MethodChannel channel = MethodChannel('fireworktv_lib_android');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FireworktvLibAndroid.platformVersion, '42');
  });
}
