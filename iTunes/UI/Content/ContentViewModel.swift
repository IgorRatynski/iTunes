//
//  ContentViewModel.swift
//  iTunes
//
//  Created by Igor Ratynski on 22.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import UIKit
import Moya
import Result
import ReactiveSwift

class ContentViewModel: BaseViewModel, ContentViewModelProtocol {
  
  // MARK: - Public properties
  let tableViewDataSource: TableViewDataSourceProtocol
  private(set) var loading: MutableProperty<Bool> = MutableProperty(false)
  
  let reloadTable: Signal<(), NoError>
  private let reloadTableObserver: Signal<(), NoError>.Observer
  
  var searchAction: BindingTarget<()> {
    BindingTarget(lifetime: lifetime) { [weak self] in
      self?.search()
    }
  }
  
  var searchStringChanged: BindingTarget<String?> {
    BindingTarget(lifetime: lifetime, action: { [weak self] value in
      self?.searchString = value
    })
  }
  
  var showIsAdultAlert: Bool {
    ageService.isNeedToAsk
  }
  
  var adultAlertConfig: AlertConfigProtocol {
    alertConfigForAgeService()
  }
  
  // MARK: - Private properties
  private var searchString: String?
  private let networkProvider: MoyaProvider<ITunesService>
  private let ageService: AgeServiceProtocol
  
  // MARK: - Lifecycle
  init(networkProvider: MoyaProvider<ITunesService> = MoyaProvider<ITunesService>(plugins: [NetworkLoggerPlugin(verbose: true)]),
       tableViewDataSource: TableViewDataSourceProtocol = TableViewDataSource(),
       ageService: AgeServiceProtocol = AgeService()) {
    self.networkProvider = networkProvider
    self.tableViewDataSource = tableViewDataSource
    self.ageService = ageService
    
    (reloadTable, reloadTableObserver) = Signal.pipe()
    
    super.init()
  }
}

// MARK: - Functions
private extension ContentViewModel {
  func search() {
    guard !loading.value,
          let searchString = self.searchString
    else {
      self.errorDispatcher.handle(error: LoadingError())
      return
    }
    
    self.searchRequest(ITunesParams(term: searchString, explicit: (ageService.isAdult ?? false).string, limit: 50))
  }
  
  func clearResults() {
    searchString = nil
    tableViewDataSource.setup(model: [])
    self.reloadTableObserver.send(value: ())
  }
}

// MARK: - Networking
private extension ContentViewModel {
  func searchRequest(_ params: ITunesParams) {
    networkProvider
      .request(.search(params))
      .map(ITunesResponseModel.self)
      .on(starting: { [weak self] in
        self?.loading.value = true
      })
      .on(event: { [weak self] _ in
        self?.loading.value = false
      })
      .on(value: { [weak self] response in
        guard let self = self else { return }
        let model = self.model(for: response)
        self.tableViewDataSource.setup(model: model)
        self.reloadTableObserver.send(value: ())
      })
      .on(failed: { [weak self] error in
        self?.errorDispatcher.handle(error: error)
      })
      .start()
  }
}

// MARK: - Supporting
private extension ContentViewModel {
  func alertConfigForAgeService() -> AlertConfigProtocol {
    AlertConfig(title: nil, message: AlertStrings.areYouAdult.localized, actions: [
      (title: AlertStrings.yes.localized, style: .default, handler: ageService.setIsAdult(true)),
      (title: AlertStrings.no.localized, style: .default, handler: ageService.setIsAdult(false))
    ])
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

private extension Bool {
  var string: String {
    self ? AlertStrings.yes.rawValue : AlertStrings.no.rawValue
  }
}
