//
//  DataStore.swift
//  MyProject
//
//  Created by Ryoichi Hara on 2017/05/14.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 通信・データの永続化を扱う。取得先(API/DB)ごとに作成する
/// 取得先が複数ある場合Factoryパターンを用いてRepositoryがData種別を意識しない設計にする
protocol DataStore {
    
    func fetchArticleEntities() -> [ArticleEntity]
}

struct DataStoreImpl: DataStore {
    
    func fetchArticleEntities() -> [ArticleEntity] {
        var entities: [ArticleEntity] = []
        
        if let json = Resource.jsonFrom(fileName: "articles") {
            
            if let jsonArray = json["articles"].array {
                
                for jsonObj: JSON in jsonArray {
                    let title    : String? = jsonObj["title"].string
                    let author   : String? = jsonObj["author"].string
                    let urlString: String? = jsonObj["image_url"].string
                    
                    let entity = ArticleEntity(
                        title: title,
                        author: author,
                        imageUrlString: urlString)
                    
                    entities.append(entity)
                }
            }
        }
        
        return entities
    }
}

// struct RealmDataStore: DataStore {}
// struct NetworkDataStore: DataStore {}
