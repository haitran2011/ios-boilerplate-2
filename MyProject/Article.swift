//
//  Article.swift
//  MyProject
//
//  Created by Ryoichi Hara on 2017/05/04.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import Foundation

struct Article: ListItem {
    
    let headline: String?
    let footnote: String?
    let imageURL: URL?
    
    init(title: String?, author: String?, imageURL: URL?) {
        headline = title
        footnote = author
        self.imageURL = imageURL
    }
}
