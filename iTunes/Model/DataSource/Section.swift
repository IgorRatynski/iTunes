//
//  Section.swift
//  iTunes
//
//  Created by Igor Ratynski on 14.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import Foundation

enum CellType: CellTypeProtocol {
  
  // MARK: Cases
  case song(model: ArtistModelProtocol?)
  case noSearchResults(model: NoSearchResultsModelProtocol)
  
  // MARK: Properties
  var identifier: String {
    switch self {
      case .song: return Constants.songCellIdentifier
      case .noSearchResults: return Constants.noSearchResultsCellIdentifier
    }
  }
}

struct Section: SectionProtocol {
  var title: String?
  var cellData: [CellTypeProtocol]

  init(title: String? = nil, cellData: [CellTypeProtocol]) {
    self.title = title
    self.cellData = cellData
  }
}
