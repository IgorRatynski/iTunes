//
//  ContentViewModel.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 22.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

//import Foundation
import Moya
import ReactiveSwift

class ContentViewModel {
    
    // MARK: Reactive
//    var pushController: Signal<UIViewController, NoError>
//    fileprivate var pushControllerObserver: Signal<UIViewController, NoError>.Observer
    
    fileprivate(set) var sending: MutableProperty<Bool> = MutableProperty(false)
    
    
    // MARK: Private properties
    fileprivate var networkProvider: MoyaProvider<ITunesService>
    

        
        init(networkProvider: MoyaProvider<ITunesService> = MoyaProvider<ITunesService>()) {
            self.networkProvider = networkProvider
            
//            (extraPaymentChangedOutputSignal, extraPaymentChangedOutputObserver) = Signal.pipe()
//            (pushController, pushControllerObserver) = Signal.pipe()
//            (codeValue, codeValueObserver) = Signal.pipe()
//            (timer, timerObserver) = Signal.pipe()
            
//            super.init()
        }
}

// MARK: Networking
private extension ContentViewModel {
    func getSearch(_ params: ITunesParams) {
        networkProvider
            .request(.search(params))
            .map(ITunesResponseModel.self)
            .on(starting: { [weak self] in
                self?.sending.value = true
            })
            .on(value: { [weak self] response in
                guard let self = self else {return}
                self.sending.value = false
//                self.extraPaymentChangedOutputObserver.send(value: true)
                self.showBankCardLimits()
                
            })
            .on(failed: { [weak self] error in
                self?.sending.value = false
                self?.errorDispatcher.handle(error: error)
            })
            .start()
    }
}
