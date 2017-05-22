//
//  APIRequest.swift
//  NewsApp
//
//  Created by Hiromi Motodera on 7/26/16.
//  Copyright © 2016 JX Press Corporation. All rights reserved.
//

import Alamofire
import Unbox

typealias Method = Alamofire.HTTPMethod
typealias ParameterEncoding = Alamofire.ParameterEncoding

protocol APIDataTestable {
    
    associatedtype TestParameter
    
    associatedtype TestResponse
    
    static func testData(_ parameter: TestParameter?) -> TestResponse?
}

protocol APIRequest: APIDataTestable {
    
    associatedtype APIResponse
    
    var baseURL: String { get }
    
    var method: Method { get }
    
    var path: String { get }
    
    var pathDescription: String { get }
    
    var parameters: APIRequestParameter? { get }
    
    var HTTPHeaderFields: [String : String] { get }
    
    var parameterEncoding: ParameterEncoding { get }
    
    func response(fromData data: Data, URLResponse: HTTPURLResponse) -> APIResponse?
}

extension APIRequest {
    
    var pathDescription: String {
        return path
    }
}

// MARK: Type Erasure Definition

struct AnyAPIRequest<A: APIRequest>: APIRequest {
    
    typealias APIResponse = A.APIResponse
    typealias TestParameter = A.TestParameter
    typealias TestResponse = A.TestResponse
    
    fileprivate let _baseURL: String
    fileprivate let _method: Method
    fileprivate let _path: String
    fileprivate let _parameters: APIRequestParameter?
    fileprivate let _HTTPHeaderFields: [String : String]
    fileprivate let _parameterEncoding: ParameterEncoding
    fileprivate let _response: (_ data: Data, _ URLResponse: HTTPURLResponse) -> APIResponse?
    
    init<Inner: APIRequest>(_ inner: Inner) where APIResponse == Inner.APIResponse {
        _baseURL = inner.baseURL
        _method = inner.method
        _path = inner.path
        _parameters = inner.parameters
        _HTTPHeaderFields = inner.HTTPHeaderFields
        _parameterEncoding = inner.parameterEncoding
        _response = inner.response
    }
    
    var baseURL: String {
        return _baseURL
    }
    
    var method: Method {
        return _method
    }
    
    var path: String {
        return _path
    }
    
    var parameters: APIRequestParameter? {
        return _parameters
    }
    
    var HTTPHeaderFields: [String : String] {
        return _HTTPHeaderFields
    }
    
    var parameterEncoding: ParameterEncoding {
        return _parameterEncoding
    }
    
    func response(fromData data: Data, URLResponse: HTTPURLResponse) -> APIResponse? {
        return _response(data, URLResponse)
    }
    
    static func testData(_ parameter: TestParameter?) -> TestResponse? {
        return A.testData(parameter)
    }
}
