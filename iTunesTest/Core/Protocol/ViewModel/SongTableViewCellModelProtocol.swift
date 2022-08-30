//
//  SongTableViewCellModelProtocol.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 29.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Moya
import Result
import ReactiveSwift

protocol SongTableViewCellModelProtocol: ReactiveLoadable, Setupable {
  var artistName: Signal<String?, NoError>! { get }
  var albumName: Signal<String?, NoError>! { get }
  var trackName: Signal<String?, NoError>! { get }
  var albumImage: Signal<Image?, NoError>! { get }
  
  var prepareForReuse: BindingTarget<()> { get }
}
