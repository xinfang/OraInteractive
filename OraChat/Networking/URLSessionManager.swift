import Foundation
import UIKit

let ORABaseUrlEnvironment = "http://private-anon-fe67dd175d-oracodechallenge.apiary-proxy.com"

class URLSessionManager {
    
    static let SharedSessionManager = URLSessionManager()
    
    private var baseURL: NSURL
    private var session: NSURLSession
    private var config = NSURLSessionConfiguration.defaultSessionConfiguration()
    private let notification = NSNotificationCenter.defaultCenter()
  
    init() {
        self.baseURL = NSURL(string: ORABaseUrlEnvironment)!
        self.session = NSURLSession(configuration: config)
//        notification.addObserverForName("eventUserLogin", object: nil, queue: nil) { (notification) in
//            //self.setURLSessionWithAuthToken()
//        }
    }
    
    convenience init(baseURL: String) {
        self.init()
        self.baseURL = NSURL(string: baseURL)!
    }

    func setAuthTokenWithRequest(request: NSMutableURLRequest) {
        if let authToken = User.currentUser?.token  where !authToken.isEmpty {
            request.setValue(authToken, forHTTPHeaderField: "Authorization")
        }
    }
    
    func getDataTaskWithURLPath(path: String, queryItems: [NSURLQueryItem]?, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask {
        let components = NSURLComponents(URL: baseURL.URLByAppendingPathComponent(path), resolvingAgainstBaseURL: false)!
        components.queryItems = queryItems
        let url = components.URL!
        
        print("preparing to call \(url)")

        let urlRequest = NSMutableURLRequest(URL: url)
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
         self.setAuthTokenWithRequest(urlRequest)
        return session.dataTaskWithRequest(urlRequest, completionHandler: completionHandler)
    }
    
    func postDataTaskWithURLPath(path: String, data: [String: String], completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask {
        let components = NSURLComponents(URL: baseURL.URLByAppendingPathComponent(path), resolvingAgainstBaseURL: false)!
        let url = components.URL!
        
        print("preparing to call \(url)")
        
        let urlRequest = NSMutableURLRequest(URL: url)
        urlRequest.HTTPMethod = "POST"
        
        do {
            urlRequest.HTTPBody = try NSJSONSerialization.dataWithJSONObject(data, options: [])
            urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            self.setAuthTokenWithRequest(urlRequest)
        } catch let dataError {
            print(dataError)
            urlRequest.HTTPBody = nil
        }
        
        return session.dataTaskWithRequest(urlRequest, completionHandler: completionHandler)
    }
    
//    deinit {
//        NSNotificationCenter.defaultCenter().removeObserver(self)
//    }
    
//    func setURLSessionWithAuthToken() {
//        if let authToken = User.currentUser?.token as? String where !authToken.isEmpty {
//            config.HTTPAdditionalHeaders = ["Authorization" : authToken]
//        }
//        self.session = NSURLSession(configuration: self.config)
//    }
}
