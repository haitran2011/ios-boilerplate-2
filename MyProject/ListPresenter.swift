//
//  ListPresenter.swift
//  MyProject
//
//  Created by Ryoichi Hara on 2017/05/04.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import Foundation

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
        
        for index in 0..<40 {
            articles.append(Article(title: "セル \(index)"))
        }
        _items = articles
        
        output?.displayFetchedItems()
    }
}
