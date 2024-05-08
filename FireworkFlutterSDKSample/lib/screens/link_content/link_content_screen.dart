import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

        String? iOSUrl;
        if (arg["iOSUrl"] is String) {
          iOSUrl = arg["iOSUrl"] as String;
        }

        String? androidUrl;
        if (arg["androidUrl"] is String) {
          androidUrl = arg["androidUrl"] as String;
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (iOSUrl != null && androidUrl != null) {
            EasyLoading.showToast(
              S.of(context).multiplePageUrlsToastText(
                    url,
                    iOSUrl,
                    androidUrl,
                  ),
              duration: const Duration(
                seconds: 5,
              ),
            );
          } else {
            EasyLoading.showToast(
              S.of(context).pageUrlToastText(url),
              duration: const Duration(
                seconds: 5,
              ),
            );
          }
        });
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/log");
        },
        child: Text(
          S.of(context).log,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_controller != null) {
      return WebViewWidget(controller: _controller!);
    }

    return Container();
  }
}
