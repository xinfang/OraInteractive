import Foundation

typealias MessageListOperationCallback = ([Message]?, NSError?) -> Void

@objc class MessageListOperation : GroupOperation {
    convenience init(chatID: Int, page: Int, taskCompletionCallback:MessageListOperationCallback) {
        let pageQuery = NSURLQueryItem(name: "page", value: String(page))
        let limitQuery = NSURLQueryItem(name: "limit", value: "20")
        self.init(urlPath: "/chats/\(chatID)/messages", params:  [pageQuery, limitQuery], sessionManager: URLSessionManager.SharedSessionManager, taskCompletionCallback: taskCompletionCallback)
        name = "Register"
    }
    
    init(urlPath: String, params: [NSURLQueryItem], sessionManager: URLSessionManager, taskCompletionCallback: MessageListOperationCallback) {
        let task = sessionManager.getDataTaskWithURLPath(urlPath, queryItems: params) { (data, response, error) in
            var errForCallback: NSError?
            var taskForCallback: [Message]?
            
            defer {
                taskCompletionCallback(taskForCallback, errForCallback)
            }
            
            guard error == nil else {
                print("got an error:  \(error)")
                errForCallback = error
                return
            }
            
            guard let responseData = data else {
                print("Error:  did not receive data")
                return
            }
            
            do {
                let jsonData = try NSJSONSerialization.JSONObjectWithData(responseData, options: [])
                if let dataArray = jsonData["data"] as? Array<Dictionary<String, AnyObject>> {
                    var groups:[Message] = []
                    for data in dataArray {
                        if let mg: Message = Message(dictionary: data) {
                            groups.append(mg)
                        }
                    }
                    taskForCallback = groups
                }
            } catch {
                print("failed to read JSON from '\(responseData)'")
            }
        }
        super.init(operations: [URLSessionTaskOperation(task: task)])
    }
}

//import Foundation
//
//@objc class MessageListOperation : GenericOperation<[String : AnyObject], [Message]> {
//    
//    override var URLPath: String {
//        return "chats/1/messages?page=1&limit=20"
//    }
//    
//    override var operationName: String {
//        return "Message List"
//    }
//    
//    required  init(sessionManager: URLSessionManager, taskCompletionCallback: ([Message]?) -> Void) {
//        super.init(sessionManager: sessionManager, taskCompletionCallback: taskCompletionCallback)
//    }
//
//    override func parseJSONData(data: [String : AnyObject]) -> [Message]? {
//        var groups:[Message] = []
//        if let result = data["data"] as? [AnyObject] {
//            if let dataArray = result as? Array<Dictionary<String, AnyObject>>{
//                for data in dataArray{
//                    if let mg: Message = Message(dictionary: data) {
//                        groups.append(mg)
//                    }
//                }
//            }
//            return groups
//        }
//        return nil
//    }
//}