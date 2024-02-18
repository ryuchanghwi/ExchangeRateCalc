//
//  GetExchangeRateInformationUsecaseTests.swift
//  ExchangeRateCalcAppTests
//
//  Created by 류창휘 on 1/18/24.
//

import XCTest
import Combine
@testable import ExchangeRateCalcApp

struct MockExchangeRateinformationRepository: ExchangeRateinformationRepositoryInterface {
    private let hasError: Bool
    init(hasError: Bool) {
        self.hasError = hasError
    }
    func data() -> AnyPublisher<ExchangeRateInformationDTO, ErrorTypes> {
        if hasError {
            return Fail(error: ErrorTypes.decoingError)
                .eraseToAnyPublisher()
        } else {
            let exchangeRateData = ExchangeRateInformationConstants.dummyData
            return Just(exchangeRateData)
                .setFailureType(to: ErrorTypes.self)
                .eraseToAnyPublisher()
        }
    }
}

final class GetExchangeRateInformationUsecaseTests: XCTestCase {
    var sut: GetExchangeRateInformationUsecase!
    var cancellables: Set<AnyCancellable>!
    override func setUpWithError() throws {
        cancellables = []
    }
    override func tearDownWithError() throws {
        sut = nil
        cancellables = nil
    }
    func test_usecase_데이터가주어졌을때_데이터가출력되는지확인() {
        // Given
        sut = GetExchangeRateInformationUsecase(exchangeRateInformationRepository: MockExchangeRateinformationRepository(hasError: false))
        let expectedValue = ExchangeRateInformationConstants.dummyData
        let expectation = self.expectation(description: "데이터 조회 성공")
        // When
        var returnValue: ExchangeRateInformationDTO?
        sut.execute()
            .sink { completion in
                switch completion {
                case .finished:
                    return
                case .failure(let error):
                    XCTFail("테스트 실패 \(error)")
                }
            } receiveValue: { data in
                returnValue = data
                expectation.fulfill()
            }.store(in: &cancellables)
        // Then
        self.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(returnValue?.quotes.japenExChangeRate, expectedValue.quotes.japenExChangeRate)
        XCTAssertEqual(returnValue?.quotes.koreaExChangeRate, expectedValue.quotes.koreaExChangeRate)
        XCTAssertEqual(returnValue?.quotes.philippinesChangeRate, expectedValue.quotes.philippinesChangeRate)
    }
    func test_usecase_에러상황이주어졌을때_에러를출력되는지확인() {
        // Given
        sut = GetExchangeRateInformationUsecase(exchangeRateInformationRepository: MockExchangeRateinformationRepository(hasError: true))
        let expectationValue: ErrorTypes = .decoingError
        let expectation = self.expectation(description: "noData 에러 발생")
        // When
        var returnValue: ErrorTypes?
        sut.execute()
            .sink { completion in
                switch completion {
                case .finished:
                    return
                case .failure(let error):
                    returnValue = error
                    expectation.fulfill()
                }
            } receiveValue: { data in
                XCTFail("테스트 실패 \(data)")
            }.store(in: &cancellables)
        // Then
        self.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(returnValue, expectationValue)
    }
}
