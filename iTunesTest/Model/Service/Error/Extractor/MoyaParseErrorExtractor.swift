//
//  MoyaParseErrorExtractor.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 30.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Moya

class MoyaParseErrorExtractor: ErrorExtractor {
  func extractor(for error: Error) -> ErrorExtractor? {
    guard mappingOrDecodeError(for: error) != nil else {return nil}
    return self
  }
  
  func extract(error: Error) -> Error? {
    mappingOrDecodeError(for: error)
  }
}

// MARK: Supporting methods
private extension MoyaParseErrorExtractor {
  func mappingOrDecodeError(for error: Swift.Error) -> Error? {
    guard let moyaError = error as? Moya.MoyaError else {return nil}
    
    switch moyaError {
      case .imageMapping, .jsonMapping, .stringMapping:
        return moyaError
      case .underlying(let underlyingError, _):
        guard underlyingError is DecodingError else {return nil}
        return moyaError
      case .objectMapping(let objMappingError, _):
        return objMappingError
      default:
        return nil
    }
  }
}
