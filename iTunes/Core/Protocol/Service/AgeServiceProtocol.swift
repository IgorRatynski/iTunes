//
//  AgeServiceProtocol.swift
//  iTunes
//
//  Created by Igor Ratynski on 31.08.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import UIKit

protocol AgeServiceProtocol {
  var isAdult: Bool? { get set }
  var isNeedToAsk: Bool { get }
  
  func setIsAdult(_: Bool) -> (UIAlertAction) -> Void
}
