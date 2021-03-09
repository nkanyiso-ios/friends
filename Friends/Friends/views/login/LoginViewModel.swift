//
//  LoginViewModel.swift
//  Friends
//
//  Created by Nkanyiso Hlela on 2021/03/07.
//

import Foundation

class LoginViewModel{
    let loginService = LoginService()
    var loginResult : LiveData<LoginStatus> = LiveData(LoginStatus.non)
    var errorMsg : Error = ValidationError.non
    func doLogin(usernameString: String,passwordString: String){
        self.validateLoginInput(username: usernameString,password: passwordString){ (Results) in
            switch(Results){
            case .success(_):
                let loginRequest = LoginRequestModel.init(username: usernameString, password: passwordString)
                let loginRequestData = try! JSONEncoder().encode(loginRequest)
                self.doAPICall(loginData : loginRequestData)
            case .failure(let error):
                self.errorMsg = error
                self.loginResult.value = LoginStatus.failed
                
            }
        }
    }
    func validateLoginInput(username:String,password:String,_ completion: @escaping (Result<Bool, Error>) -> Void){
        
        if(username.isEmpty || username.count < 4){
            completion(.failure(ValidationError.invalidUsername))
        }else if(password.isEmpty || password.count < 3){
            completion(.failure(ValidationError.invalidPassword))
        }else{
            completion(.success(true))
        }
    }
    func doAPICall(loginData : Data){
        loginService.doLogin(loginData: loginData){ [self](Results) in
            switch(Results){
            
            case .success(let dataResponse):
                if(dataResponse.result){
                    saveUserDetails(userModel: dataResponse)
                    loginResult.value = LoginStatus.success
                }else{
                    errorMsg =  RequestError.incorrectCredentials
                    loginResult.value = LoginStatus.failed
                   
                }
            case .failure(let error):
                errorMsg =  error
                loginResult.value = LoginStatus.failed
                
            }
        }
    }
    func saveUserDetails(userModel : UserModel){
        let defaults = UserDefaults.standard
        defaults.setValue(userModel.firstName, forKey: Keys.firstName)
        defaults.setValue(userModel.lastName, forKey: Keys.lastName)
        defaults.setValue(userModel.result, forKey: Keys.loginResults)
        defaults.setValue(userModel.guid, forKey: Keys.guuid)
    }
}
