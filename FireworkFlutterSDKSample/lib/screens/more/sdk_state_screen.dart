import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';

import '../../utils/fw_example_logger_util.dart';
import '../../utils/host_app_service.dart';
import '../../widgets/fw_app_bar.dart';

/// Demonstrates reading the SDK's app id, guest id and picture-in-picture
/// status.
///
/// [FireworkSDK.appId], [FireworkSDK.guestId] and [FireworkSDK.isPipShown]
/// return the latest locally cached values synchronously. Tap "Read current
/// values" to refresh the displayed values from the getters. These values are
/// only populated on iOS for now.
class SDKStateScreen extends StatefulWidget {
  const SDKStateScreen({Key? key}) : super(key: key);

  @override
  State<SDKStateScreen> createState() => _SDKStateScreenState();
}

class _SDKStateScreenState extends State<SDKStateScreen> {
  String? _appId;
  String? _guestId;
  bool _isPipShown = false;
  bool _injectIntoLinkContentUrl = false;

  @override
  void initState() {
    super.initState();

    // Initialize from the synchronous getters.
    final sdk = FireworkSDK.getInstance();
    _appId = sdk.appId;
    _guestId = sdk.guestId;
    _isPipShown = sdk.isPipShown;
    _injectIntoLinkContentUrl =
        HostAppService.getInstance().injectSDKStateIntoLinkContentUrl;
  }

  void _syncFromGetters() {
    final sdk = FireworkSDK.getInstance();
    setState(() {
      _appId = sdk.appId;
      _guestId = sdk.guestId;
      _isPipShown = sdk.isPipShown;
    });
  }

  void _onReadCurrentValuesPressed() {
    _syncFromGetters();
    final message = "appId: ${_appId ?? "null"}, "
        "guestId: ${_guestId ?? "null"}, "
        "isPipShown: $_isPipShown";
    FWExampleLoggerUtil.log("Read current values -> $message");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fwAppBar(
        context: context,
        titleText: "SDK State",
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildValueItem(
              context,
              "App ID",
              _appId ?? "null",
              copyValue: _appId,
            ),
            _buildValueItem(
              context,
              "Guest ID",
              _guestId ?? "null",
              copyValue: _guestId,
            ),
            _buildValueItem(context, "Is PiP Shown", "$_isPipShown"),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _onReadCurrentValuesPressed,
              child: const Text("Read current values"),
            ),
            const SizedBox(
              height: 20,
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _injectIntoLinkContentUrl,
              onChanged: (value) {
                setState(() {
                  _injectIntoLinkContentUrl = value ?? false;
                });
                HostAppService.getInstance().injectSDKStateIntoLinkContentUrl =
                    _injectIntoLinkContentUrl;
              },
              title: const Text(
                "Inject into Link Content URL",
              ),
              subtitle: const Text(
                "When enabled, appends the non-null app id / guest id / PiP "
                "status to the link content URL as query params "
                "(fwparam_oauth_app_id_override / fwparam_guest_id_override / "
                "fwparam_pip_shown).",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _copyValue(String title, String value) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$title copied"),
      ),
    );
  }

  Widget _buildValueItem(
    BuildContext context,
    String title,
    String value, {
    String? copyValue,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 110, 109, 109),
              ),
            ),
          ),
          if (copyValue != null && copyValue.isNotEmpty)
            InkWell(
              onTap: () => _copyValue(title, copyValue),
              child: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(
                  Icons.copy,
                  size: 18,
                  color: Color.fromARGB(255, 110, 109, 109),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
