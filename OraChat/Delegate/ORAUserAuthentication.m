#import "ORAUserAuthentication.h"
#import "ProgressHUD.h"

@implementation ORAUserAuthentication

+ (instancetype) sharedInstance {
    static ORAUserAuthentication* _sharedInstance = nil;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (void)signInSucceed:(User *)user password:(NSString *)password error:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(),^{
        if (error == nil && user != nil) {
            [User setCurrentUser:user];
            [User currentUser].password = password;
            [ProgressHUD dismiss];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"eventUserLogin" object:self userInfo:nil];
        } else {
            [ProgressHUD showError:[error description] Interaction:YES];
        }
    });
}

@end
