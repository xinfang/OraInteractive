import Foundation


class GenericOperation<E,T> : GroupOperation {
    
    private let sessionManager: URLSessionManager
    private let taskCompletionCallback: (T?) -> Void
    private var URLTaskOperation: URLSessionTaskOperation!
    private var urlPath: String = ""
    private var postDictionary: [String: String]?
    
    var URLPath: String {
        get {
            fatalError("override GenericOperation.URLPath")
        }
    }
    
    var queryItems: [NSURLQueryItem]? {
        get {
            return nil
        }
    }
    
    var operationName: String {
        fatalError("override GenericOperation.operationName")
    }
    
    var authToken: String? {
        get {
            return nil
        }
    }
    
    required init(sessionManager: URLSessionManager, taskCompletionCallback: (T?) -> Void) {
        self.sessionManager = sessionManager
        self.taskCompletionCallback = taskCompletionCallback
        super.init(operations: [])
        addOperation(createURLSessionTaskOperation(taskCompletionCallback))
        name = operationName
    }

    private final func createURLSessionTaskOperation(taskCompletionCallback: (T?) -> Void) -> URLSessionTaskOperation {
        let task = sessionManager.getDataTaskWithURLPath(URLPath, queryItems: queryItems) { (data, response, error) in
            do {
                guard error == nil else {
                    throw error!
                }
                
                guard let HTTPResponse = response as? NSHTTPURLResponse where HTTPResponse.statusCode == 200, let responseData = data else {
                    throw JSONServiceError(operationName: self.operationName, errorType: .General)
                }
                
                if let JSONObject = try NSJSONSerialization.JSONObjectWithData(responseData, options: []) as? E, let parsedObject: T = self.parseJSONData(JSONObject) {
                    taskCompletionCallback(parsedObject)
                    self.finish()
                    self.URLTaskOperation.finish()
                } else {
                    throw JSONServiceError(operationName: self.operationName, errorType: .Parse)
                }
            } catch let e as NSError {
                if e.domain == "NSCocoaErrorDomain" && e.code == 3840 {
                    self.finishWithError(JSONServiceError(operationName: self.operationName, errorType: .Parse))
                } else {
                    self.finishWithError(e)
                }
                self.URLTaskOperation.finish()
            }
        }
        
        URLTaskOperation = URLSessionTaskOperation(task: task)
        return URLTaskOperation
    }
    
    func parseJSONData(data: E) -> T? {
        fatalError("override GenericOperation.parseJSONData")
    }
    
}
