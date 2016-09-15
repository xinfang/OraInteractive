#import <UIKit/UIKit.h>
#import "OraChat-Swift.h"

@interface ORAMessageCell : UITableViewCell
@property(strong, nonatomic) Message *message;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
