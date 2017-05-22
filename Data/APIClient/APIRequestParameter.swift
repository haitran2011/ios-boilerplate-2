//
//  APIRequestParameter.swift
//  NewsApp
//
//  Created by Hiromi Motodera on 7/29/16.
//  Copyright © 2016 JX Press Corporation. All rights reserved.
//

public enum APIRequestParameterError: Error {
    case castError
}

public protocol APIRequestParameter {
    
    func requestParameter() -> Any
}

public protocol APIRequestParameterDictionaryConvertible: APIRequestParameter {
    
    func requestParameterDictionary() -> APIRequestParameterDictionary
}

extension APIRequestParameterDictionaryConvertible {
    
    func requestParameter() -> Any {
        return requestParameterDictionary().requestParameter()
    }
}

public struct APIRequestParameterArray: APIRequestParameter {
    
    var values: [APIRequestParameter] = []
    
    public init(_ values: [APIRequestParameter]) {
        self.values = values
    }
    
    public func requestParameter() -> Any {
        return self.values.map { $0.requestParameter() }
    }
}

public struct APIRequestParameterDictionary: APIRequestParameter {
    
    /// リクエストパラメーターの扱いについて
    public enum NullReadingRule {
        
        /// nullが入っていてもパース時に無視します
        case ignoreNULL
        
        /// nullが入っていた場合にNSNullとして値をセットします
        case respectNULL
    }
    
    var value: [String: APIRequestParameter?]
    
    let nullReadingRule: NullReadingRule
    
    public init(_ value: [String: APIRequestParameter?], rule: NullReadingRule = .ignoreNULL) {
        self.value = value
        self.nullReadingRule = rule
    }
    
    public func requestParameter() -> Any {
        var dictionary: [String: Any] = [:]
        for (k, v) in value {
            switch self.nullReadingRule {
            case .ignoreNULL:
                if let parameter = v?.requestParameter() {
                    dictionary[k] = parameter
                }
            case .respectNULL:
                dictionary[k] = v?.requestParameter() ?? NSNull().requestParameter()
            }
        }
        return dictionary as AnyObject
    }
}

extension APIRequestParameterDictionary: ExpressibleByDictionaryLiteral {
    
    public typealias Key = String
    
    public typealias Value = APIRequestParameter?
    
    typealias ElementType = (key: Key, value: Value)
    
    typealias Body = [Key: Value]
    
    public init(dictionaryLiteral elements: (Key, Value)...) {
        let initialValue = [Key: Value](minimumCapacity: elements.count)
        self.init(
            elements.reduce(initialValue) { (dictionary: Body, element: ElementType) -> Body in
                var d = dictionary
                d[element.key] = element.value
                return d
            })
    }
}

extension Bool: APIRequestParameter {
    
    public func requestParameter() -> Any {
        return self as AnyObject
    }
}

extension Int: APIRequestParameter {
    
    public func requestParameter() -> Any {
        return self as AnyObject
    }
}

extension Float: APIRequestParameter {
    
    public func requestParameter() -> Any {
        return self as AnyObject
    }
}

extension Double: APIRequestParameter {
    
    public func requestParameter() -> Any {
        return self as AnyObject
    }
}

extension String: APIRequestParameter {
    
    public func requestParameter() -> Any {
        return self as AnyObject
    }
}

extension NSNull: APIRequestParameter {
    
    public func requestParameter() -> Any {
        return self
    }
}

extension Optional: APIRequestParameter {
    
    public func requestParameter() -> Any {
        guard let bindSelf = self else {
            return NSNull().requestParameter()
        }
        guard let value = bindSelf as? APIRequestParameter else {
            fatalError("\(APIRequestParameterError.castError)")
        }
        return value.requestParameter()
    }
}

extension Array: APIRequestParameter {
    
    public func requestParameter() -> Any {
        return APIRequestParameterArray(self.flatMap { $0 as? APIRequestParameter }).requestParameter()
    }
}
