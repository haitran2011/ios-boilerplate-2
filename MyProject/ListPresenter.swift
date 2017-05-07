//
//  ListPresenter.swift
//  MyProject
//
//  Created by Ryoichi Hara on 2017/05/04.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol ListPresenterInput {
}

protocol ListPresenterOutput: class {
    
    func displayFetchedItems()
}

class ListPresenter: ListPresenterInput, ViewControllerOutput {
    
    private weak var output: ListPresenterOutput?
    private var _items: [ListItem]?
    
    init(output: ListPresenterOutput?) {
        self.output = output
    }
    
    // MARK: - ViewControllerOutput
    
    var items: [ListItem]? {
        return _items
    }
    
    func fetchItems() {
        var articles: [Article] = []
        
        if let json = Resource.jsonFrom(fileName: "articles") {
            
            if let jsonArray = json["articles"].array {
                
                for jsonObj: JSON in jsonArray {
                    let title: String? = jsonObj["title"].string
                    var imageURL: URL?
                    
                    if let urlString = jsonObj["image_url"].string {
                        imageURL = URL(string: urlString)
                    }
                    
                    let article = Article(title: title, imageURL: imageURL)
                    articles.append(article)
                }
            }
        }
        
        _items = articles
        
        output?.displayFetchedItems()
    }
}
