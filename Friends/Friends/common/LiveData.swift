//
//  LiveData.swift
//  Friends
//
//  Created by Nkanyiso Hlela on 2021/03/09.
//

import Foundation
class LiveData<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func observe(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
