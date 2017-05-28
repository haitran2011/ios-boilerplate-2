//
//  APIRequest.swift
//  NewsApp
//
//  Created by Hiromi Motodera on 7/26/16.
//  Copyright © 2016 JX Press Corporation. All rights reserved.
//

import Alamofire
import Unbox

public typealias Method = Alamofire.HTTPMethod
public typealias ParameterEncoding = Alamofire.ParameterEncoding

public protocol APITestDataRespondable {
    
    associatedtype TestParameter
    
    associatedtype TestResponse
    
    static func testData(_ parameter: TestParameter?) -> TestResponse?
}

public protocol APIRequest: APITestDataRespondable {
    
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
    
    public var pathDescription: String {
        return path
    }
}

// MARK: Type Erasure Definition

public struct AnyAPIRequest<A: APIRequest>: APIRequest {
    
    public typealias APIResponse = A.APIResponse
    public typealias TestParameter = A.TestParameter
    public typealias TestResponse = A.TestResponse
    
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
    
    public var baseURL: String {
        return _baseURL
    }
    
    public var method: Method {
        return _method
    }
    
    public var path: String {
        return _path
    }
    
    public var parameters: APIRequestParameter? {
        return _parameters
    }
    
    public var HTTPHeaderFields: [String : String] {
        return _HTTPHeaderFields
    }
    
    public var parameterEncoding: ParameterEncoding {
        return _parameterEncoding
    }
    
    public func response(fromData data: Data, URLResponse: HTTPURLResponse) -> APIResponse? {
        return _response(data, URLResponse)
    }
    
    public static func testData(_ parameter: TestParameter?) -> TestResponse? {
        return A.testData(parameter)
    }
}
