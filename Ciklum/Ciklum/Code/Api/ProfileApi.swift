//
//  ProfileApi.swift
//  Ciklum
//
//  Created by Mikael Melkonyan on 3/17/19.
//  Copyright © 2019 Mikael Melkonyan. All rights reserved.
//

import Alamofire

final class ProfileApi: Api {
    
    func getUser(completion: @escaping ((ResponseState<User>) -> ())) {
        let request = Alamofire.request(Api.globalUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
        request.responseJSON(parse: { User(json: $0) }) {
            completion($0)
        }
    }
}
