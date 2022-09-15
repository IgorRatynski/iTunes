//
//  AppInternalErrorProposer.swift
//  iTunes
//
//  Created by Igor Ratynski on 18.05.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Foundation

class AppInternalErrorProposer: ErrorProposer {
  func proposeAction(for error: Error) -> PropositionAction? {
    switch error {
      case is LoadingError:
        let message = "Error.dataIsLoading".localized
        let alertConfig = AlertConfig(title: nil, message: message)
        return .alert(alertConfig)
        
      case is SearchStringError:
        let message = "Error.emptySearchString".localized
        let alertConfig = AlertConfig(title: nil, message: message)
        return .alert(alertConfig)
        
      default:
        return nil
    }
  }
}
