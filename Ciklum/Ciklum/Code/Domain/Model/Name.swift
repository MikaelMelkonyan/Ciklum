//
//  Namr.swift
//  Ciklum
//
//  Created by Mikael Melkonyan on 3/17/19.
//  Copyright © 2019 Mikael Melkonyan. All rights reserved.
//

import SwiftyJSON

struct Name {
    
    let first: String
    let last: String
    let title: String?
    
    init?(json: JSON) {
        guard let firstName = json["first"].string, let lastName = json["last"].string else {
            return nil
        }
        first = firstName
        last = lastName
        title = json["title"].string
    }
}
