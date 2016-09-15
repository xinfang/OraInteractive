import XCTest
import UIKit

@testable import OraChat

class UserTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Tests
    func testParsingUserDictionary() {
        let data:[String : AnyObject] = [
            "id": 1,
            "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiZXhwIjoxNDM0NDY3NDUxfQ.Or5WanRwK1WRqqf4oeIkAHRYgNyRssM3CCplZobxr4w",
            "email": "andre@orainteractive.com",
            "name": "Andre"
        ]
        
        let user : User = User(dictionary:data)
        XCTAssertEqual(user.userID, data["id"] as? Int, "id code");
        XCTAssertEqual(user.name, data["name"] as? String, "name code");
        XCTAssertEqual(user.email, data["email"] as? String, "email");
    }
}
