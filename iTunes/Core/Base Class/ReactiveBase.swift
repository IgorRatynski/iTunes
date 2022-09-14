//
//  ReactiveBase.swift
//  iTunes
//
//  Created by Igor Ratynski on 14.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import ReactiveSwift

open class ReactiveBase {
  var (lifetime, token) = Lifetime.make()
}
