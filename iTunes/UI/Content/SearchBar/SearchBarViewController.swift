//
//  SearchBarViewController.swift
//  iTunes
//
//  Created by Igor Ratynski on 14.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import Result
import ReactiveCocoa
import ReactiveSwift

class SearchBarViewController: BaseViewController, SearchBarViewControllerProtocol {
  
  // MARK: UI
  @IBOutlet private var searchBar: UISearchBar!
  
  // MARK: Private properties
  let viewModel: SearchBarViewModelProtocol = SearchBarViewModel()
  
  // MARK: Reactive properties
  private var searchPressed: Signal<(), NoError>
  private var searchPressedObserver: Signal<(), NoError>.Observer
  
  // MARK: Lifecycle
  required init?(coder aDecoder: NSCoder) {
    (searchPressed, searchPressedObserver) = Signal.pipe()
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
}

// MARK: Actions
extension SearchBarViewController  {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchPressedObserver.send(value: ())
  }
}

// MARK: Setup
private extension SearchBarViewController {
  func setup() {
    setupSearchBar()
    bind()
  }
  
  func setupSearchBar() {
    searchBar.delegate = self
    searchBar.placeholder = Text.searchPlaceholder
    searchBar.becomeFirstResponder()
  }
}

// MARK: Binding
private extension SearchBarViewController {
  func bind() {
    viewModel.searchPressed <~ searchPressed
    viewModel.searchStringChanged <~ searchBar.reactive.continuousTextValues
  }
}
