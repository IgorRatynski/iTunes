//
//  UIView+AddToCanter.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 12.05.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import UIKit

extension UIView {
    func addToCenter(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        subview.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
