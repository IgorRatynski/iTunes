//
//  SearchBarViewControllerProtocol.swift
//  iTunes
//
//  Created by Igor Ratynski on 14.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import UIKit

protocol SearchBarViewControllerProtocol: UISearchBarDelegate {
  var viewModel: SearchBarViewModelProtocol { get }
}
