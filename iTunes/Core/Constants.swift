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
  static let songCellIdentifier = SongTableViewCell.reuseIdentifier
  static let noSearchResultsCellIdentifier = NoSearchResultsCell.reuseIdentifier
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
      
      enum Size {
        static var image: CGFloat { 100 }
      }
      
      enum Offset {
        static var `default`: CGFloat { 16 }
        static var halfDefault: CGFloat { 16 }
      }
      
      enum CornerRadius {
        static var image: CGFloat { 8 }
        static var text: CGFloat { 4 }
      }
    }
  }
  
}
