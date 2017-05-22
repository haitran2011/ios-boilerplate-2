//
//  APIRequestParameter.swift
//  NewsApp
//
//  Created by Hiromi Motodera on 7/29/16.
//  Copyright © 2016 JX Press Corporation. All rights reserved.
//

enum APIRequestParameterError: Error {
    case castError
}

protocol APIRequestParameter {
    
    func requestParameter() -> Any
}

protocol APIRequestParameterDictionaryConvertible: APIRequestParameter {
    
    func requestParameterDictionary() -> APIRequestParameterDictionary
}

extension APIRequestParameterDictionaryConvertible {
    
    func requestParameter() -> Any {
        return requestParameterDictionary().requestParameter()
    }
}

struct APIRequestParameterArray: APIRequestParameter {
    
    var values: [APIRequestParameter] = []
    
    init(_ values: [APIRequestParameter]) {
        self.values = values
    }
    
    func requestParameter() -> Any {
        return self.values.map { $0.requestParameter() }
    }
}

struct APIRequestParameterDictionary: APIRequestParameter {
    
    /// リクエストパラメーターの扱いについて
    enum ReadingOption {
        
        case ignoreNULL
        
        case respectNULL
    }
    
    var value: [String: APIRequestParameter?]
    
    let readingOption: ReadingOption
    
    init(_ value: [String: APIRequestParameter?], option: ReadingOption = .ignoreNULL) {
        self.value = value
        self.readingOption = option
    }
    
    func requestParameter() -> Any {
        var dictionary: [String: Any] = [:]
        for (k, v) in value {
            switch self.readingOption {
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
    
    typealias Key = String
    
    typealias Value = APIRequestParameter?
    
    init(dictionaryLiteral elements: (Key, Value)...) {
        self.init(
            elements.reduce([Key: Value](minimumCapacity: elements.count)) { (dictionary: [Key: Value], element:(key: Key, value: Value)) -> [Key: Value] in
                var d = dictionary
                d[element.key] = element.value
                return d
            })
    }
}

extension Bool: APIRequestParameter {
    
    func requestParameter() -> Any {
        return self as AnyObject
    }
}

extension Int: APIRequestParameter {
    
    func requestParameter() -> Any {
        return self as AnyObject
    }
}

extension Float: APIRequestParameter {
    
    func requestParameter() -> Any {
        return self as AnyObject
    }
}

extension Double: APIRequestParameter {
    
    func requestParameter() -> Any {
        return self as AnyObject
    }
}

extension String: APIRequestParameter {
    
    func requestParameter() -> Any {
        return self as AnyObject
    }
}

extension NSNull: APIRequestParameter {
    
    func requestParameter() -> Any {
        return self
    }
}

extension Optional: APIRequestParameter {
    
    func requestParameter() -> Any {
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
    
    func requestParameter() -> Any {
        return APIRequestParameterArray(self.flatMap { $0 as? APIRequestParameter }).requestParameter()
    }
}
