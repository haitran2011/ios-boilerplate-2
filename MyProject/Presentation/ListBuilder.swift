//
//  ListBuilder.swift
//  MyProject
//
//  Created by Ryoichi Hara on 2017/05/17.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import UIKit

struct ListBuilder {
    
    func build() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let identifier = ViewController.className
        let viewController = storyboard
            .instantiateViewController(withIdentifier: identifier)
        
        guard let vc = viewController as? ViewController else {
            assertionFailure()
            return UIViewController()
        }
        
        let repository = ListRepositoryImpl(dataStore: DataStoreImpl())
        let useCase = ListUseCaseImpl(listRepository: repository)
        let wireframe = TopListWireframeImpl()
        wireframe.viewController = vc
        
        let presenter = TopListPresenterImpl(
            viewInput: vc, useCase: useCase, wireframe: wireframe)
        vc.inject(presenter: presenter)
        
        return vc
    }
}
