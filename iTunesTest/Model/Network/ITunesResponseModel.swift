//
//  ITunesResponseModel.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 23.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Foundation

struct ITunesResponseModel: Decodable {
    private let resultCount: Int?
    private let results: [ITunesArtistModel]?
    
    var tableModels: [SettingsSection] {
        results?.models ?? []
    }
}

// MARK: UITableViewDataSource Adapter
extension Array where Element == ITunesArtistModel {
    var models: [SettingsSection] {
        return [SettingsSection(title: nil, cellData: self.map { SettingType.song(model: $0) })]
    }
}
