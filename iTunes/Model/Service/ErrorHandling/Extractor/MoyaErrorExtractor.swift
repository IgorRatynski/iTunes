//
//  MoyaErrorExtractor.swift
//  iTunes
//
//  Created by Igor Ratynski on 30.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Moya

class MoyaErrorExtractor: ErrorExtractor {
  func extractor(for error: Error) -> ErrorExtractor? {
    guard let moyaError = MoyaErrorExtractor.moyaError(from: error) else {return nil}
    
    switch moyaError {
      case .statusCode, .underlying, .objectMapping:
        return self
      default:
        return nil
    }
  }
  
  func extract(error: Error) -> Error? {
    guard let moyaError = MoyaErrorExtractor.moyaError(from: error) else {return nil}
    
    switch moyaError {
      case .underlying(let underlyingError, _):
        let nsError = underlyingError as NSError
        
        guard nsError.domain == NSURLErrorDomain else {return nil}
        
        return NSURLDomainError(underlyingError: nsError)
      case .objectMapping(let error, _):
        return error
      default:
        return nil
    }
  }
}

// MARK: Supporting methods
extension MoyaErrorExtractor {
  static func moyaError(from error: Error) -> Moya.MoyaError? {
    error as? Moya.MoyaError
  }
}
