//
//  Models.swift
//  FBChallenge
//
//  Created by Marwen Jamel on 13/04/19.
//  Copyright © 2019 Marwen Jamel. All rights reserved.
//

import Foundation

// MARK: - Success_Case Entity
struct SuccessCase {
    typealias JSONDictionary = [String:Any]
    var result: Bool
    var payload: Any
    init(result: Bool,payload: Any) {
        self.result = result
        self.payload = payload
    }
    
}

// MARK: - Failure_Case Entity
struct FailureCase {
    var result: Bool
    var message: String
    
    init(result: Bool,message: String) {
        self.result = result
        self.message = message
    }
    
    
}
