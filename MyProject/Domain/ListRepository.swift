//
//  ListRepository.swift
//  MyProject
//
//  Created by Ryoichi Hara on 2017/05/14.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import Foundation

protocol ListRepository {
    
    func fetchArticleEntities() -> [ArticleEntity]
}

struct ListRepositoryImpl: ListRepository {
    
    let dataStore: DataStore
    
    func fetchArticleEntities() -> [ArticleEntity] {
        return dataStore.fetchArticleEntities()
    }
}
