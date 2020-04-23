//
//  ITunesArtistModel.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 23.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Foundation

//struct ITunesArtistModel {
//    let wrapperType: String
//    let kind: String
//    let artistType: String
//    let artistName: String
//    var artistUrl: URL { URL(string: artistLinkUrl)! }
//    let artistId: UInt
//    let amgArtistId: UInt
//    let primaryGenreName: String
//    let primaryGenreId: UInt
//
//    private let artistLinkUrl: String
//}

struct ITunesArtistModel {
    let wrapperType: String
    let kind: String
    let artistId: UInt
    let collectionId: UInt
    let trackId: UInt
    let artistName: String
    let collectionName: String
    let trackName: String
    let collectionCensoredName: String
    let trackCensoredName: String
    
    let artistViewUrl: String // URL
    let collectionViewUrl: String
    let trackViewUrl: String
    let previewUrl: String
    let artworkUrl100: String
}
