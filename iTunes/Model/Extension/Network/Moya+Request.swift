//
//  Moya+Request.swift
//  iTunes
//
//  Created by Igor Ratynski on 23.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Moya
import ReactiveSwift

extension MoyaProvider {
  func request(_ targetType: Target) -> SignalProducer<Response, MoyaError> {
    reactive.request(targetType).observe(on: UIScheduler())
  }
}
