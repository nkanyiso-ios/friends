//
//  Extensions.swift
//  Friends
//
//  Created by Nkanyiso Hlela on 2021/03/08.
//

import Foundation
import UIKit
struct JSON {
    static let encoder = JSONEncoder()
}
extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSON.encoder.encode(self))) as? [String: Any] ?? [:]
    }
}


