#import <Foundation/Foundation.h>
#import "OraChat-Swift.h"

@protocol ORAUserOperationDelegate
@end

@interface ORAUserAuthentication : NSObject
@property (weak, nonatomic, nullable) id<ORAUserOperationDelegate> delegate;

+ (nonnull instancetype)sharedInstance;
- (void)signInSucceed:(nullable User *)user password:(nullable NSString *)password error:(nullable NSError *)error;
@end
