//
//  ITunesParams.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 22.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Foundation

struct ITunesParams: Encodable {
    
//    static private let allowedCharacters = CharacterSet.init([]) // check:
    
    let term: String

    init(term: String) {
        self.term = term
    }
}
