//
//  SearchBarViewModel.swift
//  iTunes
//
//  Created by Igor Ratynski on 14.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import UIKit
import Result
import ReactiveSwift

class SearchBarViewModel: BaseViewModel, SearchBarViewModelProtocol {
  
  // MARK: Public properties
  
  // In
  var searchPressed: BindingTarget<()> {
    BindingTarget(lifetime: lifetime, action: { [weak self] value in
      self?.searchActionObserver.send(value: ())
    })
  }
  
  var searchStringChanged: BindingTarget<String?> {
    BindingTarget(lifetime: lifetime, action: { [weak self] value in
      self?.searchStringObserver.send(value: value)
    })
  }
  
  // Out
  let searchAction: Signal<(), NoError>
  private let searchActionObserver: Signal<(), NoError>.Observer
  
  let searchString: Signal<String?, NoError>
  private let searchStringObserver: Signal<String?, NoError>.Observer
  
  // MARK: - Lifecycle
  init() {
    (searchAction, searchActionObserver) = Signal.pipe()
    (searchString, searchStringObserver) = Signal.pipe()
    super.init()
  }
}
