//
//  FriendsViewModel.swift
//  Friends
//
//  Created by Nkanyiso Hlela on 2021/03/07.
//

import Foundation
class FriendsViewModel{
    var friendsList : [FriendsModel] = [FriendsModel]()
    var friendsListRequest : LiveData<RequestStatus> = LiveData(RequestStatus.non)
    func getFriendsList(){
        let friend = FriendsModel.init(image: "", alias_name: "Alias Name", last_online: "10/03/2021")
        friendsList = [friend]
        friendsListRequest.value = .success
    }
}
