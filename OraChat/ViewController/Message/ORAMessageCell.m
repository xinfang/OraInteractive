#import "ORAMessageCell.h"
#import "NSDate+Utilities.h"

@interface ORAMessageCell() {
    UILabel *_timeLabel;
    UIButton *_sendButton;
    UIButton *_receiveButton;
}
@end

@implementation ORAMessageCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *CellIdentifier = nil;
    if (CellIdentifier == nil) {
        CellIdentifier = [NSString stringWithFormat:@"%@CellIdentifier", NSStringFromClass(self)];
    }
    id cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [self setContentViewConstraint];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.translatesAutoresizingMaskIntoConstraints = NO;
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _sendButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"sendBubble"] forState:UIControlStateNormal];
        [_sendButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 10.0, 0.0, 5.0 )];
        [_sendButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
     
        _receiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _receiveButton.translatesAutoresizingMaskIntoConstraints = NO;
        _receiveButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _receiveButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_receiveButton setBackgroundImage:[UIImage imageNamed:@"receiveBubble"] forState:UIControlStateNormal];
        [_receiveButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 10.0, 0.0, 5.0 )];
        [_receiveButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
   
        [self.contentView addSubview:_sendButton];
        [self.contentView addSubview:_receiveButton];
        [self.contentView addSubview:_timeLabel];

        [self setSubViewConstraint];
    }
    return self;
}

- (void)setContentViewConstraint {
    NSDictionary *views = @{@"_contentView" : self.contentView};
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_contentView]-10-|"
                                                                                    options: 0
                                                                                    metrics: nil
                                                                                      views: views]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_contentView(>=75)]-0-|"
                                                                                    options:0
                                                                                    metrics:nil
                                                                                      views:views]];
}

- (void)setSubViewConstraint {
    NSDictionary *variablesBindings = NSDictionaryOfVariableBindings(_timeLabel, _sendButton, _receiveButton);
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"H:|-0-[_timeLabel]-0-|"
                                                                                    options: 0
                                                                                    metrics: nil
                                                                                      views: variablesBindings]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"V:|-(>=55)-[_timeLabel(15)]-5-|"
                                                                                    options: 0
                                                                                    metrics: nil
                                                                                      views: variablesBindings]];

    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"H:|-(>=50)-[_sendButton(>=10)]-0-|"
                                                                                    options: NSLayoutFormatAlignAllRight
                                                                                    metrics: nil
                                                                                      views: variablesBindings]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"V:|-5-[_sendButton(>=50)]-20-|"
                                                                                    options: 0
                                                                                    metrics: nil
                                                                                      views: variablesBindings]];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"H:|-0-[_receiveButton(>=10)]-(>=50)-|"
                                                                                    options: 0
                                                                                    metrics: 0
                                                                                      views: variablesBindings]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"V:|-5-[_receiveButton(>=50)]-20-|"
                                                                                    options: 0
                                                                                    metrics: nil
                                                                                      views: variablesBindings]];
}

-(void)setMessage:(Message *)message {
    _message = message;
    _timeLabel.text = [message.createdTime timeIntervalToString];
    if (message.isSendMessage) {
        _sendButton.hidden = NO;
        _receiveButton.hidden = YES;
        [_sendButton setTitle:message.text forState:UIControlStateNormal];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor = [UIColor colorWithRed:245 green:166 blue:35 alpha:1.0] ;
    } else {;
        _sendButton.hidden = YES;
        _receiveButton.hidden = NO;
        [_receiveButton setTitle:message.text forState:UIControlStateNormal];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = [UIColor grayColor];
    }
    [self setNeedsLayout];
}
@end
