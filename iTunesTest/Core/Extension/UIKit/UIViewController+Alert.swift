//
//  UIViewController+Alert.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 24.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import UIKit

extension UIViewController {
  func showSystemAlert(with config: AlertConfig) {
    let alertController = UIAlertController(configuration: config)
    view.endEditing(true)
    let okAction = UIAlertAction(title: AlertStrings.ok.localized , style: .cancel, handler: nil)
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }
}
