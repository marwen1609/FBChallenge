//
//  PayloadErrors.swift
//  FBChallenge
//
//  Created by Marwen Jamel on 14/04/19.
//  Copyright © 2019 Marwen Jamel. All rights reserved.
//

import Foundation

enum PayloadErrors: Error, CustomStringConvertible {
    
    // MARK: - Members
    case NoDataRecived
    case DataDoNotConfromToEntity
    case ResponseIsNotJSON
    case LogicError
    
    // MARK: - Error description
    var description: String {
        switch self {
        case .NoDataRecived:
            return "The JSON Data object is empty."
        case .DataDoNotConfromToEntity:
            return "The JSON Object do not conform to payload entity"
        case .ResponseIsNotJSON:
            return "The Response from the request is not a JSON format. "
        case .LogicError:
            return "The Result Boolean value is CONTRADICTORY to the response fromat"
        }
    }
}
