//
//  ErrorDispatcher.swift
//  iTunes
//
//  Created by Igor Ratynski on 30.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import ReactiveSwift
import Result

class ErrorDispatcher {
  
  // MARK: Public properties
  weak var executor: ErrorActionExecutor?
  
  // MARK: Private properties
  fileprivate var proposer: ErrorProposer
  fileprivate var extractor: ErrorExtractor?
  
  init(proposer: ErrorProposer,
       extractor: ErrorExtractor?) {
    self.proposer = proposer
    self.extractor = extractor
  }
  
  /**
   Method that return action
   */
  func handle(error: Error) {
    let error = extractor?.extract(error: error) ?? error
    
    guard let action = proposer.proposeAction(for: error) else {
      // TODO: Mock analytics logger
      print("Unhandled error: \(error)")
      return
    }
    executor?.execute(action: action)
  }
}
