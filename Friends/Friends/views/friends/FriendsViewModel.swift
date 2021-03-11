//
//  FriendsViewModel.swift
//  Friends
//
//  Created by Nkanyiso Hlela on 2021/03/07.
//

import Foundation

class FriendsViewModel{
    var errorMsg : String?
    var friendsResult : LiveData<RequestStatus> = LiveData(RequestStatus.non)
    let friendsService = FriendsService()
    var friendsList : [FriendModel]? = [FriendModel]()
//    func getFriendsList(){
//        let friend = FriendModel.init(firstName: "My My", lastName: "Last Last", alias: "Alias Name", dateOfBirth: "10/03/2021", status: <#T##String#>)
//        friendsList = [friend]
//        friendsResult.value = .success
//    }
    func getFriendsList(){
        let defaults = UserDefaults.standard
        let usrFirstname = defaults.string(forKey: Keys.firstName)
        let usrGuid = defaults.string(forKey: Keys.guid)
        if let name = usrFirstname   , let guid = usrGuid   {
            
        
        let url = createFriendsURL(firstname: name, uniqueId: guid)
        friendsService.getFriends(friendsURL: url!) { (Results) in
            switch Results{
            
            case .success(let data):
                print(data)
                if(data.result){
                    self.friendsList = data.friends 
                    self.friendsResult.value = .success
                }else{
                    self.friendsResult.value = .failed
                }
                
            case .failure( let error):
                print(error.localizedDescription)
                self.errorMsg = error.localizedDescription
                self.friendsResult.value = .failed
            }
        }
        }else{
            self.errorMsg = "Unable to retrieve user details, please try re login."
            self.friendsResult.value = .failed
            
        }
    }
    
    func createFriendsURL(firstname: String, uniqueId : String) -> URL? {
        let  Url = URL(string: WebUrl.friendsUrlScheme + "://" + WebUrl.friendsUrlHost + WebUrl.friendsUrlPath + "?uniqueID="+uniqueId+";name=" + firstname)
        
        return Url
    }
}
