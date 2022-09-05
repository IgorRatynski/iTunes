//
//  ITunesResponseModel.swift
//  iTunes
//
//  Created by Igor Ratynski on 23.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Foundation

struct ITunesResponseModel: Decodable {
  let resultCount: Int?
  let results: [ArtistModel]?
  
  var albums: [Album] {
    guard let results = results else { return [] }
    var albums: [String : [ArtistModel]] = [:], tempArtists: [ArtistModel]

    for artist in results {
      tempArtists = albums[artist.album] ?? []
      tempArtists.append(artist)
      albums[artist.album] = tempArtists
    }

    return albums.compactMap { Album(name: $0.key, tracks: $0.value, image: $0.value.first?.albumImageURL) }
  }
  
  var tableModels: [SettingsSection] {
    results?.models ?? []
  }
}

// MARK: UITableViewDataSource Adapter
extension Array where Element == ArtistModel {
  var models: [SettingsSection] {
    return [SettingsSection(title: nil, cellData: self.map { SettingType.song(model: $0) })]
  }
}
