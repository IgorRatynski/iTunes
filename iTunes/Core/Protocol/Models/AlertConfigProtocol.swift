//
//  AlertConfigProtocol.swift
//  
//
//  Created by Igor Ratynski on 31.08.2022.
//

import UIKit

typealias ActionStyle = UIAlertAction.Style
typealias ActionHandler = (UIAlertAction) -> Void
typealias AlertAction = (title: String, style: ActionStyle, handler: ActionHandler)

protocol AlertConfigProtocol {
  var title: String? { get }
  var message: String? { get }
  
  var actions: [AlertAction]? { get }
}
