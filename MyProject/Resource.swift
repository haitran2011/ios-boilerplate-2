//
//  Resource.swift
//  MyProject
//
//  Created by Ryoichi Hara on 2017/05/04.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Resource {
    
    static func jsonFrom(fileName: String?, bundle: Bundle = .main) -> JSON? {
        var json: JSON? = nil
        
        guard let fileURL: URL = bundle
            .url(forResource: fileName, withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            json = JSON(data: data)
        } catch {
            let message: String = error.localizedDescription
            debugPrint(message)
        }
        
        return json
    }
}
