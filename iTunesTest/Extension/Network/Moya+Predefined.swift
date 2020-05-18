//
//  Moya+Predefined.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 22.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Moya
import ReactiveSwift

extension TargetType {
    
    var sampleData: Data {
        return Data()
    }
    
    var baseURL: URL {
        URL(string: "https://itunes.apple.com/")!
    }
    
    var headers: [String: String]? {
        addAdditionalHeaders(to: nil)
    }
    
    func addContentType(_ type: ContentType, to headers: [String: String]?) -> [String: String]? {
        var temp: [String: String] = [:]
        if let existHeaders = headers {
            temp = existHeaders
        }
        temp["Content-Type"] = type.contentType
        return temp
    }
    
    func addAdditionalHeaders(to headers: [String: String]?) -> [String: String]? {
        addContentType(.json, to: headers)
    }
}
