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
        message = "Error.keyNotFound".localized(key.stringValue)
      case .typeMismatch(_, let context):
        let keys = context.codingPath.map({ $0.stringValue })
          .joined(separator: ", ")
        message = "Error.typeDoesNotMatch".localized(keys)
      case .valueNotFound(_, let context):
        let keys = context.codingPath
          .map { $0.stringValue }
          .joined(separator: ", ")
        message = "Error.valuesNotFound".localized(keys)
      @unknown default:
        message = "Error.unknownDecoding".localized
    }
    
    let alertConfig = AlertConfig(title: nil, message: message)
    
    return .alert(alertConfig)
  }
}
