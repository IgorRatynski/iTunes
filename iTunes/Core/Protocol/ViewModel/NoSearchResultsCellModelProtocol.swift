//
//  NoSearchResultsCellModelProtocol.swift
//  iTunes
//
//  Created by Igor Ratynski on 05.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import Moya
import Result
import ReactiveSwift

protocol NoSearchResultsCellModelProtocol: Setupable {
  var title: Signal<String, NoError>! { get }
  var image: Signal<UIImage, NoError>! { get }
}
