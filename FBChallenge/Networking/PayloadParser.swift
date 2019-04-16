//
//  PayloadParser.swift
//  FBChallenge
//
//  Created by Marwen Jamel on 14/04/19.
//  Copyright © 2019 Marwen Jamel. All rights reserved.
//

import Foundation

class PayloadParser {
    
    // MARK: - Properties
    typealias JSONDictionary = [String:Any]
    
    /// This methode parse the json data and returns the message or the payload json object otherwise returns nil 
    ///
    /// - Parameter data: Data Object returned from JSON string
    /// - Returns: JSON object for "payload" key, or nil if operation failed or the data is incorrect.
    func payload(from data: Data?) throws -> Any? {
        
        do {
            if let data = data {
                if let challengeData = try jsonDecodeSuccessCase(from: data) {
                    return challengeData.payload
                }else if let challengeData = try jsonDecodeFailureCase(from: data) {
                    return challengeData.message
                }
            } else {
                throw PayloadErrors.noDataRecived
            }
        } catch let error as PayloadErrors {
            print(error.description)
        }
        return nil
    }
    
    // MARK: - Failure_Case data decoder
   private func jsonDecodeFailureCase(from data: Data?) throws -> FailureCase? {
        do{
            if let parsedData = try JSONSerialization.jsonObject(with: data!) as? JSONDictionary {
                if let result = bool(parsedData["result"]) {
                    if result == false {
                        let message = parsedData["message"] as? String
                        if let message = message {
                            return FailureCase(result: result, message: message)
                        }
                    }else {
                        throw PayloadErrors.logicError
                    }
                }else {
                    throw PayloadErrors.dataDoNotConfromToEntity
                }
            }else{
                throw PayloadErrors.responseIsNotJSON
            }
        }catch let error as PayloadErrors {
            debugPrint(error.description)
        }
        return nil
        
    }
    
    // MARK: - Success_Case data decoder
   private func jsonDecodeSuccessCase(from data: Data?) throws -> SuccessCase? {
        do{
            if let parsedData = try JSONSerialization.jsonObject(with: data!) as? JSONDictionary {
                let result = bool(parsedData["result"])
                if let result = result {
                    if result == true  {
                        if let payload = parsePayloadToJSONDictionary(parsedData["payload"]) {
                            return SuccessCase(result: result, payload: payload)
                        } else if let payload = parsePayloadToArray(parsedData["payload"]) {
                            return SuccessCase(result: result, payload: payload)
                        }else if let payload = parsedData["payload"] {
                            return SuccessCase(result: result, payload: payload)
                        }
                    } else if let _ = parsedData["payload"] {
                        throw PayloadErrors.logicError
                    }
                } else{
                    throw PayloadErrors.dataDoNotConfromToEntity
                }
            } else {
                throw PayloadErrors.responseIsNotJSON
            }
        } catch let error as PayloadErrors {
            debugPrint(error.description)
        }
        return nil
    }
    
    // MARK: - Boolean Conversion of the "result" retuned object
  private func bool(_ value: Any?) -> Bool? {
        
        if let value = value as? Bool {
            return value
        } else if let value = value as? Int {
            return value > 0
        } else if let value = value as? String {
            return value.bool
        }
        return nil
    }
    
    // MARK: - Parse of "payload" if it contains an array
    private func parsePayloadToArray(_ value: Any?) -> [Any]? {
        var returnedArray: [Any] = []
        if let values = value as? [Any]{
            for item in values{
                if let item = item as? Bool{
                    returnedArray.append(item)
                } else if let item = item as? Int {
                    returnedArray.append(item)
                }  else if let item = item as? Double {
                    returnedArray.append(item)
                } else if let item = item as? String {
                    returnedArray.append(item)
                }
            }
            if returnedArray.count > 0 {
                return returnedArray
            }
        }
        return nil
    }
    
    // MARK: - Parse of "payload" if it contains an JSONObject
    private func parsePayloadToJSONDictionary(_ value: Any?) -> [JSONDictionary]? {
        if let value = value as? [JSONDictionary]{
            return value
        }
        return nil
    }
}
