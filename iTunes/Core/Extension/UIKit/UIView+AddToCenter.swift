//
//  UIView+AddToCenter.swift
//  iTunes
//
//  Created by Igor Ratynski on 12.05.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import UIKit

extension UIView {
  func addToCenterSubview(_ subview: UIView) {
    NSLayoutConstraint.activate([
      subview.centerXAnchor.constraint(equalTo: centerXAnchor),
      subview.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
}
