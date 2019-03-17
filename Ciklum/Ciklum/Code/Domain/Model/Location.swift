//
//  Location.swift
//  Ciklum
//
//  Created by Mikael Melkonyan on 3/17/19.
//  Copyright © 2019 Mikael Melkonyan. All rights reserved.
//

import SwiftyJSON

struct Location {
    
    private let street: String
    private let city: String
    private let postcode: String
    private let state: String
    
    init(json: JSON) {
        street = json["street"].stringValue
        postcode = json["postcode"].stringValue
        city = json["city"].stringValue
        state = json["state"].stringValue
    }
    
    var description: String {
        return [street, city, postcode, state]
            .map { $0.capitalized }
            .joined(separator: " ")
    }
}
