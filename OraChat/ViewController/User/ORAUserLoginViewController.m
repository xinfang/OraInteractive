#import "ORAUserLoginViewController.h"
#import "ProgressHUD.h"
#import "OraChat-Swift.h"
#import "AppDelegate.h"
#import "NSString+Utilities.h"

@interface ORAUserLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *fieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *fieldPassword;
@end

@implementation ORAUserLoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
    
    UIBarButtonItem* rightButton = self.navigationItem.rightBarButtonItem;
    [rightButton setImage:[[UIImage imageNamed:@"login"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UIBarButtonItem* leftButton = self.navigationItem.leftBarButtonItem;
    [leftButton setImage:[[UIImage imageNamed:@"register"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self dismissKeyboard];
}

- (IBAction)userLogin:(UIBarButtonItem *)button {
    [self dismissKeyboard];
    NSString *email = [self.fieldEmail.text lowercaseString];
    NSString *password = self.fieldPassword.text;
    
    if ([email length] == 0) {
        [ProgressHUD showError:@"Please enter your email."];
        return;
    }
    
    if ([email isValidEmail]) {
        [ProgressHUD showError:@"Invalid Email."];
        return;
    }
    
    if ([password length] == 0)	{
        [ProgressHUD showError:@"Please enter your password."];
        return;
    }
    
    [ProgressHUD show:nil Interaction:NO];
    UserOperation *loginOp = [[UserOperation alloc] initWithEmail:email password:password taskCompletionCallback:^(User * _Nullable user, NSError * _Nullable error) {
        if (error == nil && user != nil) {
            [User setCurrentUser:user];
            [ProgressHUD dismiss];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"eventUserLogin" object:self userInfo:nil];
        } else {
            [ProgressHUD showError:[error description]];
        }
    }];
    [loginOp execute];
//    [self.operationQueue cancelAllOperations];
//    [self.operationQueue addOperation:loginOp];
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

#pragma mark - UITextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.fieldEmail) [self.fieldPassword becomeFirstResponder];
    return YES;
}

@end
