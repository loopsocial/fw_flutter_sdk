#import "FireworktvLibAndroidPlugin.h"
#if __has_include(<fireworktv_lib_android/fireworktv_lib_android-Swift.h>)
#import <fireworktv_lib_android/fireworktv_lib_android-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "fireworktv_lib_android-Swift.h"
#endif

@implementation FireworktvLibAndroidPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFireworktvLibAndroidPlugin registerWithRegistrar:registrar];
}
@end
