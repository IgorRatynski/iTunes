//
//  Constants.swift
//  iTunes
//
//  Created by Igor Ratynski on 28.08.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import Foundation
import CoreGraphics

enum Constants {
  static let songCellIdentifier = "SongCell"
  static let noSearchResultsCellIdentifier = "NoSearchResultsCell"
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

enum Size {
  
  // MARK: TableView
  enum TableView {
    
    // MARK: Cell
    enum Cell {
      static var imageCornerRadius: CGFloat { 8 }
      static var textCornerRadius: CGFloat { 4 }
    }
  }
  
}
