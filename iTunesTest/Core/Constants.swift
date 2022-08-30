//
//  Constants.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 28.08.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import Foundation

enum Constants {
  
}


// MARK: Persistent keys
enum PersistentKeys {
  static let isAdult = "kIsAdult"
}

enum Urls {
  static let base = "https://itunes.apple.com"
  
  enum Endpoint {
      static let baseURL = URL(string: base)!
  }
}
