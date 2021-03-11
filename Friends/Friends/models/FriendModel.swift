//
//  FriendsModel.swift
//  Friends
//
//  Created by Nkanyiso Hlela on 2021/03/09.
//

import Foundation

struct FriendModel : Decodable{
    var firstName: String
    var lastName : String
    var alias : String
    var dateOfBirth : String
    var status : String
    var imageURL : String
}
