//
//  CellProtocol.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 23.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Foundation

protocol AlbumCellProtocol {
    var albumCover: URL {get}
    var artist: String {get}
    var album: String {get}
    var track: String {get}
}
