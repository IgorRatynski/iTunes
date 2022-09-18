//
//  ContentText.swift
//  iTunes
//
//  Created by Igor Ratynski on 07.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import UIKit

extension TableViewViewModel {
  enum Text {
    static var noSearchResult: String { R.string.localization.tableViewNoSearchResult() }
  }
  
  enum Image {
    static var noSearchResult: UIImage { R.image.noSearchResults()! }
  }
}
