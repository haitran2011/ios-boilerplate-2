//
//  Model.swift
//  MyProject
//
//  Created by Ryoichi Hara on 2017/05/04.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import Foundation

protocol ListItem {
    
    var headline: String? { get }
    var footnote: String? { get }
    var imageURL: URL? { get }
}
