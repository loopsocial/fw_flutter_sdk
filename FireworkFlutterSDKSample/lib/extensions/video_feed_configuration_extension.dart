import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';

extension VideothisExtension on VideoFeedConfiguration {
  VideoFeedConfiguration clone() {
    return VideoFeedConfiguration(
      backgroundColor: backgroundColor,
      cornerRadius: cornerRadius,
      title: title,
      titlePosition: titlePosition,
      playIcon: playIcon,
      showAdBadge: showAdBadge,
      customLayoutName: customLayoutName,
      aspectRatio: aspectRatio,
      contentPadding: contentPadding,
      itemSpacing: itemSpacing,
      enableAutoplay: enableAutoplay,
      gridColumns: gridColumns,
    );
  }
}
