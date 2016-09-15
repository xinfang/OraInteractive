#import <Foundation/Foundation.h>

@interface NSString (Utilities)
- (NSDate *)dateFromString: (NSString *)formatStyle;
- (NSDate *)toDateTime;
- (BOOL)isValidEmail;
@end
