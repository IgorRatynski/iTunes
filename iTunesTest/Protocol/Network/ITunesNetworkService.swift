//
//  ITunesNetworkService.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 23.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Moya

protocol ITunesNetworkService: TargetType {
    func search(_: ITunesParams)
}
