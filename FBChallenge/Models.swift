//
//  Models.swift
//  FBChallenge
//
//  Created by Marwen Jamel on 13/04/19.
//  Copyright © 2019 Marwen Jamel. All rights reserved.
//

import Foundation

struct SuccessCase: Decodable {
    
    var result: JSONValue?
    let payload: JSONValue?
    
    private enum CodingKeys: String, CodingKey {
        case result = "result"
        case payload = "payload"
    }
}

struct FailureCase: Decodable {
    
    var result: JSONValue?
    let message: String?
    
    private enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
    }
}
