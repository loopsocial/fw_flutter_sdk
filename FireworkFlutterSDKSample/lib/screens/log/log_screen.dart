import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fw_flutter_sdk_example/utils/fw_example_logger_util.dart';
import 'package:flutter/services.dart';

import '../../generated/l10n.dart';
import '../../widgets/fw_app_bar.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  List<String> _messageList = [];
  @override
  void initState() {
    super.initState();
    _messageList = FWExampleLoggerUtil.messageList;
  }

  @override
  Widget build(BuildContext context) {
    final widgetList =
        _messageList.map((message) => _buildItem(context, message)).toList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          fwAppBar(context: context, titleText: S.of(context).log, actions: [
        GestureDetector(
          onTap: () {
            Clipboard.setData(
              ClipboardData(
                text: _messageList.join("\n\n"),
              ),
            ).then((value) {
              FWExampleLoggerUtil.log("copied");
            });
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                S.of(context).export,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            FWExampleLoggerUtil.messageList.clear();
            setState(() {
              _messageList = [];
            });
            EasyLoading.showToast(
              S.of(context).clearLogSuccessfully,
            );
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                S.of(context).clearLog,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ]),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: widgetList,
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, String message) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: SelectableText(message),
    );
  }
}
