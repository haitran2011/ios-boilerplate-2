//
//  ViewController.swift
//  MyProject
//
//  Created by Ryoichi Hara on 2017/04/23.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import UIKit

final class ViewController: UIViewController, UITableViewDataSource,
    UITableViewDataSourcePrefetching, UITableViewDelegate {
    
    // MARK: - Outlet
    
    @IBOutlet weak private var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = className
        
        tableView.prefetchDataSource = self
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let customCell = cell as? TableViewCell {
            customCell.configure()
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
