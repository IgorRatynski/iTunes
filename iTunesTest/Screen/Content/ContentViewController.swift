//
//  ContentViewController.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 22.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Result
import ReactiveCocoa
import ReactiveSwift

class ContentViewController: BaseViewController, ErrorActionController, UISearchBarDelegate {
    
    // MARK: UI
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    // TODO: Replace spinner by skeleton view
    private var spinner: UIActivityIndicatorView!
    
    // MARK: Properties
    private var viewModel: ContentViewModelProtocol = ContentViewModel()
    
    // MARK: Reactive
    private var searchPressed: Signal<(), NoError>
    private var searchPressedObserver: Signal<(), NoError>.Observer
    
    // MARK: Lifecycle
//    init(viewModel: ContentViewModelProtocol) {
//        self.viewModel = viewModel
//        super.init()
//    }
    
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
//        setupSpinner()
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
    }
    
    func setupSpinner() {
        spinner = UIActivityIndicatorView(style: .medium)
        view.addToCenterSubview(spinner)
    }
}

// MARK: Binding
private extension ContentViewController {
    func bind() {
        // MARK: In
//        spinner.reactive.isAnimating <~ viewModel.loading
        actionExecution <~ viewModel.errorDispatcher.action
        tableView.reactive.reloadData <~ viewModel.reloadTable
        
        // MARK: Out
        viewModel.searchAction <~ searchPressed
        viewModel.searchStringChanged <~ searchBar.reactive.continuousTextValues
    }
}
