//
//  ITunesService.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 22.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Moya

enum ITunesService: TargetType {
  case search(ITunesParams, explicit: Bool)
  
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
      case .search(let params, explicit: let isExplicit):
        return .requestParameters(parameters: ["term" : params, "explicit": isExplicit.string], encoding: ITunesSearchEncoding.default)
    }
  }
}

private extension Bool {
  var string: String {
    self ? AlertStrings.yes.rawValue : AlertStrings.no.rawValue
  }
}
