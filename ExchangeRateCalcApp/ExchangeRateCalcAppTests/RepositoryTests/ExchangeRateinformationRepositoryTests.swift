//
//  ExchangeRateinformationRepositoryTests.swift
//  ExchangeRateCalcAppTests
//
//  Created by 류창휘 on 1/20/24.
//

import XCTest
import Combine
@testable import ExchangeRateCalcApp

final class ExchangeRateinformationRepositoryTests: XCTestCase {
    var sut: ExchangeRateinformationRepository!
    var cancellables: Set<AnyCancellable>!
    override func setUpWithError() throws {
        sut = ExchangeRateinformationRepository(service: GetService(session: MockSession()))
        cancellables = []
    }
    override func tearDownWithError() throws {
        sut = nil
        cancellables = nil
    }
    func test_ExchangeRateinformationRepository_data메서드호출했을때_데이터넘어오는지확인() {
        // Given
        let expectedValue = ExchangeRateInformationConstants.dummyData
        let expectation = self.expectation(description: "데이터 조회 성공")
        // When
        var returnValue: ExchangeRateInformationDTO?
        sut.data()
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
}
