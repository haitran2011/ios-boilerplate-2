//
//  Article.swift
//  NewsApp
//
//  Created by Ryoichi Hara on 2017/05/21.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import Foundation

public struct Article {
    
    public let headline: String?
    
    // By default, Swift3 generates `internal` init
    public init(headline: String?) {
        self.headline = headline
    }
}
