//
//  ExampleSpec.swift
//  Example
//
//  Created by HaraRyoichi on 2017/06/14.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import Quick
import Nimble
@testable import Example

class ExampleSpec: QuickSpec {
    
    override func spec() {
        
        it("equals two") {
            expect(1 + 1).to(equal(2))
        }
    }
}
