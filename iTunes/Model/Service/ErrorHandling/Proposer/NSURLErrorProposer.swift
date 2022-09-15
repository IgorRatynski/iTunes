//
//  NSURLErrorProposer.swift
//  iTunes
//
//  Created by Igor Ratynski on 30.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Alamofire

class NSURLErrorProposer: ErrorProposer {
  func proposeAction(for error: Error) -> PropositionAction? {
    guard let nsURLErrorDomainError = error as? NSURLDomainError else { return nil }
    
    let nsUrlError = nsURLErrorDomainError.underlyingError
    
    var message: String
    switch nsUrlError.code {
      case NSURLErrorCancelled:
        return .nothing
      case NSURLErrorCannotFindHost, NSURLErrorDNSLookupFailed, NSURLErrorTimedOut, NSURLErrorResourceUnavailable, NSURLErrorCannotConnectToHost:
        message = "Error.serverNotAvailable".localized
      case NSURLErrorNetworkConnectionLost, NSURLErrorResourceUnavailable,
        NSURLErrorNotConnectedToInternet, NSURLErrorRedirectToNonExistentLocation:
        message = "Error.noConnection".localized
      default:
        return nil
    }
    
    let alertConfig = AlertConfig(title: nil, message: message)
    
    return .alert(alertConfig)
  }
}
