//
//  ITunesServiceProtocol.swift
//  iTunes
//
//  Created by Igor Ratynski on 14.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

protocol ITunesServiceProtocol {
  var response: Signal<ITunesResponseModel, NoError> { get }
  var error: Signal<NoError, Error> { get }
  var loading: Signal<Bool, NoError> { get }
  var searchStringObserver: Signal<String, NoError>.Observer { get }
}
