//
//  Moya+Predefined.swift
//  iTunes
//
//  Created by Igor Ratynski on 22.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Moya
import ReactiveSwift

extension TargetType {
  
  var sampleData: Data {
    Data()
  }
  
  var baseURL: URL {
    Urls.Endpoint.baseURL
  }
  
  var headers: [String: String]? {
    addAdditionalHeaders(to: nil)
  }
  
  func addContentType(_ type: ContentType, to headers: [String: String]?) -> [String: String]? {
    var headers: [String: String] = headers ?? [:]
    headers["Content-Type"] = type.contentType
    headers["User-Agent"] = ""
    return headers
  }
  
  func addAdditionalHeaders(to headers: [String: String]?) -> [String: String]? {
    addContentType(.json, to: headers)
  }
}
