//
//  LoginService.swift
//  Friends
//
//  Created by Nkanyiso Hlela on 2021/03/07.
//

import Foundation

class FriendsService :  BaseAPI {
    
    func getFriends(friendsURL : URL,_ completion: @escaping (Result<String, Error>)-> Void){
        jsonAPIGETCall(endpointUrl: friendsURL){ (Results) in
            switch(Results){
            case .success(let dataResponse):
    
                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(UserModel.self, from:
                                                    Data(dataResponse.utf8)) //Decode JSON Response Data
                    
                    print(dataResponse)
                    completion(.success(dataResponse))
                } catch let parsingError {
                    print("Error", parsingError)
                    completion(.failure(RequestError.failedToConvertData))
                }
            case .failure(let error):
                completion(.failure(error))
                print("Failed to login")
            }
        }
        
    }
}
