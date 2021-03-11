//
//  LoginService.swift
//  Friends
//
//  Created by Nkanyiso Hlela on 2021/03/07.
//

import Foundation

class FriendsService :  BaseAPI {
    
    func getFriends(friendsURL : URL,_ completion: @escaping (Result<FriendsResponseModel, Error>)-> Void){
        jsonAPIGETCall(endpointUrl: friendsURL,decodingType: FriendsResponseModel.self){ (Results) in
            switch(Results){
            case .success(let dataResponse):
                    print(dataResponse)
                    completion(.success(dataResponse))
            case .failure(let error):
                completion(.failure(error))
                print("Failed to login")
            }
        }
        
    }
}
