//
//  TableViewViewModelProtocol.swift
//  
//
//  Created by Igor Ratynski on 14.09.2022.
//

import Foundation
import ReactiveSwift

protocol TableViewViewModelProtocol: ReactiveTableReloadable, ReactiveLoadable {
  var serverResponse: BindingTarget<ITunesResponseModel> { get }
  var error: BindingTarget<Error> { get }
  var tableViewDataSource: TableViewDataSourceProtocol { get }
}
