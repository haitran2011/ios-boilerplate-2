//
//  APIClient.swift
//  NewsApp
//
//  Created by Hiromi Motodera on 2016/07/26.
//  Copyright © 2016年 JX Press Corporation. All rights reserved.
//

import Alamofire
import Alamofire.Swift
import RxSwift

public enum APIError: Error {
    case connectionError(Error)
    case invalidResponse(AnyObject?)
    case parseError(AnyObject?)
}

/// アプリ内で用意しているテストデータを返すようにするフラグ
#if DEBUG
    public var shouldUseTestData = false
#else
    private let shouldUseTestData = false
#endif

public struct APIClient {
    
    public static func request<T: APIRequest>(_ APIRequest: T) -> Single<T.APIResponse> {
        let endPoint = APIRequest.baseURL + APIRequest.path
        let params = APIRequest.parameters.requestParameter() as? Parameters
        let headers = APIRequest.HTTPHeaderFields
        let method  = APIRequest.method
        let encoding = APIRequest.parameterEncoding
        
        if shouldUseTestData {
            let request = AnyAPIRequest<T>(APIRequest)
            if let testData = type(of: request).testData(nil) as? T.APIResponse {
                return Single.just(testData)
            }
        }
        let dispose = Disposables.create()
        return Single<T.APIResponse>.create(subscribe: { (observer) -> Disposable in
            Alamofire.request(endPoint, method: method, parameters: params, encoding: encoding, headers: headers)
                .validate()
                .response(completionHandler: { (response: DefaultDataResponse) in
                    if let error = response.error {
                        observer(.error(APIError.connectionError(error)))
                    } else if let URLResponse = response.response, let data = response.data,
                        self.isValid(response: URLResponse) {
                        guard let model = APIRequest.response(fromData: data, URLResponse: URLResponse) else {
                            observer(.error(APIError.parseError(data as NSData)))
                            return
                        }
                        observer(.success(model))
                    } else {
                        observer(.error(APIError.invalidResponse(response.response)))
                    }
                })
            return dispose
        })
    }
    
    static func isValid(response: HTTPURLResponse) -> Bool {
        return (200 ..< 300).contains(response.statusCode)
    }
}
