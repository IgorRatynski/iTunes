//
//  Config.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 30.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Foundation

open class Config {
  static let proposers: ErrorProposer = {
    let appProposers: [ErrorProposer] = [
      NSURLErrorProposer(),
      DecodingErrorProposer(),
      AppInternalErrorProposer(),
      DefaultErrorProposer()
//      ValidationErrorProposer()
    ]
    return GroupErrorProposer(proposers: appProposers)
  }()
  
  static let extractors: ErrorExtractor = {
    let appExtractors: [ErrorExtractor] = [
      MoyaUnderlyingNSURLErrorExtractor(),
      MoyaErrorExtractor(),
      MoyaParseErrorExtractor(),
      NSURLErrorDomainExtractor(),
      AppInternalErrorExtractor()
    ]
    return GroupErrorExtractor(extractors: appExtractors)
  }()
}
