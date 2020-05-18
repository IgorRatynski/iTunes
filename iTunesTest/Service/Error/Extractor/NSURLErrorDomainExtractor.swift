//
//  NSURLErrorDomainExtractor.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 30.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Foundation

class NSURLErrorDomainExtractor: ErrorExtractor {
    func extractor(for error: Swift.Error) -> ErrorExtractor? {
        guard nsURLErrorDomainError(for: error) != nil else {return nil}
        return self
    }
    
    func extract(error: Swift.Error) -> Swift.Error? {
        nsURLErrorDomainError(for: error)
    }
}

// MARK: Supporting methods
private extension NSURLErrorDomainExtractor {
    func nsURLErrorDomainError(for error: Swift.Error) -> NSURLDomainError? {
        let nsError = error as NSError
        guard nsError.domain == NSURLErrorDomain else {return nil}
        return NSURLDomainError(underlyingError: nsError)
    }
}
