#import "ORAMessageViewController.h"
#import "OraChat-Swift.h"
#import "ORAMessageCell.h"
#import "ProgressHUD.h"
#import "UIScrollView+FloatingButton.h"

static NSString *MessageCellIdentifier = @"MessageCell";

@interface ORAMessageViewController() <MEVFloatingButtonDelegate>
@property (copy, nonatomic) NSMutableArray *messageData;
@end

@implementation ORAMessageViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.layoutMargins = UIEdgeInsetsZero;
    [self showAddFloatButton];
    self.messageData= [NSMutableArray array];
    [self fetchMessageListData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchMessageListData];
}

- (void)fetchMessageListData {
    MessageListOperation *operation = [[MessageListOperation alloc] initWithChatID:self.chatGroupID page:1 taskCompletionCallback:^(NSArray<Message *> * _Nullable operationResult, NSError * _Nullable error) {
        if (error == nil) {
            if (operationResult != nil) {
                self.messageData = [operationResult mutableCopy];
                [self.tableView reloadData];
            }
        }
    }];
    [operation execute];
}

- (void)showAddFloatButton {
    MEVFloatingButton *button = [[MEVFloatingButton alloc] init];
    button.animationType = MEVFloatingButtonAnimationNone;
    button.displayMode = MEVFloatingButtonDisplayModeAlways;
    button.position = MEVFloatingButtonPositionBottomRight;
    button.image = [UIImage imageNamed:@"add"];
    button.imageColor = [UIColor colorWithRed:245/255.0f green:166/255.0f blue:33/255.0f alpha:1];
    button.backgroundColor = [UIColor whiteColor];
    button.outlineWidth = 0.0f;
    //button.imagePadding = 15.0f;
    button.verticalOffset = -50.0f;
    [self.tableView setFloatingButtonView:button];
    [self.tableView setFloatingButtonDelegate:self];
}

#pragma mark Table Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    if (self.messageData) {
        return [self.messageData count] ;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Message *message = self.messageData[indexPath.row];
    ORAMessageCell *cell = [ORAMessageCell cellWithTableView:tableView];
    [cell setMessage: message];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

#pragma mark - MEScrollToTopDelegate Methods
- (void)floatingButton:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    NSLog(@"didTapButton");
}
@end
