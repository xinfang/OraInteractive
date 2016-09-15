import XCTest
import UIKit

@testable import OraChat

class MessageTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {

        super.tearDown()
    }
    
    // MARK: Tests
    func testParsingMessageDictionary() {
        let data:[String : AnyObject] = [
                "id": 4,
                "user_id": 1,
                "chat_id": 2,
                "message": "Oh man!",
                "created": "2016-07-14T09:30:21Z",
                "user": [
                    "id": 1,
                    "name": "Andre"
                ]
        ]

        let message : Message = Message(dictionary:data);
        XCTAssertEqual(message.id, data["id"] as? Int, "id code");
        XCTAssertEqual(message.userId, data["user_id"] as? Int, "user id code");
        XCTAssertEqual(message.chatId, data["chat_id"] as? Int, "chat id code");
        XCTAssertEqual(message.text, data["message"] as? String, "message");
        XCTAssertEqual(message.createdTime, data["created"]?.toDateTime(), "create time");
        let userInfo = data["user"] as! [String : AnyObject]
        XCTAssertEqual(message.userInfoId, userInfo["id"] as? Int, "user info id code");
        XCTAssertEqual(message.userName, userInfo["name"] as? String, "user name  code");
    }
}
