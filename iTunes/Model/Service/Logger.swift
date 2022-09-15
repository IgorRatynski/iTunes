//
//  Logger.swift
//  iTunes
//
//  Created by Igor Ratynski on 15.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import Foundation

protocol LoggerProtocol {
  func log(message: String)
}

struct Logger: LoggerProtocol {
  
  private let identificator: String?
  
  init(identificator: String? = nil) {
    self.identificator = identificator
  }
  
  func log(message: String) {
    print(identificator ?? "🔥" + " :" + message)
  }
}
