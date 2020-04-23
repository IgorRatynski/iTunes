//
//  ContentType.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 22.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Foundation

public enum ContentType {
    case json
    case formData
    case imagePng
    case urlForm
    
    public var contentType: String {
        switch self {
        case .json:
            return "application/json"
        case .formData:
        #warning("check")
            return "multipart/form-data"
        case .imagePng:
            return "image/png"
        case .urlForm:
        #warning("check")
            return "application/x-www-form-urlencoded"
        }
    }
}

