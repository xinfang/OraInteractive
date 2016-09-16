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
        let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiZXhwIjoxNDM0NDY3NDUxfQ.Or5WanRwK1WRqqf4oeIkAHRYgNyRssM3CCplZobxr4w"
        let data:[String : AnyObject] = [
            "id": 1,
            "token": token,
            "email": "andre@orainteractive.com",
            "name": "Andre"
        ]
        
        let user : User = User(dictionary:data)
        XCTAssertEqual(user.userID, 1, "id code");
        XCTAssertEqual(user.name, "Andre", "name code");
        XCTAssertEqual(user.email,"andre@orainteractive.com", "email");
        XCTAssertEqual(user.token, token, "email");
    }
}
