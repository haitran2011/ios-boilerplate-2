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
    
    func showDetail()
}

final class TopListWireframeImpl: ListWireframe {
    
    weak var viewController: ViewController?
    
    func showDetail() {
        // TODO: DetailViewController
        // viewController?.navigationController?.show(<#T##vc: UIViewController##UIViewController#>, sender: nil)
    }
}
