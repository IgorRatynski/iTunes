//
//  ImageService.swift
//  iTunes
//
//  Created by Igor Ratynski on 28.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Moya

// MARK: Methods
enum ImageService {
  case getImage(url: URL)
}

// MARK: Request details
extension ImageService: TargetType {
  var baseURL: URL {
    switch self {
      case .getImage(let url):
        return url
    }
  }
  
  var path: String {
    switch self {
      case .getImage:
        return ""
    }
  }
  
  var method: Moya.Method {
    switch self {
      case .getImage:
        return .get
    }
  }
  
  var task: Task {
    switch self {
      case .getImage:
        return .requestPlain
    }
  }
}
