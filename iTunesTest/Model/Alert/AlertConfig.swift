//
//  AlertConfig.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 24.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import UIKit

struct AlertConfig: AlertConfigProtocol {
  let title: String?
  let message: String?
  
  let actions: [AlertAction]?
  
  init(title: String?, message: String?, actions: [AlertAction]? = nil) {
    self.title = title
    self.message = message
    self.actions = actions
  }
}
