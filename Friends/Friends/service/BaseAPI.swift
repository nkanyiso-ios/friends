//
//  BaseAPI.swift
//  Friends
//
//  Created by Nkanyiso Hlela on 2021/03/08.
//

import Foundation

class BaseAPI {
    func jsonAPIPostCall(parameter:Data ,_ completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = WebUrl.loginUrl
        
        guard let endpointUrl = URL(string: endpoint) else {
            completion(.failure(RequestError.invalidURL))
            return
        }
        do {
            var request = URLRequest(url: endpointUrl)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let session = URLSession.shared
            let task  = session.uploadTask(with: request,from: parameter){ data, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    if(httpResponse.statusCode == 200){
                        if let data = data, let dataString = String(data: data, encoding: .utf8) {
                            print(dataString)
                            completion(.success(dataString))
                        }else{
                            completion(.failure(RequestError.failedToLogin))
                        }
                    }else{
                        completion(.failure(RequestError.failedToLogin))
                    }
                }else{
                    completion(.failure(RequestError.failedToLogin))
                }
                
                
                
            }
            
            task.resume()
            
        }
    }
}
