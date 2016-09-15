#import "ORAAccountViewController.h"
#import "OraChat-Swift.h"

@interface ORAAccountViewController()
@property (weak, nonatomic) IBOutlet UITextField *fieldName;
@property (weak, nonatomic) IBOutlet UITextField *fieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *fieldPassword;
@property (weak, nonatomic) IBOutlet UITextField *filedConfirm;

@end
@implementation ORAAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *saveImage = [UIImage imageNamed:@"save"];
    saveImage = [saveImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithImage:saveImage
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(saveUser)];
    self.navigationItem.rightBarButtonItem = saveButton;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    User *user = [User currentUser];
    self.fieldName.text = user.name;
    self.fieldEmail.text = user.email;
    self.fieldPassword.text = user.password;
    self.filedConfirm.text = user.password;
}

- (void)saveUser {
}

@end
