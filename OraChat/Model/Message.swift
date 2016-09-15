import Foundation

@objc enum AuthorType: UInt {
    case AuthorTypeSender = 0, AuthorTypeReceiver
}

@objc class Message : NSObject {
    var id: Int?
    var userId: Int?
    var chatId: Int?
    var text: NSString?
    var createdTime: NSDate?
    var userInfoId: Int?
    var userName: NSString?
    var isSendMessage: Bool = false
    
    init(dictionary: [String : AnyObject]) {
        id = dictionary["id"] as? Int ?? nil
        userId = dictionary["user_id"] as? Int ?? nil
        if userId == User.currentUser?.userID {
            isSendMessage = true
        }
        chatId = dictionary["chat_id"] as? Int ?? nil
        text = dictionary["message"] as? String ?? ""
        if let date = dictionary["created"] as? String {
            createdTime = date.toDateTime()
        }
        
        if let userInfo = dictionary["user"] as? [String : AnyObject] {
            userInfoId = userInfo["id"] as? Int ?? nil
            userName = userInfo["name"] as? String ?? ""
        } else {
            userInfoId = nil
            userName = ""
        }
        
    }
}