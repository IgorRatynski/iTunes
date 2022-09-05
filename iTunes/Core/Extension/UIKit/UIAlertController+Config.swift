//
//  UIAlertController+Config.swift
//  iTunes
//
//  Created by Igor Ratynski on 24.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import UIKit

extension UIAlertController {
  convenience init(configuration: AlertConfigProtocol, dismissHandler: (() -> Void)? = nil) {
    self.init(title: configuration.title, message: configuration.message, preferredStyle: .alert)
    configuration.actions?.forEach {
      addAction(.init(title: $0.title, style: $0.style, handler: $0.handler))
    }
  }
}
