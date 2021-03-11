//
//  FriendsResponse.swift
//  Friends
//
//  Created by Nkanyiso Hlela on 2021/03/09.
//

import Foundation

struct FriendsResponseModel :Decodable{
    var result : Bool
    var friends: [FriendModel]?
}


