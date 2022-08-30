//
//  ContentViewModel.swift
//  iTunesTest
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
  let tableViewDataSource: SettingsTableViewDataSourceProtocol
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
       tableViewDataSource: SettingsTableViewDataSourceProtocol = SettingsTableViewDataSource(),
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
    
    self.searchRequest(ITunesParams(term: searchString))
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
        guard let self = self else {return}
        self.tableViewDataSource.setup(model: response.tableModels)
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
}
