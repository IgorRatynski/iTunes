//
//  MoyaUnderlyingNSURLErrorExtractor.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 30.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Moya

class MoyaUnderlyingNSURLErrorExtractor: ErrorExtractor {
    func extractor(for error: Swift.Error) -> ErrorExtractor? {
        guard nsURLErrorDomainError(for: error) != nil else {return nil}
        return self
    }
    
    func extract(error: Swift.Error) -> Swift.Error? {
        guard let nsURLErrorDomainError = nsURLErrorDomainError(for: error) else {return nil}
        return NSURLDomainError(underlyingError: nsURLErrorDomainError)
    }
}

// MARK: Supporting methods
private extension MoyaUnderlyingNSURLErrorExtractor {
    func nsURLErrorDomainError(for error: Swift.Error) -> NSError? {
        guard let moyaError = MoyaErrorExtractor.moyaError(from: error) else {return nil}
        
        switch moyaError {
        case .underlying(let underlyingError, _):
            let nsError = underlyingError as NSError
            
            guard nsError.domain == NSURLErrorDomain else {return nil}
            
            return nsError
        default:
            return nil
        }
    }
}
