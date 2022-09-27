//
//  TableViewViewModel.swift
//  iTunes
//
//  Created by Igor Ratynski on 14.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

class TableViewViewModel: BaseViewModel, TableViewViewModelProtocol {
  
  // MARK: - Public properties
  let tableViewDataSource: TableViewDataSourceProtocol
  let loading: MutableProperty<Bool?> = MutableProperty(nil)
  
  let reloadTable: Signal<(), NoError>
  private let reloadTableObserver: Signal<(), NoError>.Observer
  
  // MARK: - Private properties
  private let screenHeight: Int
  private let skeletonCellHeight: Int
  
  var serverResponse: BindingTarget<ITunesResponseModel> {
    BindingTarget(lifetime: lifetime, action: { [weak self] value in
      self?.handle(response: value)
    })
  }
  
  // MARK: - Lifecycle
  init(tableViewDataSource: TableViewDataSourceProtocol = UsersTableViewDataSource(),
       screenHeight: CGFloat, skeletonCellHeight: CGFloat) {
    self.tableViewDataSource = tableViewDataSource
    self.screenHeight = Int(screenHeight)
    self.skeletonCellHeight = Int(skeletonCellHeight)
    
    (reloadTable, reloadTableObserver) = Signal.pipe()
    
    super.init()
    setup()
  }
}

// MARK: - Setup
private extension TableViewViewModel {
  func setup() {
    set(sections: loadingCells())
    subscribe()
  }
  
  func subscribe() {
    loading.producer
      .filter { $0 == true }
      .start { [unowned self] next in
        set(sections: loadingCells())
      }
  }
}

// MARK: - Supporting
private extension TableViewViewModel {
  func set(sections: [SectionProtocol]) {
    tableViewDataSource.setup(model: sections)
    reloadTableObserver.send(value: ())
  }
  
  func clearResults() {
    set(sections: [])
  }
  
  func loadingCells() -> [SectionProtocol] {
    let count = screenHeight / skeletonCellHeight + 1
    let cellData = Array(repeating: CellType.song(model: nil), count: count)
    return [Section(cellData:  cellData)]
  }
  
  func handle(response: ITunesResponseModel) {
    if response.resultCount == 0 {
      set(sections: noSearchResults())
    } else {
      set(sections: content(from: response))
    }
  }
  
  func noSearchResults() -> [SectionProtocol] {
    let noSearchResultModel = NoSearchResultsModel(title: Text.noSearchResult, image: Image.noSearchResult)
    let models = Section(cellData: [CellType.noSearchResults(model: noSearchResultModel)])
    return [models]
  }
  
  func content(from response: ITunesResponseModel) -> [Section] {
    [Section(cellData: response.results!.compactMap { CellType.song(model: $0) })]
  }
}
