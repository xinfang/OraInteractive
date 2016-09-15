import Foundation

typealias MessageOperationCallback = (Message?, NSError?) -> Void

class MessageOperation : GroupOperation {
    init(urlPath: String, params: [String: String], sessionManager: URLSessionManager, taskCompletionCallback: (Message?, NSError?) -> Void) {
        let task = sessionManager.postDataTaskWithURLPath(urlPath, data: params) { (data, response, error) in
            var errForCallback: NSError?
            var taskForCallback: Message?
            
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
                    taskForCallback = Message(dictionary: userData)
                }
            } catch {
                print("failed to read JSON from '\(responseData)'")
            }
        }
        super.init(operations: [URLSessionTaskOperation(task: task)])
    }
}