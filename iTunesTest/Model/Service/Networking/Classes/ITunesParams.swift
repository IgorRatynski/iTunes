//
//  ITunesParams.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 28.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Foundation

struct ITunesParams: Encodable {
  /// Filter
  static private let filteringCharacters = NSCharacterSet(charactersIn: "!@#$%&*")
  
  let term: String
  let explicit: String
  let limit: Int
  
  var asString: String {
    term
      .components(separatedBy: " ")
      .map { $0.components(separatedBy: Self.filteringCharacters as CharacterSet).joined() } // "exa$mple" -> "example"
      .flatMap { $0.components(separatedBy: " ") }
      .filter { !$0.isEmpty }
      .joined(separator: "+")
  }
}

//        let example = ["", "", " exam№ple ", "22 ex", "", " $", " # ", "   ", "$", " example", "", "example example"]
        
//            print("### 0: \(example)")
//            let iteration1 = example.map { $0.components(separatedBy: filter as CharacterSet).joined() }
//            print("### 1: \(iteration1)") // ["", "", "sdfasfas", "", " ", "  ", "   ", "", " asdfsad", "", "sdfa asdf"]
//            var iteration2 = iteration1.flatMap { $0.components(separatedBy: " ") }
//            print("### 2: \(iteration2)") // ["", "", "sdfasfas", "", "", "", "", "", "", "", "", "", "", "", "", "asdfsad", "", "sdfa", "asdf"]
//            let iteration3 = iteration2.filter { !$0.isEmpty }
//            iteration2.removeAll { $0.isEmpty }
//            print("### 3: \(iteration3)") // ["sdfasfas", "asdfsad", "sdfa", "asdf"]
