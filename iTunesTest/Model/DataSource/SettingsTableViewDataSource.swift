//
//  ContentView+TableViewSupporting.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 23.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import UIKit

private let songCellIdentifier = "SongCell"

enum SettingType {
    
    case song(model: ArtistModelProtocol)
// TODO: case skeleton
    
    var identifier: String {
        switch self {
        case .song: return songCellIdentifier
        }
    }
}

struct SettingsSection {
  var title: String?
  var cellData: [SettingType]
 
  init(title: String?, cellData: [SettingType]) {
    self.title = title
    self.cellData = cellData
  }
}

class SettingsTableViewDataSource: NSObject, SettingsTableViewDataSourceProtocol {
    
    private(set) var sections: [SettingsSection]
    
    init(sections: [SettingsSection] = []) {
        self.sections = sections
    }
    
    func setup(model: Any) {
        guard let model = model as? [SettingsSection] else {
            sections = []
            return
        }
        self.sections = model
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < sections.count else {return 0}
        return sections[section].cellData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section < sections.count else {return ""}
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let setting: SettingType = sections[indexPath.section].cellData[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: setting.identifier) else { fatalError("Unknown identifier") }
        
        switch setting {
        case .song(let model):
            let cell = (cell as! Setupable)
            cell.setup(model: model)
        }
        return cell
    }
}
