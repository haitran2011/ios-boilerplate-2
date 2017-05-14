//
//  DataStore.swift
//  MyProject
//
//  Created by Ryoichi Hara on 2017/05/14.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import Foundation

protocol DataStore {
    
    func fetchListItems()
}

struct DataStoreImpl: DataStore {
    
    func fetchListItems() {
        // return [Entity]
    }
}

// struct RealmDataStore: DataStore {}
// struct NetworkDataStore: DataStore {}
