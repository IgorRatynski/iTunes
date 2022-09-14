//
//  TableViewViewController.swift
//  iTunes
//
//  Created by Igor Ratynski on 14.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//


import Result
import ReactiveSwift

protocol TableViewViewControllerProtocol: SkeletonDisplayable {
  var viewModel: TableViewViewModelProtocol { get }
}

class TableViewViewController: BaseViewController, TableViewViewControllerProtocol {
  
  // MARK: UI
  @IBOutlet private var tableView: UITableView!
  
  // MARK: Private properties
  let viewModel: TableViewViewModelProtocol = TableViewViewModel()
  
  // MARK: Reactive properties
  var loading: BindingTarget<Bool> {
    BindingTarget(lifetime: lifetime) { [unowned self] next in
      next ? self.showSkeleton() : self.hideSkeleton()
    }
  }
  
  // MARK: Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
}

// MARK: Setup
private extension TableViewViewController {
  func setup() {
    setupTableView()
    bind()
  }
  
  func setupTableView() {
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
    tableView.keyboardDismissMode = .onDrag
    tableView.dataSource = viewModel.tableViewDataSource
    tableView.estimatedRowHeight = UITableView.automaticDimension
    
    tableView.register(NoSearchResultsCell.self)
  }
}

// MARK: Binding
private extension TableViewViewController {
  func bind() {
    tableView.reactive.reloadData <~ viewModel.reloadTable
    loading <~ viewModel.loading
  }
}
