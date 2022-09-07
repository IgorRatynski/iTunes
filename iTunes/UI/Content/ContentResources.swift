//
//  ContentText.swift
//  iTunes
//
//  Created by Igor Ratynski on 07.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import UIKit

extension ContentViewModel {
  enum Text {
    static var noSearchResult: String { "Content.noSearchResult".localized }
  }
  
  enum Image {
    static var noSearchResult: UIImage { UIImage(named: "no-search-results")! }
  }
}
