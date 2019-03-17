//
//  Date.swift
//  Ciklum
//
//  Created by Mikael Melkonyan on 3/17/19.
//  Copyright © 2019 Mikael Melkonyan. All rights reserved.
//

import Foundation.NSDate

extension Date {
    
    init?(from string: String, format: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: string) else {
            return nil
        }
        self = date
    }
    
    var textFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: self)
    }
}
