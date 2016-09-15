import XCTest
//import MobileWireMockManager

extension XCTestCase {
    
    func waitForElementToAppear(element: XCUIElement, timeOut:Int) {
        let predicate = NSPredicate(format: "hittable == true")
        expectationForPredicate(predicate, evaluatedWithObject: element, handler: nil)
        waitForExpectationsWithTimeout(NSTimeInterval(timeOut)) { (error) -> Void in
            if error != nil {
                let message = "failed to find \(element)"
                self.recordFailureWithDescription(message, inFile: #file, atLine: #line, expected: true)
            }
        }
    }
}

public class ORATestCase: XCTestCase {
    
    let UIWaitTime = UInt32(1)
    let EmDash = "—"
    //var wireMockManager: MobileWireMockManager!
    let app = XCUIApplication()
    var launchEnvironment = ["isUITest": "true", "shouldClearUserDefaults" : "true"]
    
    override public func setUp() {
        super.setUp()
        //wireMockManager = MobileWireMockManager.makeWireMockManager()
        continueAfterFailure = false
    }
    
    override public func tearDown() {
        //wireMockManager.resetWireMock()
        super.tearDown()
    }
    
    func launchApp() {
        app.launchEnvironment = launchEnvironment
        app.terminate()
        app.launch()
        sleep(UIWaitTime)
    }
    
    func useStubs(stubNames: [String]) {
//        for stubName in stubNames {
//            wireMockManager!.postStub(stubName)
//        }
    }
    
    func isRunningOnPhone() -> Bool {
        return UIDevice.currentDevice().userInterfaceIdiom == .Phone
    }
}
