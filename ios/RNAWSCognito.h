#import <React/RCTBridgeModule.h>
#import <React/RCTLog.h>
#import <React/RCTUtils.h>

#import "JKBigIntegerOc.h"

@interface RNAWSCognito : NSObject <RCTBridgeModule>
-(NSString*)getRandomBase64:(NSUInteger)byteLength;
@end
