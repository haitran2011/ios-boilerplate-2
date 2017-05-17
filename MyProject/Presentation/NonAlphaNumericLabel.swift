//
//  NonAlphaNumericLabel.swift
//  MyProject
//
//  Created by Ryoichi Hara on 2017/05/03.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import UIKit

protocol NonAlphaNumericLabel {
    func setupPropertyForNonAlphaNumeric()
}

// MARK: - Mixin

extension NonAlphaNumericLabel where Self: UILabel {
    
    func setupPropertyForNonAlphaNumeric() {
        self.isOpaque = true
        self.clipsToBounds = true
    }
}
