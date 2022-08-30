//
//  ArtistModel.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 23.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Foundation

struct ArtistModel: ArtistModelProtocol {
  
  // MARK: Public
  let artistName: String
  var album: String? { AgeService.isAdult ? collectionCensoredName : collectionName }
  var track: String? { AgeService.isAdult ? trackCensoredName : trackName }
  let albumImageURL: URL
  
  // MARK: Private
  private let collectionName: String?
  private let collectionCensoredName: String?
  private let trackName: String?
  private let trackCensoredName: String?
}

// MARK: - CodingKeys
private extension ArtistModel {
  enum CodingKeys : String, CodingKey {
    case artistName, albumImageURL = "artworkUrl100", collectionName, collectionCensoredName, trackName, trackCensoredName
  }
}

//{"wrapperType":"audiobook", "artistId":273701554, "collectionId":281099279, "amgArtistId":647963, "artistName":"Ricky Gervais, Stephen Merchant & Karl Pilkington", "collectionName":"The Podfather Trilogy - Season Four of The Ricky Gervais Show (Unabridged)", "collectionCensoredName":"The Podfather Trilogy - Season Four of The Ricky Gervais Show (Unabridged)", "artistViewUrl":"https://itunes.apple.com/us/artist/ricky-gervais/273701554?uo=4", "collectionViewUrl":"https://books.apple.com/us/audiobook/podfather-trilogy-season-four-ricky-gervais-show-unabridged/id281099279?uo=4", "artworkUrl60":"https://is1-ssl.mzstatic.com/image/thumb/Music/0a/4d/60/mzi.ofwguzqk.jpg/60x60bb.jpg", "artworkUrl100":"https://is1-ssl.mzstatic.com/image/thumb/Music/0a/4d/60/mzi.ofwguzqk.jpg/100x100bb.jpg", "collectionPrice":2.99, "collectionExplicitness":"notExplicit", "trackCount":1, "copyright":"© 2008 Glyn Hughes", "country":"USA", "currency":"USD", "releaseDate":"2008-05-19T07:00:00Z", "primaryGenreName":"Comedy",
//"previewUrl":"https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview113/v4/1f/04/0d/1f040da3-7df5-6554-cd5f-5490d58cf423/mzaf_5735159293967295301.std.aac.p.m4a",
//"description":"Here are three special episodes of \n<i>The Ricky Gervais Show<\/i>, featuring those doyens of the medium, the eponymous multi-award winning Ricky Gervais; Steve Merchant ( \n<i>The Office<\/i>, \n<i>Extras<\/i>); and the round-headed idiot savant, Karl Pilkington. \n<br /><b>Part I: Halloween<\/b><br />Ghostly drivel abounds as Steve consults an SMS-based oracle, Karl experiences a kidney probing, Steve visits Bristol, Karl becomes a Godfather, and Ricky tells of some lighter moments at the morgue. (Includes a CD-giveaway contest that has already expired - sorry!)<br /><br /><b>Part II: Thanksgiving<\/b><br />Karl is unfamiliar with the American public holiday mentioned in the show's title and launches a campaign for a calendar-free society. Ricky explains the origins of Thanksgiving, prompting him to ask Karl who might be a good choice for a present-day pilgrim father. Steve brings up the sterling work mice are carrying out in the name of medicine. Karl's hypochondria comes to the fore as he describes a recent visit to a leg-rubber who prescribes a toe-based soporific. More readings from Karl's diary; UFOs; the will to live; Madeira cake; Relative merits of gay and heterosexual men's pornographic magazines; Oxfam's extended product lines; and Karl is concerned about the shortage of new sounds. Plus there's a (now defunct, obviously) competition to win copies of Karl's book and the new CD box set.<br /><br /><b>Part III - Christmas<\/b><br />Karl reflects on the year past and singles out an unlikely highlight; Steve stocks up on yuletide essentials; Karl advocates an anarchic Christmas and complains about his domestic chores; Karl's diary draws to a close with revelations of bothersome footwear, cravat-luggage, not-so-current affairs, bees, beds, and worry-holes; and Ricky provides an emotional exit en route to the orphanage."},
