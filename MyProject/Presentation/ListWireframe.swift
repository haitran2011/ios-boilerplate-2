//
//  ListWireframe.swift
//  MyProject
//
//  Created by Ryoichi Hara on 2017/05/18.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import UIKit

protocol ListWireframe: class {
    weak var viewController: ViewController? { get set }
    
    func showDetail(item: ListItem)
}

final class TopListWireframeImpl: ListWireframe {
    
    weak var viewController: ViewController?
    
    func showDetail(item: ListItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard
            .instantiateViewController(withIdentifier: DetailViewController.className)
        detailVC.title = item.headline
        
        viewController?.navigationController?.show(detailVC, sender: nil)
    }
}
