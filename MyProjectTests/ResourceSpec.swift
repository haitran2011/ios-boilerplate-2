//
//  ResourceSpec.swift
//  MyProject
//
//  Created by Ryoichi Hara on 2017/05/04.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import Quick
import Nimble
@testable import MyProject

class ResourceSpec: QuickSpec {
    
    override func spec() {
        
        it("is equal") {
            let value = 1 + 1
            
            expect(value).to(equal(2))
        }
    }
}
