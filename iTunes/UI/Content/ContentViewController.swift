//
//  ContentViewController.swift
//  iTunes
//
//  Created by Igor Ratynski on 22.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Result
import ReactiveSwift

class ContentViewController: BaseViewController, ErrorActionController {
  
  // MARK: UI
  @IBOutlet private var searchBarContainerView: UIView!
  @IBOutlet private var tableViewContainerView: UIView!
  
  // MARK: Private properties
  private let viewModel: ContentViewModelProtocol = ContentViewModel()
  private var searchBarViewModel: SearchBarViewModelProtocol!
  private var tableViewViewModel: TableViewViewModelProtocol!
  
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
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    // TODO: Refactoring: move 2 vm
    if viewModel.showIsAdultAlert {
      showSystemAlert(with: viewModel.adultAlertConfig)
    }
  }
}

// MARK: Setup
private extension ContentViewController {
  func setup() {
    bind()
  }
  
  func bind() {
    // MARK: In
    actionExecution <~ viewModel.errorDispatcher.action
    
    // MARK: Out
    viewModel.searchStringChanged <~ searchBarViewModel.searchString
    viewModel.searchAction <~ searchBarViewModel.searchAction
    
    // MARK: Mediator
    tableViewViewModel.serverResponse <~ viewModel.serverResponse
    tableViewViewModel.loading <~ viewModel.loading
  }
}

// MARK: Container supporting
extension ContentViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
      case "SearchBarSegue":
        let vc = segue.destination as! SearchBarViewControllerProtocol
        searchBarViewModel = vc.viewModel
      case "TableViewSegue":
        let vc = segue.destination as! TableViewViewControllerProtocol
        tableViewViewModel = vc.viewModel
      default:
        assertionFailure("ContentViewController no case")
    }
  }
}
