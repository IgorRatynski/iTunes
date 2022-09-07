//
//  AppInternalErrorExtractor.swift
//  iTunes
//
//  Created by Igor Ratynski on 18.05.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Foundation

class AppInternalErrorExtractor: ErrorExtractor {
  func extractor(for error: Swift.Error) -> ErrorExtractor? {
    guard appInternalError(for: error) != nil else {return nil}
    return self
  }
  
  func extract(error: Swift.Error) -> Swift.Error? {
    appInternalError(for: error)
  }
}

// MARK: Supporting methods
private extension AppInternalErrorExtractor {
  func appInternalError(for error: Swift.Error) -> AppInternalError? {
    error as? AppInternalError
  }
}
