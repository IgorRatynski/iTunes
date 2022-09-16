//
//  Localiztion.swift
//  iTunes
//
//  Created by Igor Ratynski on 15.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import Foundation

private extension String {
  static let empty = String()
}

private extension Optional where Wrapped == String {
  var orEmpty: String {
    return self ?? .empty
  }
}

enum LocalizedTables: String {
  case error      = "Error"
  case `default`  = "Localization"
}

extension String {
  func localized(from table: LocalizedTables = .default, in bundle: Bundle = .main) -> String {
    bundle.localizedString(forKey: self, value: "💥", table: table.rawValue)
  }
  
  func localized(array args: [CVarArg], from table: LocalizedTables = .default) -> String {
    localized(args, from: table)
  }

  func localized(_ args: CVarArg..., from table: LocalizedTables = .default) -> String {
    String(format: localized(from: table), args)
  }
}
