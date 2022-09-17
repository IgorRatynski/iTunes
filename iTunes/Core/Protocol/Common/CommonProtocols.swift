//
//  LoadableProtocol.swift
//  iTunes
//
//  Created by Igor Ratynski on 29.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import ReactiveSwift
import Result

protocol ReactiveLoadable {
  var loading: MutableProperty<Bool?> { get }
}

protocol Setupable {
  func setup(model: Any)
}
