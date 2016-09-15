import XCTest
import UIKit

@testable import OraChat

class MessageGroupTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Tests
    func testParsingMessageGroupDictionary() {
        let data:[String : AnyObject] = [
            "id": 2,
            "user_id": 2,
            "name": "A Test 2",
            "created": "2016-07-14T12:30:21Z",
            "user": [
                "id": 2,
                "name": "Dan"
            ],
            "last_message": [
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
        ]
        
        let group : MessageGroup = MessageGroup(dictionary:data);
        
        XCTAssertEqual(group.id, data["id"] as? Int, "id code");
        XCTAssertEqual(group.name, data["name"] as? String, "name code");
        XCTAssertEqual(group.createDate, data["created"]?.toDateTime(), "create time");
        let masterMsg = group.masterMessage
        let lastMsg = group.lastMessage
        XCTAssertEqual(masterMsg!.id, data["id"] as? Int, "master id code");
        let lastMessage = data["last_message"] as! [String : AnyObject]
        XCTAssertEqual(lastMsg!.id, lastMessage["id"] as? Int, "last id code");
    }
}
