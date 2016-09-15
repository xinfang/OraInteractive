import Foundation

typealias ChatOperationCallback = (MessageGroup?, NSError?) -> Void

class ChatOperation : GroupOperation {
    //let queryItems = [NSURLQueryItem(name: "chat_id", value: "1"), NSURLQueryItem(name: "page", value: "1"), NSURLQueryItem(name: "limit", value: "20")]
    init(urlPath: String, params: [String: String], sessionManager: URLSessionManager, taskCompletionCallback: (MessageGroup?, NSError?) -> Void) {
        let task = sessionManager.postDataTaskWithURLPath(urlPath, data: params) { (data, response, error) in
            var errForCallback: NSError?
            var taskForCallback: MessageGroup?
            
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
                if let userData = jsonData["data"] as? [String : AnyObject] {
                    taskForCallback = MessageGroup(dictionary: userData)
                }
            } catch {
                print("failed to read JSON from '\(responseData)'")
            }
        }
        super.init(operations: [URLSessionTaskOperation(task: task)])
    }
}