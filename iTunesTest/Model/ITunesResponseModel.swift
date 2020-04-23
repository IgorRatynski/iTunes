//
//  ITunesResponseModel.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 23.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Foundation

struct ITunesResponseModel: Decodable {
    let resultCount: Int
    let results: [ITunesArtistModel]
}
