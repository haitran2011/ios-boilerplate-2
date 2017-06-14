//
//  DataSpec.swift
//  NewsApp
//
//  Created by Ryoichi Hara on 2017/05/24.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import Quick
import Nimble
@testable import Data

class DataSpec: QuickSpec {
    
    override func spec() {
        
        it("equals four") {
            expect(1 + 3).to(equal(4))
        }
    }
}
