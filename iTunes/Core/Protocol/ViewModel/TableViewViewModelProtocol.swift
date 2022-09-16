//
//  TableViewViewModelProtocol.swift
//  
//
//  Created by Igor Ratynski on 14.09.2022.
//

import Foundation
import ReactiveSwift

protocol TableViewViewModelProtocol: AnyObject, ReactiveTableReloadable, ReactiveLoadable {
  var serverResponse: BindingTarget<ITunesResponseModel> { get }
  var tableViewDataSource: TableViewDataSourceProtocol { get }
}
