//
//  ArticleEntity.swift
//  MyProject
//
//  Created by Ryoichi Hara on 2017/05/14.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import Foundation

/// EntityはPresentation層では使用しない
/// Value Objectでプロパティの操作はされない
struct ArticleEntity {
    
    let title: String?
    let author: String?
    let imageUrlString: String?
}
