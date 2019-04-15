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
    var urlPath: URLConvertible = "https://raw.githubusercontent.com/marwen1609/GMP/master/failureWithTrue.json"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    // MARK: - Members
    fileprivate func loadData() {
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding:URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result{
            case .success:
                do {
                    let parsedData = try self.payloadParser.payload(from: response.data)
                    if let successData = parsedData as? SuccessCase {
                        print(successData.payload)
                        print(successData.result)
                    } else if let failureData = parsedData as? FailureCase {
                        print(failureData.message)
                    }
                }catch let error {
                    debugPrint(error)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}




