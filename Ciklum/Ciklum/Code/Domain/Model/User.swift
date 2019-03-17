//
//  User.swift
//  Ciklum
//
//  Created by Mikael Melkonyan on 3/17/19.
//  Copyright © 2019 Mikael Melkonyan. All rights reserved.
//

import Foundation.NSDate
import SwiftyJSON

struct User {
    
    let name: Name
    let picture: Picture
    let phone: String
    let registeredAt: Date
    let cell: String
    let email: String
    let username: String
    let location: Location
    
    init?(json: JSON) {
        guard let results = json["results"].first?.1 else {
            return nil
        }
        guard let name = Name(json: results["name"]) else {
            return nil
        }
        self.name = name
        
        guard let registered = Date(from: results["registered"]["date"].stringValue, format: "yyyy-MM-dd'T'HH:mm:ssZ") else {
            return nil
        }
        registeredAt = registered
        
        picture = Picture(json: results["picture"])
        phone = results["phone"].stringValue
        cell = results["cell"].stringValue
        email = results["email"].stringValue
        username = results["login"]["username"].stringValue
        location = Location(json: results["location"])
    }
}
