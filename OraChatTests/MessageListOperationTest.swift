import XCTest
//import AppleOperations

@testable import OraChat

class MessageListOperationTests: XCTestCase {
    
    //var wireMockManager: MobileWireMockManager?
    
    var callCompleted = false
    
    override func setUp() {
        super.setUp()
        //wireMockManager = MobileWireMockManager.makeWireMockManager()
    }
    
    override func tearDown() {
        //wireMockManager!.resetWireMock()
        super.tearDown()
    }
    
    func testFetchMessageList() {
        //wireMockManager!.postStub("message-list.json")
        //let sessionManager = URLSessionManager(baseURL: "http://localhost:8080")

//        let listOp = MessageListOperation(chatID: 2, page: 1) { (data, error) in
//            XCTAssertEqual(data?.count, 2)
//            self.callCompleted = true
//        }
//        
//        let operationQueue = OperationQueue()
//        operationQueue.addOperation(listOp)
//        
//        let predicated = NSPredicate(format: "callCompleted == YES")
//        expectationForPredicate(predicated, evaluatedWithObject: self, handler: nil)
//        waitForExpectationsWithTimeout(5) { error in
//            if let _ = error {
//                XCTFail()
//            }
//        }
    }
}
