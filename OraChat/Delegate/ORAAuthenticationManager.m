#import "ORAAuthenticationManager.h"
#import "ProgressHUD.h"
#import "AppDelegate.h"
#import <SAMKeychain/SAMKeychain.h>

static NSString * const OraChatService = @"ora.chat";
static NSString * const EventUserAuthSuccess = @"eventUserAuthSuccess";

@implementation ORAAuthenticationManager

+ (instancetype) sharedInstance {
    static ORAAuthenticationManager* _sharedInstance = nil;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (void)onAuthSuccess:(User *)user password:(NSString *)password error:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(),^{
        if (error == nil && user != nil) {
            [ProgressHUD dismiss];
            [User setCurrentUser:user];
            [User currentUser].password = password;
            [SAMKeychain setPassword:password forService:OraChatService account:password];
            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [delegate showMainView];
        } else {
            [ProgressHUD showError:[error description] Interaction:YES];
        }
    });
}

@end
