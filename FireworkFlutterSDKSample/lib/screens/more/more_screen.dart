import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/models/app_language_info.dart';
import 'package:fw_flutter_sdk_example/utils/host_app_service.dart';
import '../../generated/l10n.dart';
import '../../widgets/fw_app_bar.dart';

const fwNativeVersionOfAndroid = '6.22.0';

class MoreScreen extends StatefulWidget {
  const MoreScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  AppLanguageInfo? _currentAppLanguage;
  DataTrackingLevel _dataTrackingLevel = DataTrackingLevel.all;
  LivestreamPlayerDesignVersion _livestreamPlayerVersion =
      LivestreamPlayerDesignVersion.v1;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      HostAppService.getInstance()
          .getCacheAppLanguageInfo()
          .then((appLanguage) {
        if (mounted) {
          setState(() {
            _currentAppLanguage = appLanguage;
          });
        }
      });
      HostAppService.getInstance().getCacheDataTrackingLevel().then((value) {
        setState(() {
          _dataTrackingLevel = value ?? DataTrackingLevel.all;
        });
      });
      HostAppService.getInstance().getLivestreamPlayerVersion().then((value) {
        setState(() {
          _livestreamPlayerVersion = value ?? LivestreamPlayerDesignVersion.v1;
        });
      });
    });
  }

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
              title: S.of(context).stopFloatingPlayer,
              onTap: () {
                FireworkSDK.getInstance().navigator.stopFloatingPlayer();
              },
            ),
            if (_currentAppLanguage != null)
              _buildItem(
                context: context,
                title: S
                    .of(context)
                    .changeAppLanguage(_currentAppLanguage!.displayName ?? ""),
                onTap: () {
                  final appLanguageInfoArray =
                      HostAppService.getInstance().getAppLanguageInfoList();
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      final appLanguageInfoWidgetArray =
                          appLanguageInfoArray.map(
                        (appLanguageInfo) => CupertinoActionSheetAction(
                          isDefaultAction: true,
                          onPressed: () {
                            _changeAppLanguage(appLanguageInfo);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            appLanguageInfo.displayName ?? '',
                          ),
                        ),
                      );
                      return CupertinoActionSheet(
                        title: Text(
                          S.of(context).selectLanguage,
                        ),
                        actions: [
                          for (var w in appLanguageInfoWidgetArray) w,
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          child: Text(
                            S.of(context).cancel,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            _buildItem(
              context: context,
              title: S
                  .of(context)
                  .changeDataTrackingLevel(_dataTrackingLevel.name),
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    final dataTrackingLevelWidgetArray =
                        DataTrackingLevel.values.map(
                      (level) => CupertinoActionSheetAction(
                        isDefaultAction: true,
                        onPressed: () {
                          HostAppService.getInstance()
                              .cacheDataTrackingLevel(level);
                          setState(() {
                            _dataTrackingLevel = level;
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          level.name,
                        ),
                      ),
                    );
                    return CupertinoActionSheet(
                      title: Text(
                        S.of(context).selectDataTrackingLevel,
                      ),
                      actions: [
                        for (var w in dataTrackingLevelWidgetArray) w,
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        child: Text(
                          S.of(context).cancel,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    );
                  },
                );
              },
            ),
            _buildItem(
              context: context,
              title: S
                  .of(context)
                  .changeLiveStreamPlayerVersion(_livestreamPlayerVersion.name),
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    final livestreamPlayerDesignVersionWidgetArray =
                        LivestreamPlayerDesignVersion.values.map(
                      (version) => CupertinoActionSheetAction(
                        isDefaultAction: true,
                        onPressed: () {
                          HostAppService.getInstance()
                              .cacheLivestreamPlayerVersion(version);
                          setState(() {
                            _livestreamPlayerVersion = version;
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          version.name,
                        ),
                      ),
                    );
                    return CupertinoActionSheet(
                      title: Text(
                        S.of(context).selectLiveStreamPlayerVersion,
                      ),
                      actions: [
                        for (var w in livestreamPlayerDesignVersionWidgetArray)
                          w,
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        child: Text(
                          S.of(context).cancel,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    );
                  },
                );
              },
            ),
            if (defaultTargetPlatform == TargetPlatform.android)
              _buildItem(
                context: context,
                title:
                    S.of(context).fwAndroidSdkVersion(fwNativeVersionOfAndroid),
                onTap: () {},
              ),
            _buildItem(
              context: context,
              title: S.of(context).enableOnVideoPlaybackLog,
              onTap: () {
                Navigator.of(context)
                    .pushNamed("/enable_on_video_playback_log");
              },
            ),
            _buildItem(
              context: context,
              title: "Enable custom share url callback",
              onTap: () {
                Navigator.of(context)
                    .pushNamed("/enable_custom_share_url_callback");
              },
            ),
            _buildItem(
              context: context,
              title: "Enable custom share url",
              onTap: () {
                Navigator.of(context).pushNamed("/enable_custom_share_url");
              },
            ),
            _buildItem(
              context: context,
              title: "Enable link interaction click callback",
              onTap: () {
                Navigator.of(context)
                    .pushNamed("/enable_link_interaction_click_callback");
              },
            ),
            _buildItem(
              context: context,
              title: "Enable giveaway terms and conditions click callback",
              onTap: () {
                Navigator.of(context)
                    .pushNamed("/enable_giveaway_terms_click_callback");
              },
            ),
            _buildItem(
              context: context,
              title: "Check if PiP is shown",
              onTap: () async {
                final result =
                    await FireworkSDK.getInstance().navigator.isPiPShown();
                EasyLoading.showToast(
                  "The PiP is shown: $result",
                  duration: const Duration(
                    seconds: 5,
                  ),
                );
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
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            height: 1,
            color: const Color.fromARGB(255, 202, 200, 200),
          ),
        ],
      ),
    );
  }

  Future<void> _changeAppLanguage(AppLanguageInfo appLanguageInfo) async {
    if (mounted) {
      setState(() {
        _currentAppLanguage = appLanguageInfo;
      });
    }
    await HostAppService.getInstance().cacheAppLanguageInfo(appLanguageInfo);
  }
}
