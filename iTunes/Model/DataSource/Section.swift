//
//  Section.swift
//  iTunes
//
//  Created by Igor Ratynski on 14.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import Foundation

enum SettingType {
  
  case song(model: ArtistModelProtocol)
  case noSearchResults(model: NoSearchResultsModelProtocol)
  
  var identifier: String {
    switch self {
      case .song: return Constants.songCellIdentifier
      case .noSearchResults: return Constants.noSearchResultsCellIdentifier
    }
  }
}

struct Section {
  var title: String?
  var cellData: [SettingType]

  init(title: String?, cellData: [SettingType]) {
    self.title = title
    self.cellData = cellData
  }
}