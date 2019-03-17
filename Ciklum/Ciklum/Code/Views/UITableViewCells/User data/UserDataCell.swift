//
//  UserDataCell.swift
//  Ciklum
//
//  Created by Mikael Melkonyan on 3/17/19.
//  Copyright © 2019 Mikael Melkonyan. All rights reserved.
//

import UIKit

final class UserDataCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    
    func configure(title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
}

extension UserDataCell {
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: animated)
    }
}
