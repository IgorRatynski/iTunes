//
//  NetworkProviderMock.swift
//  iTunesTest
//
//  Created by Igor Ratynski on 30.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import XCTest
@testable import iTunesTest
import Moya

class APITests: XCTestCase {
    
  // MARK: Supporting
  typealias ResponseClosure = (_ target: ITunesService) -> Endpoint
  
  enum EndpointResponses {
    case success
    case failure
  }
  
  // MARK: Properties
  var mockProvider: MoyaProvider<ITunesService>!
  
  // MARK: Lifecycle
  override func setUp() {
//    mockProvider = MoyaProvider<ITunesService>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
  }
  
  override func tearDown() {
//    mockProvider = nil
  }
  
  func test(response: @escaping Endpoint.SampleResponseClosure) -> ResponseClosure {
    return { (target: ITunesService) -> Endpoint in
      return Endpoint(url: URL(target: target).absoluteString,
                      sampleResponseClosure: response,
                      method: target.method,
                      task: target.task,
                      httpHeaderFields: target.headers)
    }
  }
  
  
  func response(type: EndpointResponses) -> EndpointSampleResponse {
    switch type {
      case .success:
        return .networkResponse(200, testSampleData)
      case .failure:
        return .networkError(NSError(domain: "aaa", code: 1488, userInfo: [:]))
    }
  }
  
  func testSuccessResponse() {
    let endpointClosure = test { () -> EndpointSampleResponse in
      self.response(type: .success)
    }
    mockProvider = MoyaProvider<ITunesService>(endpointClosure: endpointClosure,
                                               stubClosure: MoyaProvider.delayedStub(.init(5)))
    
    let params = ITunesParams(term: "The Eminem show", explicit: "Yes", limit: 50)
    mockProvider
      .request(.search(params))
      .map(ITunesResponseModel.self)
      .on(value: { [weak self] response in
        XCTAssertEqual(response.results.count ?? 0, 50, "true")
      })
      .on(failed: { [weak self] error in
        XCTAssertNil(error, "error!")
      })
      .start()
  }
  
//  func testFailureResponse() {
//    let endpointClosure = test { () -> EndpointSampleResponse in
//      self.response(type: .failure)
//    }
//
//    mockProvider = MoyaProvider<ITunesService>(endpointClosure: endpointClosure,
//                                               stubClosure: MoyaProvider.delayedStub(.init(500)))
//
//    let params = ITunesParams(term: "The Eminem show", explicit: "Yes", limit: 50)
//    mockProvider
//      .request(.search(params))
//      .map(ITunesResponseModel.self)
//      .on(value: { [weak self] response in
////        XCTAssert
//      })
//      .on(failed: { [weak self] error in
////        XCTAssert
//      })
//      .start()
//  }
}

private var testSampleData: Data {
  let url = Bundle.main.url(forResource: "SearchSuccessResponse", withExtension: "json")!
  return try! Data(contentsOf: url)
}
// TODO: Rewrite to:

// extension ITunesService {
//    var testSampleData: Data {
//        switch self {
//        case .search:
//            let url = Bundle.main.url(forResource: "SearchSuccessResponse", withExtension: "json")!
//            return try! Data(contentsOf: url)
//        }
//    }
//}
