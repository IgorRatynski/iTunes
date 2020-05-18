//
//  ContentViewModelProtocol.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 24.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Result
import ReactiveSwift

protocol ReactiveErrorDispatcherProtocol {
    var errorDispatcher: ReactiveErrorDispatcher {get}
}

protocol ReactiveTableReloadable {
    var reloadTable: Signal<(), NoError> {get}
}

protocol ReactiveSearchDelegateProtocol {
    var searchAction: BindingTarget<()> {get}
    var searchStringChanged: BindingTarget<String?> {get}
}

/// Interface segregation principle
protocol ContentViewModelProtocol: ReactiveTableReloadable, ReactiveSearchDelegateProtocol, ReactiveLoadable, ReactiveErrorDispatcherProtocol {
    var tableViewDataSource: SettingsTableViewDataSourceProtocol {get}
}
