import Foundation

let CurrentUserDataKey = "ora.userdata"
@objc class User: NSObject {
    var email: NSString?
    var name: NSString?
    var userID: Int?
    var token: NSString?
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        email = dictionary["email"] as? String
        name = dictionary["name"] as? String
        token = dictionary["token"] as? String
        userID = dictionary["id"] as? Int
    }
    
    static var _currentUser: User?
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = NSUserDefaults.standardUserDefaults()
                let userData = defaults.objectForKey(CurrentUserDataKey) as? NSData
                if let userData = userData {
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            let defaults = NSUserDefaults.standardUserDefaults()
            if let user = user {
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                defaults.setObject(data, forKey: CurrentUserDataKey)
            }else {
                defaults.setObject(nil, forKey: CurrentUserDataKey)
            }
            //defaults.synchronize()
        }
    }
}