//
//  ContentViewModelProtocol.swift
//  iTunes
//
//  Created by Igor Ratynski on 24.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Result
import ReactiveSwift

protocol ReactiveErrorDispatcherOwnerProtocol {
  var errorDispatcher: ReactiveErrorDispatcherProtocol { get }
}

protocol ReactiveTableReloadable {
  var reloadTable: Signal<(), NoError> { get }
}

protocol ReactiveSearchDelegateProtocol {
  var searchAction: BindingTarget<()> { get }
  var searchStringChanged: BindingTarget<String?> { get }
}

protocol ContentViewModelProtocol: ReactiveTableReloadable, ReactiveSearchDelegateProtocol, ReactiveLoadable, ReactiveErrorDispatcherOwnerProtocol {
  var showIsAdultAlert: Bool { get }
  var adultAlertConfig: AlertConfigProtocol { get }
  var serverResponse: Signal<ITunesResponseModel, NoError> { get }
}
