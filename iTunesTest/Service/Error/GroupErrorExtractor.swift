//
//  GroupErrorExtractor.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 30.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Foundation

class GroupErrorExtractor: ErrorExtractor {
    
    // MARK: Private properties
    fileprivate var extractors: [ErrorExtractor]
    
    init(extractors: [ErrorExtractor]) {
        self.extractors = extractors
    }
    
    func extract(error: Error) -> Error? {
        for extractor in extractors {
            guard let error = extractor.extract(error: error) else {continue}
            return error
        }
        
        return nil
    }
}
