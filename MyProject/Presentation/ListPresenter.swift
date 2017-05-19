//
//  ListPresenter.swift
//  MyProject
//
//  Created by Ryoichi Hara on 2017/05/04.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol ListPresenter: class {
    var items: [ListItem]? { get }
    func fetchArticles()
    func selectCellAt(indexPath: IndexPath)
}

final class TopListPresenterImpl: ListPresenter {
    
    weak var viewInput: ViewControllerInput?
    
    private(set)var items: [ListItem]?
    let listUseCase: ListUseCase
    let wireframe: ListWireframe
    
    // MARK: - Initialization
    
    init(viewInput: ViewControllerInput, useCase: ListUseCase, wireframe: ListWireframe) {
        self.viewInput = viewInput
        self.listUseCase = useCase
        self.wireframe = wireframe
    }
    
    // MARK: - ListPresenter
    
    func fetchArticles() {
        items = listUseCase.fetchArticles()
        viewInput?.displayFetchedItems()
    }
    
    func selectCellAt(indexPath: IndexPath) {
        guard let items = items else {
            return
        }
        
        guard indexPath.row < items.count else {
            return
        }
        
        let item = items[indexPath.row]
        wireframe.showDetail(item: item)
    }
}
