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
    guard error is LoadingError else {return nil}
    let message = NSLocalizedString("Данные в процессе загрузки...", comment: "AppInternalErrorProposer error")
    let alertConfig = AlertConfig(title: nil, message: message)
    
    return .alert(alertConfig)
  }
}
