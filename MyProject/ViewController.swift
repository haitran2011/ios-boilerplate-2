//
//  ViewController.swift
//  MyProject
//
//  Created by Ryoichi Hara on 2017/04/23.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import UIKit

protocol ViewControllerInput {
}

protocol ViewControllerOutput {
    var items: [ListItem]? { get }
    func fetchItems()
}

final class ViewController: UIViewController, ViewControllerInput, ListPresenterOutput,
    UITableViewDataSource, UITableViewDataSourcePrefetching, UITableViewDelegate {
    
    // MARK: - Outlet
    
    @IBOutlet weak private var tableView: UITableView!
    
    // MARK: - Property
    
    private var output: ViewControllerOutput?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        output = ListPresenter(output: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = className
        
        tableView.prefetchDataSource = self
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        output?.fetchItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - ListPresenterOutput
    
    func displayFetchedItems() {
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView
            .dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        guard let items = output?.items else {
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
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        // Called when the user changes scroll direction or when the user taps on the status bar,
        // and the table view scrolls to the top rapidly.
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
