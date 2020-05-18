//
//  ErrorService.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 30.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import ReactiveSwift
import Result

enum PropositionAction {
    case nothing
    case alert(AlertConfig)
}
