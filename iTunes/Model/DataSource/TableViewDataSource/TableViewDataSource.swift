//
//  ContentView+TableViewSupporting.swift
//  iTunes
//
//  Created by Igor Ratynski on 23.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import UIKit

class TableViewDataSource: NSObject, TableViewDataSourceProtocol {

  // MARK: Properties
  private(set) var sections: [SectionProtocol]

  // MARK: Lifecycle
  init(sections: [SectionProtocol] = []) {
    self.sections = sections
  }

  func setup(model: Any) {
    guard let model = model as? [SectionProtocol] else {
      sections = []
      return
    }
    self.sections = model
  }
}

// MARK: UITableViewDataSource
extension TableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    sections.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard section < sections.count else { return 0 }
    return sections[section].cellData.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    guard section < sections.count else { return "" }
    return sections[section].title
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    assertionFailure("Not implemented cellForRowAt in TableViewDataSource: \(self)")
    return UITableViewCell()
  }
}
