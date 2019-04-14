//
//  ViewController.swift
//  FBChallenge
//
//  Created by Marwen Jamel on 13/04/19.
//  Copyright © 2019 Marwen Jamel. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class ViewController: UIViewController {
    // MARK: - Properties
    var payloadParser = PayloadParser()
    var urlPath: URLConvertible = "https://raw.githubusercontent.com/marwen1609/fakeJson/master/db.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding:URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result{
            case .success:
                
                do {
                    let parsedData = try self.payloadParser.payload(from: response.data)
                   let successData =  parsedData as! SuccessCase
                    print(successData.result)
                }catch let error {
                    debugPrint(error.localizedDescription)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
}

class PayloadParser {
    
    func payload(from data: Data?) throws -> Any {
        if let data = data {
            do {
                let decoder = JSONDecoder()
                var challengeData = try decoder.decode(SuccessCase.self, from: data)
                if let boolValue = bool(challengeData.result) {
                    challengeData.result = JSONValue.bool(<#Bool#>)
                }
                
                return challengeData
            } catch {
                do {
                    let decoder = JSONDecoder()
                    let challengeErrorData = try decoder.decode(FailureCase.self, from: data)
                    return challengeErrorData.message
                }
                catch {
                    throw PayloadErrors.dataDoNotConfromToModel
                }
            }
        }
        throw PayloadErrors.noDataRecived
    }
}
extension PayloadParser {
    
    func bool(_ value: Any?) -> Bool? {
        
        if let value = value as? Bool {
            return value
        } else if let value = value as? Int {
            return value > 0
        } else if let value = value as? String {
            return value.bool
        }
        return nil
    }
    
}

enum PayloadErrors: Error {
    case noDataRecived
    case dataIsMissing
    case dataDoNotConfromToModel
}


