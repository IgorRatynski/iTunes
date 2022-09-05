//
//  String+Localization.swift
//  iTunes
//
//  Created by Igor Ratynski on 28.08.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import Foundation

extension String {

  var localized: String {
    NSLocalizedString(self, comment: "\(self)_comment")
  }
  
  func localized(array args: [CVarArg]) -> String {
    localized(args)
  }
  
  func localized(_ args: CVarArg...) -> String {
    String(format: localized, args)
  }
}

/// How to use
// "hello".localized
// "hello %@! you are %d years old".localized(["Mike", 25])
// "hello %@! you are %d years old".localized("Mike", 25)
