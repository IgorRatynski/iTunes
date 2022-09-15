//
//  DefaultErrorProposer.swift
//  iTunes
//
//  Created by Igor Ratynski on 30.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import UIKit

class DefaultErrorProposer: ErrorProposer {
  
  // MARK: properties
  var message = "Error.shouldNotHaveHappened".localized(from: .error)
  
  func proposeAction(for error: Error) -> PropositionAction? {
    let title = AlertStrings.error.localized
    let alertConfig = AlertConfig(title: title, message: message)
    return .alert(alertConfig)
  }
  
  init() { }
}
