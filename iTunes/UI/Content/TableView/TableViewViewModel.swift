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
  private(set) var loading: MutableProperty<Bool> = MutableProperty(false)
  
  let reloadTable: Signal<(), NoError>
  private let reloadTableObserver: Signal<(), NoError>.Observer
  
  // MARK: - Private properties
  var serverResponse: BindingTarget<ITunesResponseModel> {
    BindingTarget(lifetime: lifetime, action: { [weak self] value in
      self?.handle(response: value)
    })
  }
  
  var error: BindingTarget<Error> {
    BindingTarget(lifetime: lifetime, action: { [weak self] value in
      self?.errorDispatcher.handle(error: value)
    })
  }
  
  // MARK: - Lifecycle
  init(tableViewDataSource: TableViewDataSourceProtocol = TableViewDataSource()) {
    self.tableViewDataSource = tableViewDataSource
    
    (reloadTable, reloadTableObserver) = Signal.pipe()
    
    super.init()
  }
}

// MARK: - Supporting
private extension TableViewViewModel {
  func clearResults() {
    tableViewDataSource.setup(model: [])
    self.reloadTableObserver.send(value: ())
  }
  
  func handle(response: ITunesResponseModel) {
    let model = self.model(for: response)
    self.tableViewDataSource.setup(model: model)
    self.reloadTableObserver.send(value: ())
  }
  
  func noSearchResults() -> [Section] {
    let noSearchResultModel = NoSearchResultsModel(title: Text.noSearchResult, image: Image.noSearchResult)
    let models = Section(title: nil, cellData: [.noSearchResults(model: noSearchResultModel)])
    return [models]
  }
  
  func content(from response: ITunesResponseModel) -> [Section] {
    [Section(title: nil, cellData: response.results!.compactMap { SettingType.song(model: $0) })]
  }
  
  func model(for response: ITunesResponseModel?) -> [Section] {
    if response?.resultCount ?? 0 == 0 {
      return noSearchResults()
    } else {
      return content(from: response!)
    }
  }
}
