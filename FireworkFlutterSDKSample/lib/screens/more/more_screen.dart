import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../../widgets/fw_app_bar.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fwAppBar(
        context: context,
        titleText: S.of(context).more,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            _buildItem(
              context: context,
              title: S.of(context).openVideoURL,
              onTap: () {
                Navigator.of(context).pushNamed("/open_video_url");
              },
            ),
            _buildItem(
              context: context,
              title: S.of(context).setShareBaseURL,
              onTap: () {
                Navigator.of(context).pushNamed("/set_share_base_url");
              },
            ),
            _buildItem(
              context: context,
              title: S.of(context).setAdBadgeConfiguration,
              onTap: () {
                Navigator.of(context).pushNamed("/set_ad_badge_configuration");
              },
            ),
            _buildItem(
              context: context,
              title: S.of(context).enableCustomCTAClickCallback,
              onTap: () {
                Navigator.of(context)
                    .pushNamed("/enable_custom_cta_click_callback");
              },
            ),
            _buildItem(
              context: context,
              title: S.of(context).circleThumbnails,
              onTap: () {
                Navigator.of(context).pushNamed("/circle_thumbnails");
              },
            ),
            _buildItem(
              context: context,
              title: S.of(context).enableCustomClickCartIconCallback,
              onTap: () {
                Navigator.of(context).pushNamed(
                    "/enable_custom_click_cart_icon_callback_screen");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem({
    required BuildContext context,
    required String title,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.white,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            padding: const EdgeInsets.all(20),
          ),
          Container(
            height: 1,
            color: const Color.fromARGB(255, 202, 200, 200),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
