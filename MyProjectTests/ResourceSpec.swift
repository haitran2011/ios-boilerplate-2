//
//  ResourceSpec.swift
//  MyProject
//
//  Created by Ryoichi Hara on 2017/05/04.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import Quick
import Nimble
import SwiftyJSON
@testable import MyProject

class ResourceSpec: QuickSpec {
    
    override func spec() {
        
        it("can read local json file") {
            let bundle = Bundle(for: type(of: self))
            let json: JSON? = Resource
                .jsonFrom(fileName: "article_test", bundle: bundle)
            
            let title: String? = json?["title"].string
            expect(title).to(equal("タイトル"))
        }
    }
}
