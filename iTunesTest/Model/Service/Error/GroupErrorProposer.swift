//
//  GroupErrorProposer.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 30.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Foundation

class GroupErrorProposer: ErrorProposer {
  
  // MARK: Private properties
  fileprivate var proposers: [ErrorProposer]
  
  init(proposers: [ErrorProposer]) {
    self.proposers = proposers
  }
  
  func proposeAction(for error: Error) -> PropositionAction? {
    for proposer in proposers {
      guard let action = proposer.proposeAction(for: error) else {continue}
      return action
    }
    return nil
  }
}
