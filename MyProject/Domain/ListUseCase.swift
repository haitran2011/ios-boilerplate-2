//
//  ListUseCase.swift
//  MyProject
//
//  Created by Ryoichi Hara on 2017/05/14.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import Foundation

protocol ListUseCase {
    
    func fetchArticles() -> [Article]
}

struct ListUseCaseImpl: ListUseCase {
    
    let listRepository: ListRepository
    
    func fetchArticles() -> [Article] {
        let entities: [ArticleEntity] = listRepository.fetchArticleEntities()
        let translator = ArticleTranslator()
        
        let articles = entities.flatMap { entity -> Article? in
            return translator.translate(entity)
        }
        
        return articles
    }
}
