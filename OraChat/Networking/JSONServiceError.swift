import Foundation

class JSONServiceError : NSError {
    
    enum ErrorType : Int {
        case General
        case Parse
    }
    
    init(operationName: String, errorType: ErrorType) {
        super.init(domain: "ORA.\(operationName).\(errorType)Error", code: errorType.rawValue, userInfo: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}