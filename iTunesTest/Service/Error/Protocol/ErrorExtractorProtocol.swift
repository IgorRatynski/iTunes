//
//  ErrorExtractor.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 30.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Foundation

protocol ErrorExtractor {
    func extract(error: Error) -> Error?
}
