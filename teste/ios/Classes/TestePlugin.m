#import "TestePlugin.h"
#if __has_include(<teste/teste-Swift.h>)
#import <teste/teste-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "teste-Swift.h"
#endif

@implementation TestePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTestePlugin registerWithRegistrar:registrar];
}
@end
