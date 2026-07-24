import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/utils/fw_example_logger_util.dart';
import 'package:fw_flutter_sdk_example/utils/host_app_service.dart';
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
  String? _url;
  @override
  void initState() {
    super.initState();
    if (widget.settings.arguments is Map<dynamic, dynamic>) {
      final arg = widget.settings.arguments as Map<dynamic, dynamic>;

      if (arg["url"] is String) {
        final url = _injectSDKStateIfNeeded(arg["url"] as String);
        _url = url;
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

  /// Appends the SDK's app id / guest id / PiP status to [url] as query
  /// parameters when the corresponding config is enabled on the SDK State
  /// screen. App id / guest id are only appended when they are non-null.
  String _injectSDKStateIfNeeded(String url) {
    if (!HostAppService.getInstance().injectSDKStateIntoLinkContentUrl) {
      return url;
    }

    final sdk = FireworkSDK.getInstance();
    final parameters = <String, String>{};

    final appId = sdk.appId;
    if (appId != null) {
      parameters["fwparam_oauth_app_id_override"] = appId;
    }

    final guestId = sdk.guestId;
    if (guestId != null) {
      parameters["fwparam_guest_id_override"] = guestId;
    }

    parameters["fwparam_pip_shown"] = sdk.isPipShown.toString();

    return FWUrlUtil.addQueryParameters(url: url, parameters: parameters);
  }

  void _copyUrl() {
    final url = _url;
    if (url == null) {
      return;
    }
    Clipboard.setData(ClipboardData(text: url));
    FWExampleLoggerUtil.log("Copied link content url: $url");
    EasyLoading.showToast("URL copied to clipboard");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: fwAppBar(
        context: context,
        titleText: S.of(context).linkContentScreenTitle,
        actions: [
          if (_url != null)
            Semantics(
              label: 'Copy URL',
              child: IconButton(
                onPressed: _copyUrl,
                icon: const Icon(Icons.copy),
              ),
            ),
        ],
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
