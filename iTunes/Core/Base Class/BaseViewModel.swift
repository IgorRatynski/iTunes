//
//  BaseViewModel.swift
//  iTunes
//
//  Created by Igor Ratynski on 22.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import ReactiveSwift

open class BaseViewModel: ReactiveBase {
  
  // MARK: Properties
  private(set) var errorDispatcher: ReactiveErrorDispatcher
  
  // MARK: Lifecycle
  init(dispatcher: ReactiveErrorDispatcher = ReactiveErrorDispatcher(proposer: Config.proposers, extractor: Config.extractors)) {
    self.errorDispatcher = dispatcher
  }
}
