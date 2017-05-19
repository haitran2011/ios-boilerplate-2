//
//  NewsAppSpec.swift
//  NewsApp
//
//  Created by Ryoichi Hara on 2017/05/20.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import Quick
import Nimble
@testable import NewsApp

class NewsAppSpec: QuickSpec {
    
    override func spec() {
        
        it("equals two") {
            expect(1 + 1).to(equal(2))
        }
    }
}
