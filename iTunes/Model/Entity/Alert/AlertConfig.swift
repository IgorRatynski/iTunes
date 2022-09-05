//
//  AlertConfig.swift
//  iTunes
//
//  Created by Igor Ratynski on 24.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import UIKit

struct AlertConfig: AlertConfigProtocol {
  let title: String?
  let message: String?
  let messageForUser: String?
  let isVisibleForUser: Bool
  
  let actions: [AlertAction]?
  
  init(title: String?, message: String?, messageForUser: String? = nil, isVisibleForUser: Bool = false, actions: [AlertAction]? = nil) {
    self.title = title
    self.message = message
    self.messageForUser = message
    self.isVisibleForUser = isVisibleForUser
    self.actions = actions
  }
}
