//
//  RealmClient.swift
//  NewsApp
//
//  Created by moaible on 2017/05/31.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import RealmSwift

struct RealmClient {
    
    fileprivate static var source: [String: Realm] = [:]
    
    fileprivate init() {}
}

enum RealmBaseDirectory {
    
    /// 'Documents/' バックアップ対象となりユーザーから見える
    case documents
    
    /// 'Documents/Inbox/' バックアップ対象となりユーザーから見える、他のアプリと共有できる
    case sharedAppDocuments
    
    /// 'Library/Caches/' バックアップ対象外でユーザーから見えない
    case libraryCaches
    
    case inMemory
    case custom(baseDirectory: String)
}

protocol RealmConfigration {
    
    var baseDirectory: RealmBaseDirectory { get }
    
    var path: String { get }
    
    var encryptionKey: Data? { get }
    
    var readOnly: Bool { get }
    
    var schemaVersion: UInt64 { get }
    
    var migrationBlock: RealmSwift.MigrationBlock? { get }
    
    var deleteRealmIfMigrationNeeded: Bool { get }
    
    var objectTypes: [Object.Type]? { get }
}
