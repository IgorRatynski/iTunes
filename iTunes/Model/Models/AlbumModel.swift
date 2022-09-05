//
//  AlbumModel.swift
//  iTunes
//
//  Created by Igor Ratynski on 31.08.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import Foundation

struct Album: AlbumProtocol {

  // MARK: Public
  let name: String
  let tracks: [ArtistModel]
  let image: URL?

  // Better via DI
  static private let ageService: AgeServiceProtocol = AgeService()
}
