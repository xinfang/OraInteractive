#import "ORAUserRegisterViewController.h"
#import "ProgressHUD.h"
#import "OraChat-Swift.h"
#import "AppDelegate.h"
#import "NSString+Utilities.h"
#import "ORAAuthenticationManager.h"

@interface ORAUserRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *filedName;
@property (weak, nonatomic) IBOutlet UITextField *fieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *fieldPassword;
@property (weak, nonatomic) IBOutlet UITextField *fieldConfirm;
@end

@implementation ORAUserRegisterViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem* loginButton = self.navigationItem.leftBarButtonItem;
    [loginButton setImage:[[UIImage imageNamed:@"login"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UIImage *registerImage = [UIImage imageNamed:@"register"];
    registerImage = [registerImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *registerButton = [[UIBarButtonItem alloc]initWithImage:registerImage
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(registerUser)];
    self.navigationItem.rightBarButtonItem = registerButton;
}

- (IBAction)performBackNavigation:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)registerUser {
    NSString *name = [self.filedName.text lowercaseString];
    NSString *email = [self.fieldEmail.text lowercaseString];
    NSString *password = self.fieldPassword.text;
    NSString *confirm = self.fieldConfirm.text;
    
    if ([name length] == 0)	{
        [ProgressHUD showError:@"Please enter your name."];
        return;
    }
    
    if ([email length] == 0)	{
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

    if (![password isEqualToString:confirm])	{
        [ProgressHUD showError:@"Passwords dont match."];
        return;
    }

    UserOperation *registerOp = [[UserOperation alloc] initWithEmail:email password:password username:name taskCompletionCallback:^(User * _Nullable user, NSError * _Nullable error) {
        [[ORAAuthenticationManager sharedInstance] onAuthSuccess:user password: self.fieldPassword.text error:error];
    }];
    [registerOp execute];
}
@end
