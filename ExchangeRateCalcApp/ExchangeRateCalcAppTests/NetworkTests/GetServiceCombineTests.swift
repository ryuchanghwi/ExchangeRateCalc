//
//  GetServiceCombineTests.swift
//  ExchangeRateCalcAppTests
//
//  Created by 류창휘 on 1/31/24.
//

import XCTest
import Combine
@testable import ExchangeRateCalcApp

final class GetServiceCombineTests: XCTestCase {
    var urlString: String!
    var cancellables: Set<AnyCancellable>!
    override func setUpWithError() throws {
        urlString = "\(Secrets.baseURL)live?access_key=\(Secrets.apiKey)"
        cancellables = []
    }

    override func tearDownWithError() throws {
        urlString = nil
        cancellables = nil
    }
    func test_1() {
        let urlResponse = HTTPURLResponse(url: URL(string: "http://localhost:8080")!,
                                          statusCode: 200,
                                          httpVersion: nil,
                                          headerFields: nil)
        let jsonString = ExchangeRateInformationConstants.jsonString
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        URLProtocolMock.testURLs = [URL(string: urlString): Data(jsonString.utf8)]
        URLProtocolMock.response = urlResponse
        
//        config.protocolClasses = [MockURLProtocol.self]
//        MockURLProtocol.stubResponseData = Data(jsonString.utf8)
//        MockURLProtocol.response = urlResponse
        
        let session = URLSession(configuration: config)
        let getService = GetServiceCombine(dataPublisehr: APISessionDataPublisher(session: session))
        let expectation = self.expectation(description: "데이터 조회 성공")
        getService.request(from: urlString)
            .sink { completion in
                switch completion {
                case .finished:
                    return
                case .failure(let error):
                    XCTFail("테스트 실패 \(error)")
                }
            } receiveValue: { (data: ExchangeRateInformationDTO) in
                print(data)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        self.wait(for: [expectation], timeout: 10)
    }
}
