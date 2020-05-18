//
//  ReactiveErrorDispatcher.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 30.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import ReactiveSwift
import Result

class ReactiveErrorDispatcher: ErrorDispatcher {
    
    // MARK: Reactive
    var action: Signal<PropositionAction, NoError>
    fileprivate var actionObserver: Signal<PropositionAction, NoError>.Observer
    
    override init(proposer: ErrorProposer,
                  extractor: ErrorExtractor?) {
        (action, actionObserver) = Signal.pipe()
        
        super.init(proposer: proposer, extractor: extractor)
        
        self.executor = self
    }
}

//// MARK: ErrorActionExecutor
extension ReactiveErrorDispatcher: ErrorActionExecutor {
    func execute(action: PropositionAction) {
        actionObserver.send(value: action)
    }
}
