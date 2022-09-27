//
//  NoSearchResultsCell.swift
//  iTunes
//
//  Created by Igor Ratynski on 05.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import UIKit
import Result
import ReactiveSwift
import ReactiveCocoa

class NoSearchResultsCell: UITableViewCell, Setupable {
  
  // MARK: Outlets
  private let titleLabel = UILabel()
  private let noSearchResultsImageView = UIImageView()
  
  // MARK: Properties
  private let viewModel: NoSearchResultsCellModelProtocol = NoSearchResultsCellModel()
  
  // MARK: Lifecycle
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  func setup(model: Any) {
    viewModel.setup(model: model)
  }
}

// MARK: - Setup
private extension NoSearchResultsCell {
  func setup() {
    setupSettings()
    setupLayout()
    bind()
  }
  
  func setupSettings() {
    titleLabel.textAlignment = .center
  }
  
  func setupLayout() {
    [noSearchResultsImageView, titleLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      noSearchResultsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
      noSearchResultsImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      noSearchResultsImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
      
      titleLabel.topAnchor.constraint(equalTo: noSearchResultsImageView.bottomAnchor, constant: 0),
      titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
      titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
    ])
  }
  
  // MARK: Reactive
  func bind() {
    titleLabel.reactive.text <~ viewModel.title
    
    noSearchResultsImageView.reactive.image <~ viewModel.image.map { [unowned self] in
      $0.resizeImage(to: .init(width: contentView.frame.width, height: contentView.frame.width))
    }
  }
}
