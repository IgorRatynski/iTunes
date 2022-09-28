//
//  TableViewViewController.swift
//  iTunes
//
//  Created by Igor Ratynski on 14.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//


import Result
import ReactiveSwift

class TableViewViewController: BaseViewController, TableViewViewControllerProtocol {
  
  // MARK: UI
  @IBOutlet private var tableView: UITableView!
  
  // MARK: Private properties
  let viewModel: TableViewViewModelProtocol = TableViewViewModel(screenHeight: UIScreen.main.bounds.height,
                                                                 skeletonCellHeight: SongTableViewCell().frame.height)
  
  // MARK: Reactive properties
  var loading: BindingTarget<Bool?> {
    BindingTarget(lifetime: lifetime) { [unowned self] next in
      guard let next = next else { return }
      updateState(by: next)
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
    tableView.isScrollEnabled = false
    
    tableView.register(NoSearchResultsCell.self)
    tableView.register(SongTableViewCell.self)
  }
  
  func updateState(by loading: Bool) {
    loading ? showSkeleton() : hideSkeleton()
    tableView.beginUpdates()
    tableView.setContentOffset(.zero, animated: false)
    tableView.endUpdates()
    tableView.showsVerticalScrollIndicator = !loading
    tableView.isScrollEnabled = !loading
  }
}

// MARK: Binding
private extension TableViewViewController {
  func bind() {
    loading <~ viewModel.loading
    tableView.reactive.reloadData <~ viewModel.reloadTable
  }
}
