//
//  RealmClient.swift
//  NewsApp
//
//  Created by moaible on 2017/05/31.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import RealmSwift

public struct RealmClient {
    
    // Realmの保存先のパスを一度だけ表示するためのフラグ
    private static var isShowRealmPath: Bool = false
    
    enum Error: Swift.Error {
        case notSettingBasePath
        case notSettingRealmFilePath
    }
    
    fileprivate init() {}
    
    fileprivate static func realm(for config: RealmConfig) throws -> RealmSwift.Realm {
        do {
            let configration = try self.realmConfigration(for: config)
            guard let filePath = configration.fileURL?.absoluteString else {
                throw Error.notSettingRealmFilePath
            }
            if !FileManager.default.fileExists(atPath: filePath) {
                try FileManager.default.createDirectory(
                    atPath: filePath, withIntermediateDirectories: false, attributes: nil)
            }
            #if DEBUG
                if !isShowRealmPath {
                    isShowRealmPath = true
                    print("Open realm path:\n \(filePath)")
                }
            #endif
            let realm = try Realm(configuration: self.realmConfigration(for: config))
            return realm
        } catch {
            throw error
        }
    }
    
    fileprivate static func realmConfigration(for config: RealmConfig) throws -> RealmSwift.Realm.Configuration {
        switch config.store {
        case .directory(let directory):
            guard let basePath = directory.basePath else {
                throw Error.notSettingBasePath
            }
            return RealmSwift.Realm.Configuration(
                fileURL: URL(fileURLWithPath: basePath + config.filePath),
                inMemoryIdentifier: nil,
                syncConfiguration: nil,
                encryptionKey: config.encryptionKey,
                readOnly: config.readOnly,
                schemaVersion: config.schemaVersion,
                migrationBlock: config.migrationBlock,
                deleteRealmIfMigrationNeeded: config.deleteRealmIfMigrationNeeded,
                shouldCompactOnLaunch: nil,
                objectTypes: config.objectTypes)
        case .inMemory(let identifier):
            return RealmSwift.Realm.Configuration(
                fileURL: nil,
                inMemoryIdentifier: identifier,
                syncConfiguration: nil,
                encryptionKey: config.encryptionKey,
                readOnly: config.readOnly,
                schemaVersion: config.schemaVersion,
                migrationBlock: config.migrationBlock,
                deleteRealmIfMigrationNeeded: config.deleteRealmIfMigrationNeeded,
                shouldCompactOnLaunch: nil,
                objectTypes: config.objectTypes)
            
        }
    }
}

extension RealmClient {
    
    public enum Store {
        
        case directory(Directory)
        
        case inMemory(String)
    }
}

extension RealmClient {
    
    public enum Directory {
        
        case home
        
        case temporary
        
        /// see
        /// https://developer.apple.com/reference/foundation/1414224-nssearchpathfordirectoriesindoma?language=swift
        case searchPath(directory: FileManager.SearchPathDirectory)
        
        /// ディレクトリを指定
        case custom(basePath: String)
        
        var basePath: String? {
            switch self {
            case .home:
                return NSHomeDirectory()
            case .searchPath(let directory):
                return NSSearchPathForDirectoriesInDomains(
                    directory, .userDomainMask, true).first
            case .temporary:
                return NSTemporaryDirectory()
            case .custom(let basePath):
                return basePath
            }
        }
    }
}
