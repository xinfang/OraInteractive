//#import <XCTest/XCTest.h>
////#import "OraChat-Swift.h"
//
//static NSString *const ORAUserEmailKey = @"ORAUserEmailKey";
//static NSString *const ORAUserIDKey = @"ORAUserIDKey";
//static NSString *const ORAUserUsernameKey = @"ORAUserUsernameKey";
//NSString *const ORAUserServiceName = @"com.orainteractive.chat";
//
//@interface ORAUserTests : XCTestCase {
//    ORAAccount *user;
//    NSUserDefaults *defaults;
//}
//
//@end
//
//@implementation ORAUserTests
//
//- (void)setUp {
//    [super setUp];
//    user = [[User alloc] init];
//
//    defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:nil forKey:ORAUserEmailKey];
//    [defaults setObject:nil forKey:ORAUserUsernameKey];
//    [defaults setObject:nil forKey:ORAUserIDKey];
//    [defaults synchronize];
//}
//
//- (void)tearDown {
//    user = nil;
//    [super tearDown];
//}
//
//- (void)testUserPropertiesNilWhenNotFoundInUserDefaults {
//    XCTAssertNil(user.email, @"Eamil should be nil.");
//    XCTAssertNil(user.password, @"Password should be nil.");
//    XCTAssertNil(user.username, @"Username should be nil.");
//    XCTAssertNil(user.userID, @"UserID should be nil.");
//}
//
//- (void)testSettingEmail {
//    user.email = @"testaccount@gmail.com";
//    XCTAssertEqualObjects([defaults stringForKey:ORAUserEmailKey], user.email, @"email not saving in defaults.");
//}
//
//- (void)testSettingUsername {
//    user.username = @"test account";
//    XCTAssertEqualObjects([defaults stringForKey:ORAUserUsernameKey], user.username, @"username not saving in defaults.");
//}
//
//- (void)testSettingUserID {
////    user.userID = @"91234";
//    XCTAssertEqualObjects([defaults stringForKey:ORAUserIDKey], user.userID, @"id not saving in defaults.");
//}
//
//@end
