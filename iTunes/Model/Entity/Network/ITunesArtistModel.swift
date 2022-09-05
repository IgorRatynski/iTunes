//
//  ArtistModel.swift
//  iTunes
//
//  Created by Igor Ratynski on 23.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Foundation

struct ArtistModel: ArtistModelProtocol {
  
  // MARK: Public
  let artistName: String
  var album: String { (ArtistModel.ageService.isAdult ?? false ? collectionCensoredName : collectionName) ?? ArtistModel.noAlbumName }
  var track: String { (ArtistModel.ageService.isAdult ?? false ? trackCensoredName : trackName) ?? ArtistModel.noTrackName }
  let albumImageURL: URL
  
  // MARK: Private
  private let collectionName: String?
  private let collectionCensoredName: String?
  private let trackName: String?
  private let trackCensoredName: String?
// private let previewUrl: URL - sound
  
  // better todo it via DI
  private static let ageService: AgeService = AgeService()
  private static let noAlbumName: String = "Unknown album"
  private static let noTrackName: String = "Unknown track"
}

// MARK: - CodingKeys
private extension ArtistModel {
  enum CodingKeys : String, CodingKey {
    case artistName, albumImageURL = "artworkUrl100", collectionName, collectionCensoredName, trackName, trackCensoredName
  }
}
