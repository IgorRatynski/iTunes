//
//  ITunesArtistModelProtocol.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 28.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Foundation

protocol ITunesArtistModelProtocol: Decodable {
    var artistName: String {get}
    var album: String? {get}
    var track: String? {get}
    var albumImageURL: URL {get}
}
