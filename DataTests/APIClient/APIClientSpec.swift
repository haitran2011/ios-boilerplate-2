//
//  APIClientSpec.swift
//  NewsApp
//
//  Created by moaible on 2017/05/31.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import Quick
import Nimble
@testable import Data

import Alamofire
import RxSwift
import Unbox

class APIClientSpec: QuickSpec {
    
    let disposeBag = DisposeBag()
    
    override func spec() {
        
        it("enable mock flag test") {
            shouldUseTestData = true
            APIClient.request(TestStructRequest(name: "boy")).subscribe(onSuccess: { response in
                expect(response.text).to(equal("hello world"))
            }).disposed(by: self.disposeBag)
        }
    }
}
