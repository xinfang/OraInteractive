#import <Foundation/Foundation.h>
#import "OraChat-Swift.h"
#import <SAMKeychain/SAMKeychain.h>

@protocol ORAUserOperationDelegate
@end

@interface ORAAuthenticationManager : NSObject
@property (weak, nonatomic, nullable) id<ORAUserOperationDelegate> delegate;

+ (nonnull instancetype)sharedInstance;
+ (nullable NSString *)getPasswordForEmail: (nullable NSString *)email;
- (void)onAuthSuccess:(nullable User *)user password:(nullable NSString *)password error:(nullable NSError *)error;
@end
