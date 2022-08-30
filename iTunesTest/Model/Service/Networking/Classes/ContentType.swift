//
//  ContentType.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 22.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Foundation

enum ContentType {
  case json
  case image
  
  var contentType: String {
    switch self {
      case .json:
        return "application/json"
      case .image:
        return "image/*"
    }
  }
}
