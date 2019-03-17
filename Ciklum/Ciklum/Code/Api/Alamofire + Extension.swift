//
//  Alamofire + Extension.swift
//  Ciklum
//
//  Created by Mikael Melkonyan on 3/17/19.
//  Copyright © 2019 Mikael Melkonyan. All rights reserved.
//

import Alamofire
import SwiftyJSON

extension DataRequest {
    
    func responseJSON<Instance>(parse: @escaping ((JSON) -> Instance?), completion: @escaping ((ResponseState<Instance>) -> ())) {
        responseJSON { apiResponse in
            switch apiResponse.result {
            case let .success(value):
                let json = JSON(value)
                if let instance = parse(json) {
                    completion(.success(instance))
                } else {
                    let text = json["error"].string ?? "Unknown error"
                    completion(.error(text))
                }
            case let .failure(error):
                completion(.error(error.localizedDescription))
            }
        }
    }
}
