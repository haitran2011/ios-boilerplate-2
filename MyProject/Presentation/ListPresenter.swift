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
}

final class TopListPresenterImpl: ListPresenter {
    
    weak var viewInput: ViewControllerInput?
    
    private(set)var items: [ListItem]?
    let listUseCase: ListUseCase
    
    // MARK: - Initialization
    
    init(viewInput: ViewControllerInput, useCase: ListUseCase) {
        self.viewInput = viewInput
        self.listUseCase = useCase
    }
    
    // MARK: - ListPresenter
    
    func fetchArticles() {
        items = listUseCase.fetchArticles()
        viewInput?.displayFetchedItems()
    }
}
