//
//  ErrorProposerProtocol.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 18.05.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Foundation

protocol ErrorProposer {
  func proposeAction(for error: Error) -> PropositionAction?
}

protocol ErrorActionExecutor: AnyObject {
  func execute(action: PropositionAction)
}
