//
//  TableViewCell.swift
//  MyProject
//
//  Created by Ryoichi Hara on 2017/05/03.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    @IBOutlet weak private var titleLabel: Label!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.setupPropertyForNonAlphaNumeric()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure() {
        titleLabel.text = "セル"
    }
}
