//
//  SongTableViewCell.swift
//  iTunes
//
//  Created by Igor Ratynski on 28.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import UIKit
import Result
import ReactiveSwift
import ReactiveCocoa

class SongTableViewCell: UITableViewCell, Setupable {
  
  // MARK: Outlets
  @IBOutlet private var artistLabel: UILabel!
  @IBOutlet private var albumLabel: UILabel!
  @IBOutlet private var trackLabel: UILabel!
  @IBOutlet private var albumImageView: UIImageView!
  
  // MARK: Reactive
  private var prepareForReuseInvolved: Signal<(), NoError>!
  private var prepareForReuseObserver: Signal<(), NoError>.Observer!
  
  // MARK: Properties
  private let viewModel: SongTableViewCellModelProtocol = SongTableViewCellModel()
  
  // MARK: Lifecycle
  override func awakeFromNib() {
    (prepareForReuseInvolved, prepareForReuseObserver) = Signal.pipe()
    super.awakeFromNib()
    bind()
  }
  
  override func prepareForReuse() {
    prepareForReuseObserver.send(value: ())
  }
  
  func setup(model: Any) {
    viewModel.setup(model: model)
  }
}

// MARK: - Setup
private extension SongTableViewCell {
  func bind() {
    artistLabel.reactive.text <~ viewModel.artistName
    albumLabel.reactive.text <~ viewModel.albumName
    trackLabel.reactive.text <~ viewModel.trackName
    albumImageView.reactive.image <~ viewModel.albumImage
    
    viewModel.prepareForReuse <~ prepareForReuseInvolved
  }
}
