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
    case noDataRecived
    case dataDoNotConfromToEntity
    case responseIsNotJSON
    case logicError
    
    // MARK: - Error description
    var description: String {
        switch self {
        case .noDataRecived:
            return "The JSON Data object is empty."
        case .dataDoNotConfromToEntity:
            return "The JSON Object do not conform to payload entity"
        case .responseIsNotJSON:
            return "The Response from the request is not a JSON format. "
        case .logicError:
            return "The Result Boolean value is CONTRADICTORY to the response fromat"
        }
    }
}
