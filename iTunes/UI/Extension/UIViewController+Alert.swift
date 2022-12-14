//
//  UIViewController+Alert.swift
//  iTunes
//
//  Created by Igor Ratynski on 24.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import UIKit

extension UIViewController {
  func showSystemAlert(with config: AlertConfigProtocol) {
    let alertController = UIAlertController(configuration: config)
    view.endEditing(true)
    if config.actions == nil {
      let okAction = UIAlertAction(title: R.string.localization.alertOk() , style: .cancel, handler: nil)
      alertController.addAction(okAction)
    }
    present(alertController, animated: true, completion: nil)
  }
}
