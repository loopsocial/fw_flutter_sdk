import 'package:flutter/material.dart';

import '../../widgets/fw_app_bar.dart';

/// A simple placeholder page pushed on top of the embed tab.
///
/// Its only purpose is to cover the embedded widget on the embed tab so that,
/// after popping back, you can observe whether the embedded widget was kept
/// alive (controlled by the `enableKeepingAlive` toggle on the home screen).
class EmbedSecondaryScreen extends StatelessWidget {
  const EmbedSecondaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: fwAppBar(
        context: context,
        titleText: "Secondary Page",
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "This page covers the embedded widget.\n\n"
                "Go back to check whether the embedded widget on the embed "
                "tab was kept alive.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).maybePop();
                },
                child: const Text("Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
