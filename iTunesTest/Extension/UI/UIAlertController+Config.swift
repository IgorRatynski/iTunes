//
//  UIAlertController+Config.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 24.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import UIKit

#warning("Comment all app or remove")
// MARK: AlertController convience init
/**
 Extension for UIAlertController for AlertControllerConfiguration configuration
 */
extension UIAlertController {
    convenience init(configuration: AlertConfig, dismissHandler: (() -> Void)? = nil) {
        self.init(title: configuration.title, message: configuration.message, preferredStyle: .alert)
    }
}
