//
//  BaseViewController.swift
//  iTunes
//
//  Created by Igor Ratynski on 22.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import UIKit
import ReactiveSwift

class BaseViewController: UIViewController {
  // MARK: Reactive
  let (lifetime, token) = Lifetime.make()
}

protocol ErrorActionController: UIViewController {
  var actionExecution: BindingTarget<PropositionAction> { get }
}

extension ErrorActionController where Self: BaseViewController {
  var actionExecution: BindingTarget<PropositionAction> {
    return BindingTarget(lifetime: lifetime, action: { [weak self] action in
      guard let self = self else {return}
      
      switch action {
        case .alert(let type):
          self.showSystemAlert(with: type)
        default:
          return
      }
    })
  }
}
