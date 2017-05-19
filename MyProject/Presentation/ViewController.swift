//
//  ViewController.swift
//  MyProject
//
//  Created by Ryoichi Hara on 2017/04/23.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import UIKit
import Kingfisher

protocol ViewControllerInput: class {
    
    func displayFetchedItems()
}

final class ViewController: UIViewController, ViewControllerInput,
    UITableViewDataSource, UITableViewDataSourcePrefetching, UITableViewDelegate {
    
    // MARK: - Outlet
    
    @IBOutlet weak private var tableView: UITableView!
    
    // MARK: - Property
    
    private var presenter: ListPresenter?
    
    // MARK: - Lifecycle
    
    func inject(presenter: ListPresenter) {
        self.presenter = presenter
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = className
        
        tableView.prefetchDataSource = self
        
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        presenter?.fetchArticles()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - ViewControllerInput
    
    func displayFetchedItems() {
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView
            .dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        guard let items = presenter?.items else {
            return cell
        }
        
        if let customCell = cell as? TableViewCell {
            
            if indexPath.row < items.count {
                let item: ListItem = items[indexPath.row]
                customCell.configure(with: item)
            }
        }
        
        return cell
    }
    
    // MARK: - UITableViewDataSourcePrefetching
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        // Do tasks here (e.g. downloading image, calculate, update some data)
        guard let items = presenter?.items else {
            return
        }
        
        let urls: [URL] = indexPaths.flatMap { indexPath -> URL? in
            
            if indexPath.row < items.count {
                let item: ListItem = items[indexPath.row]
                return item.imageURL
            }
            
            return nil
        }
        
        ImagePrefetcher(urls: urls).start()
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        // Called when the user changes scroll direction or when the user taps on the status bar,
        // and the table view scrolls to the top rapidly.
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let customCell = cell as? TableViewCell {
            customCell.cancelTask()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectCellAt(indexPath: indexPath)
    }
}
