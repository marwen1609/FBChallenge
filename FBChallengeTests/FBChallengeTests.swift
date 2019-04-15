//
//  FBChallengeTests.swift
//  FBChallengeTests
//
//  Created by Marwen Jamel on 13/04/19.
//  Copyright © 2019 Marwen Jamel. All rights reserved.
//

import XCTest
@testable import FBChallenge

class FBChallengeTests: XCTestCase {
    
    
    func testFailureWithTrueJSON() {
        let data = getJSONData(for: "failureWithTrue")
        let payloadParser = PayloadParser()
        
        do {
            let decodedJson = try payloadParser.payload(from: data)
            XCTAssertNil(decodedJson)
            if let failureCase = decodedJson as? FailureCase {
                XCTAssertThrowsError(payloadParser)
                XCTAssertNil(failureCase, "It supposed to be nil because of the business logic")
            }
            
        } catch {
            XCTAssertEqual(error.localizedDescription, PayloadErrors.logicError.description)
        }
    }
    
    func testFailureCaseJSON() {
        let data = getJSONData(for: "failureJson")
        let payloadParser = PayloadParser()
        
        do {
            let decodedJson = try payloadParser.payload(from: data)
            XCTAssertNotNil(decodedJson)
            if let failureCase = decodedJson as? FailureCase {
                XCTAssertNoThrow(payloadParser)
                XCTAssertNotNil(failureCase, "It's supposed to be nil")
            }
            
        } catch {
        }
    }
    
    func testComplexJSONData() {
        let data = getJSONData(for: "complexJson")
        let payloadParser = PayloadParser()
        
        do {
            let decodedJson = try payloadParser.payload(from: data)
            XCTAssertNotNil(decodedJson)
            if let successCase = decodedJson as? SuccessCase{
                XCTAssertNoThrow(payloadParser)
                XCTAssertNotNil(successCase)
                XCTAssertNotNil(successCase.payload,"Payload not supposed to be empty")
            }
        } catch {
        }
    }
    
    func testPayloadTable() {
        let data = getJSONData(for: "payloadTable")
        let payloadParser = PayloadParser()
        
        do {
            let decodedJson = try payloadParser.payload(from: data)
            XCTAssertNotNil(decodedJson)
            if let successCase = decodedJson as? SuccessCase{
                XCTAssertNoThrow(payloadParser)
                XCTAssertNotNil(successCase)
                XCTAssertNotNil(successCase.payload,"Payload not supposed to be empty")
            }
        } catch {
        }
    }
    
    func testResultValue(){
        let data = getJSONData(for: "resultISNotBool")
        XCTAssertNotNil(data)
        let payloadParser = PayloadParser()
        
        do {
            let decodedJson = try payloadParser.payload(from: data)
            XCTAssertNil(decodedJson)
        } catch let error {
            XCTAssertThrowsError(payloadParser)
            XCTAssertEqual(error.localizedDescription, PayloadErrors.dataDoNotConfromToEntity.description)
        }
    }
    
    func testPayloadEmpty() {
        let data = getJSONData(for: "payloadEmpty")
        let payloadParser = PayloadParser()
        
        do {
            let decodedJson = try payloadParser.payload(from: data)
            XCTAssertNotNil(data)
            if let successCase = decodedJson as? SuccessCase{
                XCTAssertNoThrow(payloadParser)
                XCTAssertNotNil(successCase)
                XCTAssertNotNil(successCase.payload,"Payload not supposed to be nil")
            }
        } catch {
        }
    }
    
    
    /// This methode gets the json data from json file using the filename
    ///
    /// - Parameter name: name of the json file
    /// - Returns: returns jsonData Object from a json file
    func getJSONData(for name: String) -> Data? {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: name, withExtension: "json") else {
            XCTFail("Missing file: \(name).json")
            return nil
        }
        do {
            let jsonData = try Data(contentsOf: url)
            return jsonData
        } catch {
            return nil
        }
    }
    
}
