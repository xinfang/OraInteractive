import Foundation

@objc class MessageGroup : NSObject {
    var id: Int?
    var name: String?
    var createDate: NSDate?
    var masterMessage: Message?
    var lastMessage: Message?
    
    init(dictionary: [String : AnyObject]) {
        id = dictionary["id"] as? Int ?? nil
        if let date = dictionary["created"] as? String {
            createDate = date.toDateTime()
        }
        name = dictionary["name"] as? String ?? ""
        masterMessage = Message(dictionary: dictionary)

        
        
        if let lastMessageData = dictionary["last_message"] as? [String : AnyObject] {
            lastMessage = Message(dictionary: lastMessageData)
        }
    }

}