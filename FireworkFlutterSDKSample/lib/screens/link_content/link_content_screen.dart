import 'package:flutter/material.dart';
import 'package:fw_flutter_sdk_example/utils/fw_example_logger_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../generated/l10n.dart';
import '../../widgets/fw_app_bar.dart';

class LinkContentScreen extends StatefulWidget {
  final RouteSettings settings;

  const LinkContentScreen({
    Key? key,
    required this.settings,
  }) : super(key: key);

  @override
  State<LinkContentScreen> createState() => _LinkContentScreenState();
}

class _LinkContentScreenState extends State<LinkContentScreen> {
  WebViewController? _controller;
  @override
  void initState() {
    super.initState();
    if (widget.settings.arguments is Map<dynamic, dynamic>) {
      final arg = widget.settings.arguments as Map<dynamic, dynamic>;

      if (arg["url"] is String) {
        final url = arg["url"] as String;
        FWExampleLoggerUtil.log("_CTALinkContentScreenState url $url");
        _controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(url));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: fwAppBar(
        context: context,
        titleText: S.of(context).linkContentScreenTitle,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_controller != null) {
      return WebViewWidget(controller: _controller!);
    }

    return Container();
  }
}
