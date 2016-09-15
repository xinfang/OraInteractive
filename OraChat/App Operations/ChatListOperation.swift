import Foundation

class ChatListOperation : GenericOperation<[String : AnyObject], [MessageGroup]> {
    override var URLPath: String {
        return "/chats"
    }
    
    override var queryItems: [NSURLQueryItem]? {
        get {
            return [NSURLQueryItem(name: "q", value: "Chat"),
                    NSURLQueryItem(name: "page", value: "1"),
                    NSURLQueryItem(name: "page", value: "20")]
        }
    }
    
    override var operationName: String {
        return "Chat Group"
    }
    
    required init(sessionManager: URLSessionManager, taskCompletionCallback: ([MessageGroup]?) -> Void) {
        super.init(sessionManager: sessionManager, taskCompletionCallback: taskCompletionCallback)
    }
    
    override func parseJSONData(data: [String : AnyObject]) -> [MessageGroup]? {
        var groups:[MessageGroup] = []
        if let result = data["data"] as? [AnyObject] {
            if let dataArray = result as? Array<Dictionary<String, AnyObject>>{
                for data in dataArray{
                    if let mg: MessageGroup = MessageGroup(dictionary: data) {
                        groups.append(mg)
                    }
                }
            }
            return groups
        }
        return nil
    }
}