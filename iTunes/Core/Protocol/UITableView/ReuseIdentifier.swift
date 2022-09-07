//
//  ReuseIdentifier.swift
//  iTunes
//
//  Created by Igor Ratynski on 07.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import UIKit

protocol ReuseIdentifying {
  static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
  static var reuseIdentifier: String {
    return String(describing: Self.self)
  }
}

extension UITableViewCell: ReuseIdentifying { }
