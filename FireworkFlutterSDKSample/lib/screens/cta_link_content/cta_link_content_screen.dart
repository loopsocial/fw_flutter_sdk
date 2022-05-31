import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fw_flutter_sdk_example/utils/fw_example_logger_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../generated/l10n.dart';
import '../../widgets/fw_app_bar.dart';

class CTALinkContentScreen extends StatefulWidget {
  final RouteSettings settings;
  final bool? isNewContainer;

  const CTALinkContentScreen({
    Key? key,
    required this.settings,
    required this.isNewContainer,
  }) : super(key: key);

  @override
  State<CTALinkContentScreen> createState() => _CTALinkContentScreenState();
}

class _CTALinkContentScreenState extends State<CTALinkContentScreen> {
  String? _url;
  @override
  void initState() {
    super.initState();
    if (widget.settings.name != null) {
      final uri = Uri.parse(widget.settings.name!);
      final queryParameters = uri.queryParameters;
      final jsonString = queryParameters["parameters"];
      if (jsonString != null) {
        Map<String, dynamic> args = jsonDecode(jsonString);
        if (args["url"] is String) {
          _url = args["url"] as String;
          FWExampleLoggerUtil.log("_CTALinkContentScreenState url $_url");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: fwAppBar(
        context: context,
        titleText: S.of(context).ctaLinkContentScreenTitle,
        isNewContainer: widget.isNewContainer,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return WebView(
      initialUrl: _url,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
