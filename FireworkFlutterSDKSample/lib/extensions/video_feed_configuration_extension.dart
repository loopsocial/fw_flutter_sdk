import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';

extension VideoFeedConfigurationExtension on VideoFeedConfiguration {
  VideoFeedConfiguration clone() {
    return VideoFeedConfiguration(
      backgroundColor: backgroundColor,
      cornerRadius: cornerRadius,
      title: title?.clone(),
      titlePosition: titlePosition,
      playIcon: playIcon?.clone(),
      showAdBadge: showAdBadge,
      customLayoutName: customLayoutName,
      aspectRatio: aspectRatio,
      contentPadding: contentPadding?.clone(),
      itemSpacing: itemSpacing,
      enableAutoplay: enableAutoplay,
      gridColumns: gridColumns,
    );
  }
}

extension VideoFeedPlayIconConfigurationExtension
    on VideoFeedPlayIconConfiguration {
  VideoFeedPlayIconConfiguration clone() {
    return VideoFeedPlayIconConfiguration(
      hidden: hidden,
      iconWidth: iconWidth,
    );
  }
}

extension VideoFeedTitleConfigurationExtension on VideoFeedTitleConfiguration {
  VideoFeedTitleConfiguration clone() {
    return VideoFeedTitleConfiguration(
      hidden: hidden,
      textColor: textColor,
      fontSize: fontSize,
    );
  }
}

extension VideoFeedContentPaddingExtension on VideoFeedContentPadding {
  VideoFeedContentPadding clone() {
    return VideoFeedContentPadding(
      top: top,
      right: right,
      bottom: bottom,
      left: left,
    );
  }
}
