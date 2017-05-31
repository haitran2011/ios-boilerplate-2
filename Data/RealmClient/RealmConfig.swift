//
//  RealmConfig.swift
//  NewsApp
//
//  Created by moaible on 2017/05/31.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import RealmSwift

public protocol RealmConfig {
    
    var store: RealmClient.Store { get }
    
    var filePath: String { get }
    
    var encryptionKey: Data? { get }
    
    var readOnly: Bool { get }
    
    var schemaVersion: UInt64 { get }
    
    var migrationBlock: RealmSwift.MigrationBlock? { get }
    
    var deleteRealmIfMigrationNeeded: Bool { get }
    
    var objectTypes: [Object.Type]? { get }
}

extension RealmConfig {
    
    var encryptionKey: Data? {
        return nil
    }
    
    var readOnly: Bool {
        return false
    }
    
    var schemaVersion: UInt64 {
        return 0
    }
    
    var migrationBlock: RealmSwift.MigrationBlock? {
        return nil
    }
    
    var deleteRealmIfMigrationNeeded: Bool {
        return false
    }
    
    var objectTypes: [Object.Type]? {
        return nil
    }
}
