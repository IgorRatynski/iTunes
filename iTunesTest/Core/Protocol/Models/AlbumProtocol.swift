//
//  AlbumProtocol.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 31.08.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import Foundation

protocol AlbumProtocol {
  var name: String { get }
  var tracks: [ArtistModel] { get }
  var image: URL? { get }
}
