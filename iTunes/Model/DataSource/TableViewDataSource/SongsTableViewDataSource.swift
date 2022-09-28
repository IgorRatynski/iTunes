//
//  SongsTableViewDataSource.swift
//  iTunes
//
//  Created by Igor Ratynski on 27.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import UIKit

class SongsTableViewDataSource: TableViewDataSource {
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let setting: CellType = sections[indexPath.section].cellData[indexPath.row] as! CellType
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: setting.identifier) else {
      // TODO: Mock analytics logger
      assertionFailure("Unknown identifier")
      return UITableViewCell()
    }
    
    switch setting {
      case .song(let model):
        let cell = (cell as! Setupable)
        cell.setup(model: model as Any)
      case .noSearchResults(model: let model):
        let cell = (cell as! Setupable)
        cell.setup(model: model)
    }
    return cell
  }
}
