import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fireworktv_lib_android/fireworktv_lib_android.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter FIrework Plugin'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // static const platform = const MethodChannel('com.exemplo.app_flutter/firework');
  // static const platform_ios = const MethodChannel('com.exemplo.app_flutter/firework_ios');


  Future<void> renderFirework() async {
    try {
      await FireworkLib.getFirework;
    } on PlatformException catch (e) {
      print("Failed to get firework '${e.message}'.");
    }
  }

  void initState() {
    super.initState();
    renderFirework();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Text('Get Firework Videos'),
              onPressed: renderFirework,
            ),
          ],
        ),
      ),
    );
  }
}
