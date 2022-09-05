//
//  ITunesService.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 22.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Moya

// API link
// https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/Searching.html

// MARK: Methods
enum ITunesService {
  case search(ITunesParams)
}

// MARK: Request details
extension ITunesService: TargetType {
  var path: String {
    switch self {
      case .search:
        return "search"
    }
  }
  
  var method: Moya.Method {
    switch self {
      case .search:
        return .get
    }
  }
  
  var task: Task {
    switch self {
      case .search(let params):
        return .requestParameters(parameters: ["term" : params], encoding: ITunesSearchEncoding.default)
    }
  }
}
