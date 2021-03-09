//
//  Constants.swift
//  Friends
//
//  Created by Nkanyiso Hlela on 2021/03/08.
//

import Foundation

struct Keys{
    static let loginResults = "login_result"
    static let lastName = "lastName"
    static let firstName = "firstName"
    static let guuid = "guid"
}
struct WebUrl{
    static let loginUrl = "http://mobileexam.dstv.com/login"
    static let friendsUrlScheme = "http"
    static let friendsUrlHost = "mobileexam.dstv.com"
    static let friendsUrlPath = "/friends.php"
}

enum RequestError: Error {
    case invalidURL
    case failedToLogin
    case failedToConvertData
    case incorrectCredentials
}
enum ValidationError: Error {
    case invalidUsername
    case invalidPassword
    case failedToConvertData
    case non

}
enum RequestStatus :String {
    case success
    case failed
    case loading
    case non
}

extension RequestError: LocalizedError {
    var errorDescription: String? {
        switch self {
       
        case .invalidURL:
            return NSLocalizedString(
                "Invalid URL.",
                comment: ""
            )
        case .failedToLogin:
            return NSLocalizedString(
                "Uknown error occured trying to login",
                comment: ""
            )
        case .failedToConvertData:
            return NSLocalizedString(
                "Failed to convert returned data.",
                comment: ""
            )
        case .incorrectCredentials:
            return NSLocalizedString(
                "Invalid user or password.",
                comment: ""
            )
        }
    }
}
extension ValidationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUsername:
            return NSLocalizedString(
                "You entered an invalid username, minimum of 3 characters.",
                comment: ""
            )
        case .invalidPassword:
            return NSLocalizedString(
                "You entered an invalid password.",
                comment: ""
            )
        case .failedToConvertData:
            return NSLocalizedString(
                "Your username can't be longer than 14 characters",
                comment: ""
            )
        case .non:
            return NSLocalizedString(
                "None",
                comment: ""
            )
        }
    }
}
