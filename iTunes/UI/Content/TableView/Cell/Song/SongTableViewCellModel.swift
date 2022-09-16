//
//  SongTableViewCellModel.swift
//  iTunes
//
//  Created by Igor Ratynski on 28.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import Result
import Moya
import ReactiveSwift

class SongTableViewCellModel: BaseViewModel, SongTableViewCellModelProtocol {
  
  // MARK: properties
  private(set) var loading: MutableProperty<Bool> = MutableProperty(false)
  
  let artistName: Signal<String?, NoError>!
  private var artistNameObserver: Signal<String?, NoError>.Observer!
  
  let albumName: Signal<String?, NoError>!
  private var albumNameObserver: Signal<String?, NoError>.Observer!
  
  let trackName: Signal<String?, NoError>!
  private var trackNameObserver: Signal<String?, NoError>.Observer!
  
  let albumImage: Signal<Image?, NoError>!
  private var albumImageObserver: Signal<Image?, NoError>.Observer!
  
  var prepareForReuse: BindingTarget<()> {
    BindingTarget(lifetime: lifetime) { [weak self] in
      self?.clear()
    }
  }
  
  // MARK: Private properties
  private var model: ArtistModelProtocol?
  private var networkProvider: MoyaProvider<ImageRequest>
  
  // MARK: - Lifecycle
  init(networkProvider: MoyaProvider<ImageRequest> = MoyaProvider<ImageRequest>()) {
    (artistName, artistNameObserver) = Signal.pipe()
    (albumName, albumNameObserver) = Signal.pipe()
    (trackName, trackNameObserver) = Signal.pipe()
    (albumImage, albumImageObserver) = Signal.pipe()
    
    self.networkProvider = networkProvider
  }
  
  func setup(model: Any) {
    guard let model = model as? ArtistModelProtocol else { return clear() }
    self.model = model
    updateView()
  }
}

// MARK: Setup
private extension SongTableViewCellModel {
  func clear() {
    model = nil
    albumImageObserver.send(value: nil)
    artistNameObserver.send(value: " ")
    albumNameObserver.send(value: " ")
    trackNameObserver.send(value: " ")
    loading = MutableProperty(false)
  }
  
  func updateView() {
    artistNameObserver.send(value: model!.artistName)
    albumNameObserver.send(value: model!.album)
    trackNameObserver.send(value: model!.track)
    getImage(url: model!.albumImageURL)
  }
}

// MARK: Networking
private extension SongTableViewCellModel {
  func getImage(url: URL) {
    networkProvider
      .request(.getImage(url: url))
      .mapImage()
      .on(starting: { [weak self] in
        self?.loading.value = true
      })
      .on(event: { [weak self] _ in
        self?.loading.value = false
      })
      .on(value: { [weak self] response in
        guard let self = self else { return }
        self.albumImageObserver.send(value: response)
      })
      .on(failed: { [weak self] error in
        self?.errorDispatcher.handle(error: error)
      })
      .start()
  }
}
