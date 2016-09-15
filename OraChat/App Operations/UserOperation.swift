import Foundation

typealias UserOperationCallback = (User?, NSError?) -> Void

@objc class UserOperation : GroupOperation {
    
    convenience init(email: String, password: String, username: String, taskCompletionCallback:(User?, NSError?) -> Void) {
        let postData = ["email": email, "password": password, "confirm": password, "name": username]
               self.init(urlPath: "/users/register", params: postData, sessionManager: URLSessionManager.SharedSessionManager, taskCompletionCallback: taskCompletionCallback)
        name = "Register"
    }
    
    convenience init(email: String, password: String, taskCompletionCallback: (User?, NSError?) -> Void) {
        let postData = ["email": email, "password": password]
        self.init(urlPath: "/users/login", params: postData, sessionManager: URLSessionManager.SharedSessionManager, taskCompletionCallback: taskCompletionCallback)
        name = "Login"
    }
    
    init(urlPath: String, params: [String: String], sessionManager: URLSessionManager, taskCompletionCallback: (User?, NSError?) -> Void) {
        let task = sessionManager.postDataTaskWithURLPath(urlPath, data: params) { (data, response, error) in
            var errForCallback: NSError?
            var userForCallback: User?
            
            defer {
                taskCompletionCallback(userForCallback, errForCallback)
            }
            
            guard error == nil else {
                print("got an error:  \(error)")
                errForCallback = error
                return
            }
            
            guard let httpStatus = response as? NSHTTPURLResponse else {
                errForCallback = NSError(domain: "LoginOperation",code: 8888, userInfo: nil)
                return
            }
            
            guard httpStatus.statusCode == 200 else {
                errForCallback = NSError(domain: "LoginOperation",code:  httpStatus.statusCode, userInfo: nil)
                return
            }
            
            guard let responseData = data else {
                print("Error:  did not receive data")
                return
            }
            
            do {
                let jsonData = try NSJSONSerialization.JSONObjectWithData(responseData, options: [])
                if let userData = jsonData["data"] as? [String : AnyObject] {
                    userForCallback = User(dictionary: userData)
                }
            } catch {
                print("failed to read JSON from '\(responseData)'")
                errForCallback = NSError(domain: "LoginOperation", code: 8889, userInfo: nil)
            }
        }
        super.init(operations: [URLSessionTaskOperation(task: task)])
    }
}