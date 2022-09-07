//
//  NoSearchResultsCellModel.swift
//  iTunes
//
//  Created by Igor Ratynski on 05.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import Result
import Moya
import ReactiveSwift

class NoSearchResultsCellModel: BaseViewModel, NoSearchResultsCellModelProtocol {
  
  // MARK: properties
  let title: Signal<String, NoError>!
  private var titleObserver: Signal<String, NoError>.Observer!
  
  let image: Signal<UIImage, NoError>!
  private var imageObserver: Signal<UIImage, NoError>.Observer!
  
  // MARK: Private properties
  private var model: NoSearchResultsModelProtocol?
  private var isSetted: Bool = false
  
  // MARK: - Lifecycle
  init() {
    (title, titleObserver) = Signal.pipe()
    (image, imageObserver) = Signal.pipe()
  }
  
  func setup(model: Any) {
    guard !isSetted, let model = model as? NoSearchResultsModelProtocol else { return }
    self.model = model
    updateView()
  }
}

// MARK: - Setup
private extension NoSearchResultsCellModel {
  func updateView() {
    titleObserver.send(value: model!.title)
    imageObserver.send(value: model!.image)
  }
}
