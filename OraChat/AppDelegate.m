#import "AppDelegate.h"
#import "OraChat-Swift.h"


static NSString *const EventUserLogin = @"eventUserLogin";

@interface AppDelegate()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    User *user = [User currentUser];
    if (!user.token) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMainView:) name:EventUserLogin object:nil];
        self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"ORAUserLogin"];
    } else {
        [self showMainView:nil];        
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

- (void)showMainView:(NSNotification *)notification {
    dispatch_async(dispatch_get_main_queue(), ^{
         self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ORAMainChat"];
    });
}

@end
