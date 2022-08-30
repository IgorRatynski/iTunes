//
//  AgeService.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 23.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import UIKit

class AgeService: AgeServiceProtocol {
  @UserDefault(PersistentKeys.isAdult)
  var isAdult: Bool?

  var isNeedToAsk: Bool {
    isAdult == nil
  }
  
  func setIsAdult(_ flag: Bool) -> (UIAlertAction) -> Void {
    { [weak self] _ in
      self?.isAdult = flag
    }
  }
}
