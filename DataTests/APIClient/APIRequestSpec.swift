//
//  APIRequestSpec.swift
//  NewsApp
//
//  Created by moaible on 2017/05/31.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import Quick
import Nimble
@testable import Data
import Alamofire

struct TestResponse {
    
    var text: String
}

struct TestStructRequest: APIRequest {
    
    typealias TestParameter = String
    
    static func testData(_ parameter: TestParameter?) -> TestResponse? {
        guard let parameter = parameter else {
            return TestResponse(text: "hello world")
        }
        return TestResponse(text: parameter)
    }
    
    typealias APIResponse = TestResponse
    
    var baseURL: String {
        return "https://hogehoge.com"
    }
    
    var method: APIRequestMethod {
        return .get
    }
    
    var path: String {
        return "/test"
    }
    
    var parameters: APIRequestParameter? {
        return nil
    }
    
    var HTTPHeaderFields: [String : String] {
        return [:]
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding()
    }
    
    func response(fromData data: Data, URLResponse: HTTPURLResponse) -> APIResponse? {
        return nil
    }
}

class APIRequestSpec: QuickSpec {
    
    override func spec() {
        
        let structRequest = TestStructRequest()
        
        it("test request parameter check") {
            expect(structRequest.baseURL).to(equal("https://hogehoge.com"))
            expect(structRequest.path).to(equal("/test"))
            expect(structRequest.baseURL + structRequest.path).to(equal("https://hogehoge.com/test"))
            expect(structRequest.parameters).to(beNil())
            expect(structRequest.HTTPHeaderFields).to(equal([:]))
        }
        
        it("test request response check") {
            let defaultTestResponse = TestStructRequest.testData(nil)
            expect(defaultTestResponse?.text).to(equal("hello world"))
            let customTestResponse = TestStructRequest.testData("TEST")
            expect(customTestResponse?.text).to(equal("TEST"))
        }
    }
}