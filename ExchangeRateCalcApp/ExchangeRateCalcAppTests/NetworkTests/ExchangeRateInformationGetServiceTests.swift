//
//  ExchangeRateInformationGetServiceTests.swift
//  ExchangeRateCalcAppTests
//
//  Created by 류창휘 on 1/20/24.
//

import XCTest
import Combine
@testable import ExchangeRateCalcApp

final class ExchangeRateInformationGetServiceTests: XCTestCase {
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
    func test_MockSession이들어왔을때_데이터가넘어오는지확인() {
        // Given
        let getService = GetService(session: MockSession())
        let expectedValue = ExchangeRateInformationConstants.dummyData
        let expectation = self.expectation(description: "데이터 조회 성공")
        // When
        var returnValue: ExchangeRateInformationDTO?
        getService.request(from: urlString)
            .sink { completion in
                switch completion {
                case .finished:
                    return
                case .failure(let error):
                    XCTFail("테스트 실패 \(error)")
                }
            } receiveValue: { (data: ExchangeRateInformationDTO) in
                returnValue = data
                expectation.fulfill()
            }
            .store(in: &cancellables)
        // Then
        self.wait(for: [expectation], timeout: 10)
        XCTAssertEqual(returnValue?.privacy, expectedValue.privacy)
        XCTAssertEqual(returnValue?.source, expectedValue.source)
        XCTAssertEqual(returnValue?.success, expectedValue.success)
        XCTAssertEqual(returnValue?.timestamp, expectedValue.timestamp)
        XCTAssertEqual(returnValue?.quotes.japenExChangeRate, expectedValue.quotes.japenExChangeRate)
        XCTAssertEqual(returnValue?.quotes.koreaExChangeRate, expectedValue.quotes.koreaExChangeRate)
        XCTAssertEqual(returnValue?.quotes.philippinesChangeRate, expectedValue.quotes.philippinesChangeRate)
    }
    func test_MockFailSession이들어왔을때_에러가나오는지확인() {
        // Given
        let getService = GetService(session: MockFailSession())
        let expectation = self.expectation(description: "invalidURL 에러 반환")
        // When
        var returnValue: ErrorTypes?
        getService.request(from: urlString)
            .sink { completion in
                switch completion {
                case .finished:
                    return
                case .failure(let error):
                    returnValue = error
                    expectation.fulfill()
                }
            } receiveValue: { (data: ExchangeRateInformationDTO) in
                XCTFail("데이터가 조회되면 실패")
            }
            .store(in: &cancellables)
        // Then
        self.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(ErrorTypes.invalidURL, returnValue)
    }
}
