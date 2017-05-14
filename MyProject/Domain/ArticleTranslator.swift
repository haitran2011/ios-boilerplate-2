//
//  ArticleTranslator.swift
//  MyProject
//
//  Created by Ryoichi Hara on 2017/05/14.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import Foundation

protocol Translator {
    associatedtype Input
    associatedtype Output
    
    func translate(_: Input) -> Output
}

struct ArticleTranslator: Translator {
    typealias Input = ArticleEntity
    typealias Output = Article
    
    func translate(_ entity: ArticleEntity) -> Article {
        let title = entity.title
        let author = entity.author
        
        var imageURL: URL?
        
        if let urlString = entity.imageUrlString {
            imageURL = URL(string: urlString)
        }
        
        return Article(title: title, author: author, imageURL: imageURL)
    }
}
