//
//  ITunesService.swift
//  iTunes
//
//  Created by Igor Ratynski on 14.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import Foundation
import Moya
import Result
import ReactiveSwift

class ITunesService: ReactiveBase, ITunesServiceProtocol {
  
  // MARK: - Public properties
  let loading: Signal<Bool, NoError>
  private let loadingObserver: Signal<Bool, NoError>.Observer
  
  // In
  private let searchString: Signal<String, NoError>
  let searchStringObserver: Signal<String, NoError>.Observer
  
  private var searchAction: BindingTarget<String> {
    BindingTarget(lifetime: lifetime) { [weak self] in
      self?.search($0)
    }
  }
  
  // Out
  let response: Signal<ITunesResponseModel, NoError>
  private let responseObserver: Signal<ITunesResponseModel, NoError>.Observer
  
  let error: Signal<NoError, Error>
  private let errorObserver: Signal<NoError, Error>.Observer
  
  // MARK: - Private properties
  private let networkProvider: MoyaProvider<ITunesRequest>
  private let ageService: AgeServiceProtocol
  
  // MARK: - Lifecycle
  init(networkProvider: MoyaProvider<ITunesRequest> = MoyaProvider<ITunesRequest>(plugins: [NetworkLoggerPlugin(verbose: true)]),
       tableViewDataSource: TableViewDataSourceProtocol = TableViewDataSource(),
       ageService: AgeServiceProtocol = AgeService()) {
    self.networkProvider = networkProvider
    self.ageService = ageService
    
    (response, responseObserver) = Signal.pipe()
    (error, errorObserver) = Signal.pipe()
    (searchString, searchStringObserver) = Signal.pipe()
    (loading, loadingObserver) = Signal.pipe()
    
    super.init()
    
    setup()
  }
}

// MARK: - Functions
private extension ITunesService {
  func search(_ string: String) {
    self.searchRequest(ITunesParams(term: string, explicit: (ageService.isAdult ?? false).string, limit: 50))
  }
}

// MARK: - Networking
private extension ITunesService {
  func searchRequest(_ params: ITunesParams) {
    networkProvider
      .request(.search(params))
      .map(ITunesResponseModel.self)
      .on(starting: { [weak self] in
        self?.loadingObserver.send(value: true)
      })
      .on(event: { [weak self] _ in
        self?.loadingObserver.send(value: false)
      })
      .on(value: { [weak self] response in
        self?.responseObserver.send(value: response)
      })
      .on(failed: { [weak self] error in
        self?.errorObserver.send(error: error)
      })
      .start()
  }
}

// MARK: - Setup
private extension ITunesService {
  func setup() {
    searchAction <~ searchString
  }
}

private extension Bool {
  var string: String {
    self ? R.string.localization.alertYes() : R.string.localization.alertNo()
  }
}
