//
//  NetworkProviderMock.swift
//  iTunes
//
//  Created by Igor Ratynski on 30.04.2020.
//  Copyright © 2020 Igor Ratynski. All rights reserved.
//

import XCTest
@testable import iTunes
import Moya

class APITests: XCTestCase {
    
  // MARK: Supporting
  typealias ResponseClosure = (_ target: ITunesRequest) -> Endpoint
  
  enum EndpointResponses {
    case success
    case failure
  }
  
  // MARK: Properties
  var mockProvider: MoyaProvider<ITunesRequest>!
}
  // MARK: Tests
extension APITests {
  func testStubSuccessResponse() {
    let endpointClosure = test { [unowned self] () -> EndpointSampleResponse in
      self.response(type: .success)
    }
    mockProvider = MoyaProvider<ITunesRequest>(endpointClosure: endpointClosure,
                                               stubClosure: MoyaProvider.immediatelyStub)
    
    let params = ITunesParams(term: "The Eminem show", explicit: "Yes", limit: 50)
    mockProvider
      .request(.search(params))
      .map(ITunesResponseModel.self)
      .on(value: { response in
        XCTAssertEqual(response.results!.count, 50, "NetworkProvider: success response: must contains 50 entities")
      })
      .on(failed: { error in
        XCTAssertNil(error, "NetworkProvider: success response: error must be nil")
      })
      .start()
  }
  
  func testStubFailureResponse() {
    let endpointClosure = test { [unowned self] () -> EndpointSampleResponse in
      self.response(type: .failure)
    }

    mockProvider = MoyaProvider<ITunesRequest>(endpointClosure: endpointClosure,
                                               stubClosure: MoyaProvider.immediatelyStub)

    let params = ITunesParams(term: "The Eminem show", explicit: "Yes", limit: 50)
    mockProvider
      .request(.search(params))
      .map(ITunesResponseModel.self)
      .on(value: { response in
        XCTAssertNil(response, "NetworkProvider: failure response: value must be nil")
      })
      .on(failed: { error in
        XCTAssertNotNil(error, "NetworkProvider: failure response: must have an error")
      })
      .start()
  }
}

// MARK: Helping
private extension APITests {
  var stubJSON: Data {
    let url = Bundle.main.url(forResource: "SearchSuccessResponse", withExtension: "json")!
    return try! Data(contentsOf: url)
  }
  
  func test(response: @escaping Endpoint.SampleResponseClosure) -> ResponseClosure {
    return { (target: ITunesRequest) -> Endpoint in
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
        return .networkResponse(200, stubJSON)
      case .failure:
        return .networkError(NSError(domain: "Network test error", code: 420, userInfo: [:]))
    }
  }
}

//// TODO: Rewrite to:
// extension ITunesRequest {
//    var sampleData: Data {
//        switch self {
//        case .search:
//            let url = Bundle.main.url(forResource: "SearchSuccessResponse", withExtension: "json")!
//            return try! Data(contentsOf: url)
//        }
//    }
//}
