//
//  UITableView+Reusable.swift
//  iTunes
//
//  Created by Igor Ratynski on 07.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import UIKit

extension UITableView {
  func register<T: UITableViewCell>(_ cellClass: T.Type) {
    register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
  }
}
