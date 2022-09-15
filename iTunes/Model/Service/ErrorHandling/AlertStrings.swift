//
//  AlertStrings.swift
//  iTunes
//
//  Created by Igor Ratynski on 30.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Foundation

enum AlertStrings: String {
  case error = "Alert.error"
  case ok = "Alert.ok"
  case cancel = "Alert.сancel"
  case yes = "Alert.yes"
  case no = "Alert.no"
  
  case areYouAdult = "Alert.areYouAdult"
  
  var localized: String {
    rawValue.localized()
  }
}
