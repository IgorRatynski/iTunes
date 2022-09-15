//
//  UITableViewCell+ReuseIdentifying.swift
//  iTunes
//
//  Created by Igor Ratynski on 10.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import UIKit

extension ReuseIdentifying {
  static var reuseIdentifier: String {
    return String(describing: Self.self)
  }
}

extension UITableViewCell: ReuseIdentifying { }
