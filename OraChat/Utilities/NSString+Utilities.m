#import "NSString+Utilities.h"

@implementation NSString (Utilities)

- (NSDate *)toDateTime {
    return [self dateFromString:@"yyyy-MM-dd'T'HH:mm:ssZ"];
}

- (NSDate *)dateFromString: (NSString *)formatStyle {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:formatStyle];
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    return [df dateFromString:self];
}

- (BOOL)isValidEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]";
    NSPredicate *emailCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailCheck evaluateWithObject:self];
}
@end


