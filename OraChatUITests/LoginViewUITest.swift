import XCTest

class LoginViewUITests: ORATestCase {
    
    var tablesQuery: XCUIElementQuery? = nil
    var searchFieldQuery: XCUIElement? = nil
    
    override func setUp() {
        super.setUp()
        launchApp()
    }
    
    func testLoginView() {
        //wireMockManager.postStub("user-login-result.json")
        //let foResults = ["name" : "testName", "id": 1]
        let loginView = XCUIApplication().otherElements["OUILoginView"];
        XCTAssert(loginView.exists)
        XCTAssert(XCUIApplication().staticTexts["OUIEmail"].exists)
        XCTAssert(XCUIApplication().staticTexts["OUIPassword"].exists)
//        loginButton.tap()

    }
    func testLoginButton() {
 //       let loginButton =  XCUIApplication().buttons["OUIPassword"]
        //loginButton.tap()
    }
}
