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
  let loading: MutableProperty<Bool?> = MutableProperty(nil)
  
  // Out
  let reloadTable: Signal<(), NoError>
  private let reloadTableObserver: Signal<(), NoError>.Observer
  
  let serverResponse: Signal<ITunesResponseModel, NoError>
  private let serverResponseObserver: Signal<ITunesResponseModel, NoError>.Observer
  
  // In
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
  
  var error: BindingTarget<Error> {
    BindingTarget(lifetime: lifetime, action: { [weak self] value in
      self?.errorDispatcher.handle(error: value)
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
  private let ageService: AgeServiceProtocol
  private let itunesService: ITunesServiceProtocol
  
  // MARK: - Lifecycle
  init(itunesService: ITunesServiceProtocol = ITunesService(),
       ageService: AgeServiceProtocol = AgeService()) {
    self.itunesService = itunesService
    self.ageService = ageService
    
    (reloadTable, reloadTableObserver) = Signal.pipe()
    (serverResponse, serverResponseObserver) = Signal.pipe()
    
    super.init()
    
    setup()
  }
}

// MARK: - Functions
private extension ContentViewModel {
  func search() {
    guard !(loading.value ?? false) else {
      return errorDispatcher.handle(error: LoadingError())
    }
    guard let searchString = self.searchString else {
      return errorDispatcher.handle(error: SearchStringError())
    }
    itunesService.searchStringObserver.send(value: searchString)
  }
  
  func clearResults() {
    searchString = nil
    reloadTableObserver.send(value: ())
  }
}

// MARK: - Setup
private extension ContentViewModel {
  func setup() {
    bind()
  }
  
  func bind() {
    loading <~ itunesService.loading
    
    itunesService.response.producer.start { [weak self] signal in
      self?.serverResponseObserver.send(value: signal.value!)
    }
  }
}

// MARK: - Supporting
private extension ContentViewModel {
  func alertConfigForAgeService() -> AlertConfigProtocol {
    AlertConfig(title: nil, message: R.string.localization.alertAreYouAdult(), actions: [
      (title: R.string.localization.alertYes(), style: .default, handler: ageService.setIsAdult(true)),
      (title: R.string.localization.alertNo(), style: .default, handler: ageService.setIsAdult(false))
    ])
  }
}
