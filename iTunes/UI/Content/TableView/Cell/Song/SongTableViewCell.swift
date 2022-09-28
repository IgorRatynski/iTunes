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
  
  // MARK: Typealias
  private typealias Sizes = Size.TableView.Cell
  
  // MARK: Outlets
  let artistLabel = UILabel()
  let albumLabel = UILabel()
  let trackLabel = UILabel()
  let albumImageView = UIImageView()

  // MARK: Reactive
  private var prepareForReuseInvolved: Signal<(), NoError>!
  private var prepareForReuseObserver: Signal<(), NoError>.Observer!

  // MARK: Properties
  private let viewModel: SongTableViewCellModelProtocol = SongTableViewCellModel()

  // MARK: Lifecycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    (prepareForReuseInvolved, prepareForReuseObserver) = Signal.pipe()
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
  func setup() {
    setupLayout()
    setupViews()
    bind()
  }
  
  func setupLayout() {
    [artistLabel, albumLabel, trackLabel, albumImageView].forEach {
      contentView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      albumImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Sizes.Offset.halfDefault),
      albumImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Sizes.Offset.default),
      albumImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Sizes.Offset.halfDefault),
      albumImageView.heightAnchor.constraint(equalToConstant: Sizes.Size.image),
      albumImageView.widthAnchor.constraint(equalTo: albumImageView.heightAnchor)
      ])
    
    [artistLabel, albumLabel, trackLabel].forEach {
      NSLayoutConstraint.activate([
        $0!.leftAnchor.constraint(equalTo: albumImageView.rightAnchor, constant: Sizes.Offset.halfDefault),
        $0!.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Sizes.Offset.default)
      ])
    }
    
    NSLayoutConstraint.activate([
      artistLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Sizes.Offset.halfDefault),
      albumLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: Sizes.Offset.halfDefault),
      trackLabel.topAnchor.constraint(equalTo: albumLabel.bottomAnchor, constant: Sizes.Offset.halfDefault)
    ])
  }

  func setupViews() {
    albumImageView.layer.cornerRadius = Sizes.CornerRadius.image
    [artistLabel, albumLabel, trackLabel].forEach { $0?.layer.cornerRadius = Sizes.CornerRadius.text }
  }
}

// MARK: - Reactive
private extension SongTableViewCell {
  func bind() {
    artistLabel.reactive.text <~ viewModel.artistName
    albumLabel.reactive.text <~ viewModel.albumName
    trackLabel.reactive.text <~ viewModel.trackName
    albumImageView.reactive.image <~ viewModel.albumImage

    viewModel.prepareForReuse <~ prepareForReuseInvolved
  }
}
