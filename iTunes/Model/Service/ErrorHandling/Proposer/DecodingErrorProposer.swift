//
//  DecodingErrorProposer.swift
//  iTunes
//
//  Created by Igor Ratynski on 30.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Foundation

class DecodingErrorProposer: ErrorProposer {
  func proposeAction(for error: Error) -> PropositionAction? {
    guard let decodingError = error as? DecodingError else { return nil }
    
    var message = error.localizedDescription
    
    switch decodingError {
      case .dataCorrupted(let context):
        message = context.debugDescription
      case .keyNotFound(let key, _):
        message = R.string.localization.errorKeyNotFound(key.stringValue)
      case .typeMismatch(_, let context):
        let keys = context.codingPath.map({ $0.stringValue })
          .joined(separator: ", ")
        message = R.string.localization.errorTypeDoesNotMatch(keys)
      case .valueNotFound(_, let context):
        let keys = context.codingPath
          .map { $0.stringValue }
          .joined(separator: ", ")
        message = R.string.localization.errorValuesNotFound(keys)
      @unknown default:
        message = R.string.localization.errorUnknownDecoding()
    }
    
    let alertConfig = AlertConfig(title: nil, message: message)
    
    return .alert(alertConfig)
  }
}
