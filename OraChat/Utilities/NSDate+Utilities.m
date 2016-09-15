#import "NSDate+Utilities.h"

static const unsigned componentFlags = (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute);

@implementation NSDate (Utilities)

+ (NSCalendar *) currentCalendar
{
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar)
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    return sharedCalendar;
}

#pragma mark - String Properties
- (NSString *) stringWithFormat: (NSString *) format {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

- (NSString *) stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle = dateStyle;
    formatter.timeStyle = timeStyle;
    return [formatter stringFromDate:self];
}

#pragma mark - Comparing Dates

- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate {
    NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (BOOL) isToday {
    return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (NSString *)timeIntervalToString {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:componentFlags fromDate:self toDate:[NSDate date] options:0];
    
    NSInteger years = [components year];
    NSInteger months = [components month];
    NSInteger days = [components day];
    NSInteger hours = [components hour];
    NSInteger mins = [components minute];
    
    NSMutableString *s = [NSMutableString string];
    if (years > 0) {
        return [NSString stringWithFormat:@"%ld years ago", (long)years];
    }
    if (months > 0) {
        return [NSString stringWithFormat:@"%ld months ago", (long)months];
    }
    if (days > 0) {
        [s appendFormat:@"%ld days ", (long)days];
    }
    if (hours > 0) {
        [s appendFormat:@"%ld hours ", (long)hours];
    }
    if (mins > 0) {
        [s appendFormat:@"%ld mins", (long)mins];
    }
    return s;
}
@end
