//
//  ContentViewController.swift
//  iTunes
//
//  Created by Igor Ratynski on 22.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Result
import ReactiveCocoa
import ReactiveSwift

class ContentViewController: BaseViewController, ErrorActionController, SkeletonDisplayable, UISearchBarDelegate {
  
  // MARK: UI
  @IBOutlet private weak var searchBar: UISearchBar!
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var spinner: UIActivityIndicatorView!
  
  // MARK: Private properties
  private let viewModel: ContentViewModelProtocol = ContentViewModel()
  private let ageService: AgeService = AgeService()
  
  // MARK: Reactive properties
  private var searchPressed: Signal<(), NoError>
  private var searchPressedObserver: Signal<(), NoError>.Observer
  
  var loading: BindingTarget<Bool> {
    BindingTarget(lifetime: lifetime) { [unowned self] next in
      next ? self.showSkeleton() : self.hideSkeleton()
    }
  }
  
  // MARK: Lifecycle    
  required init?(coder aDecoder: NSCoder) {
    (searchPressed, searchPressedObserver) = Signal.pipe()
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if ageService.isNeedToAsk {
      showSystemAlert(with: viewModel.adultAlertConfig)
    }
  }
}

// MARK: Actions
extension ContentViewController  {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchPressedObserver.send(value: ())
  }
}

// MARK: Setup
private extension ContentViewController {
  func setup() {
    setupSearchBar()
    setupTableView()
    setupSpinner()
    bind()
  }
  
  func setupSearchBar() {
    searchBar.delegate = self
  }
  
  func setupTableView() {
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
    tableView.keyboardDismissMode = .onDrag
    tableView.dataSource = viewModel.tableViewDataSource
    tableView.estimatedRowHeight = UITableView.automaticDimension
    
    tableView.register(NoSearchResultsCell.self)
  }
  
  func setupSpinner() {
    view.addToCenterSubview(spinner)
    spinner.hidesWhenStopped = true
    spinner.style = .large
    spinner.color = .red
  }
}

// MARK: Binding
private extension ContentViewController {
  func bind() {
    // MARK: In
    spinner.reactive.isAnimating <~ viewModel.loading
    loading <~ viewModel.loading
    actionExecution <~ viewModel.errorDispatcher.action
    tableView.reactive.reloadData <~ viewModel.reloadTable
    
    // MARK: Out
    viewModel.searchAction <~ searchPressed
    viewModel.searchStringChanged <~ searchBar.reactive.continuousTextValues
  }
}
