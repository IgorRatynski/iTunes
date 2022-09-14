//
//  SearchBarViewModelProtocol.swift
//  iTunes
//
//  Created by Igor Ratynski on 14.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

protocol SearchBarViewModelProtocol {
  // In
  var searchStringChanged: BindingTarget<String?> { get }
  var searchPressed: BindingTarget<()> { get }
  
  // Out
  var searchAction: Signal<(), NoError> { get }
  var searchString: Signal<String?, NoError> { get }
}
