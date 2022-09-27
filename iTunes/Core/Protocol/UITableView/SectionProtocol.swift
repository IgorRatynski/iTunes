//
//  SectionProtocol.swift
//  iTunes
//
//  Created by Igor Ratynski on 16.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import Foundation

protocol SectionProtocol {
  var title: String? { get }
  var cellData: [CellType] { get }
}
