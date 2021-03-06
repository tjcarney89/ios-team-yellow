///
/// FacebookUser.swift
///

import SwiftyJSON

struct FacebookUser: Equatable {
    
    let id: String
    let name: String
    let imageUrl: URL?
    
    init(_ json: JSON) {
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue.firstWord
        let urlString = json["picture"]["data"]["url"].stringValue
        self.imageUrl = URL(string: urlString)
    }
    
    var hashValue: String {
        return id
    }
    
    static func ==(lhs: FacebookUser, rhs: FacebookUser) -> Bool {
        return lhs.id == rhs.id
    }
}
