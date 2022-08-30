//
//  ITunesSearchEncoding.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 29.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Alamofire

struct ITunesSearchEncoding: ParameterEncoding {
  static let `default` = ITunesSearchEncoding()
  
  func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
    var urlRequest = try urlRequest.asURLRequest()
    
    guard let parameters = parameters?.first?.value as? ITunesParams else {
      throw AFError.parameterEncodingFailed(reason: .propertyListEncodingFailed(error: NSError.init() ))
    }
    
    let url = urlRequest.url!.absoluteString + "?term=\(parameters.asString.lowercased())".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    
    urlRequest.url = URL(string: url)!
    
    return urlRequest
  }
}
