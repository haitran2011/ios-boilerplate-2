//
//  ListPresenter.swift
//  NewsApp
//
//  Created by Ryoichi Hara on 2017/05/28.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import Foundation
import Domain

public protocol ListPresenter: class {
    var items: [ListItem] { get }
    func fetchItems()
}
