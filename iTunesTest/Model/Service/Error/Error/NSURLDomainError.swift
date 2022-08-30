//
//  NSURLDomainError.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 30.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Foundation

struct NSURLDomainError: Swift.Error {
  let underlyingError: NSError
  
  init(underlyingError: NSError) {
    self.underlyingError = underlyingError
  }
}
