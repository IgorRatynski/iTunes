//
//  AlertStrings.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 30.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Foundation

enum AlertStrings: String {
    case error = "Error"
    case ok = "OK"
    case cancel = "Cancel"
    case yes = "Yes"
    case no = "No"
    
    var localized: String {
        return NSLocalizedString(rawValue, comment: "Alert string")
    }
}
