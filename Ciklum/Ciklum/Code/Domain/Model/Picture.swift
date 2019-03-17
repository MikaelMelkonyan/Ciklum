//
//  Picture.swift
//  Ciklum
//
//  Created by Mikael Melkonyan on 3/17/19.
//  Copyright © 2019 Mikael Melkonyan. All rights reserved.
//

import SwiftyJSON

struct Picture {
    
    let large: String
    let medium: String
    let thumbnail: String
    
    init(json: JSON) {
        large = json["large"].stringValue
        medium = json["medium"].stringValue
        thumbnail = json["thumbnail"].stringValue
    }
}
