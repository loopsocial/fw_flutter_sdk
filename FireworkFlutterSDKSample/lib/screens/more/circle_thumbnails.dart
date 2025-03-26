import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import '../../widgets/fw_app_bar.dart';
import '../../generated/l10n.dart';

class CircleThumbnails extends StatefulWidget {
  const CircleThumbnails({Key? key}) : super(key: key);

  @override
  State<CircleThumbnails> createState() => _CircleThumbnailsState();
}

class _CircleThumbnailsState extends State<CircleThumbnails> {
  @override
  Widget build(BuildContext context) {
    double feedHeight = 200;
    double paddingTop = 10;
    double paddingRight = 10;
    double paddingBottom = 10;
    double paddingLeft = 10;

    final contentPadding = VideoFeedPadding(
      top: paddingTop,
      right: paddingRight,
      bottom: paddingBottom,
      left: paddingLeft,
    );
    double aspectRatio = 1.0;
    double thumbnailHeight = 0;
    if (Platform.isAndroid) {
      thumbnailHeight = feedHeight;
    } else {
      thumbnailHeight = feedHeight - paddingTop - paddingBottom;
    }
    final videoFeedConfiguration = VideoFeedConfiguration(
      aspectRatio: aspectRatio,
      contentPadding: contentPadding,
      cornerRadius: thumbnailHeight / 2,
      title: VideoFeedTitleConfiguration(
        hidden: true,
      ),
    );
    return Scaffold(
      appBar: fwAppBar(
        context: context,
        titleText: S.of(context).circleThumbnails,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: VideoFeed(
            height: feedHeight,
            source: VideoFeedSource.playlist,
            channel: "bJDywZ",
            playlist: "g206q5",
            mode: VideoFeedMode.row,
            videoFeedConfiguration: videoFeedConfiguration,
          ),
        ),
      ),
    );
  }
}
