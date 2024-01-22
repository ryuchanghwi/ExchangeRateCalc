//
//  MainViewModelTests.swift
//  ExchangeRateCalcAppTests
//
//  Created by 류창휘 on 1/22/24.
//

import XCTest
@testable import ExchangeRateCalcApp

final class MainViewModelTests: XCTestCase {
    var sut: MainViewModel!
    override func setUpWithError() throws {
        sut = MainViewModel(getExchangeRateInformationUsecase: GetExchangeRateInformationUsecase(exchangeRateInformationRepository: ExchangeRateinformationRepository(service: GetService(session: MockSession()))))
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: - numberWorks
    func test_changeCountry_메서드를실행시켰을때_countryCase가바뀌는지테스트() {
        // Given
        let expectedValue: CountryCase = .japen
        // When
        sut.changeCountry(country: .japen)
        let returnedValue = sut.countryCase
        // Then
        XCTAssertEqual(expectedValue, returnedValue)
    }
    // MARK: - inputTransferAmount
    func test_inputTransferAmount_메서드를실행시켰을때_transferTitleAmount가바뀌는지테스트() {
        // Given
        let expectedValue = "1000"
        // When
        sut.inputTransferAmount(amount: expectedValue)
        let returnedValue = sut.transferTitleAmount
        // Then
        XCTAssertEqual(expectedValue, returnedValue)
    }
    // MARK: - getData
    func test_getData_메서드를실행시켰을때_exchangeRateInformationData에데이터가들어가있는지확인() {
        // Given
        let expectedValue: MainItemViewData? = MainItemViewData(exchangeRateInformationData: ExchangeRateInformationConstants.dummyData)
        // When
        sut.getData()
        let returnedValue = sut.exchangeRateInformationData
        // Then
        XCTAssertEqual(expectedValue?.jpyRate, returnedValue?.jpyRate)
        XCTAssertEqual(expectedValue?.krwRate, returnedValue?.krwRate)
        XCTAssertEqual(expectedValue?.phpRate, returnedValue?.phpRate)
    }
    // MARK: - combineData
    func test_getData과combineData_메서드를실행시켰을떄_transferTitleAmount는범위안_국가는일본으로나오는지확인() {
        // Given
        sut.countryCase = .japen
        sut.transferTitleAmount = "1"
        // When
        sut.getData()
        sut.combineData()
        // Then
        XCTAssertEqual(sut.receptionCountry, "\(CountryCase.japen.getCountryTitle())")
        XCTAssertEqual(sut.outputAmount, "수취금액은 147.98 JPY 입니다.")
        XCTAssertEqual(sut.exchangeRate, "147.98 JPY / USD")
    }
    func test_getData과combineData_메서드를실행시켰을떄_transferTitleAmount는범위안_국가는필리핀으로나오는지확인() {
        // Given
        sut.countryCase = .philippines
        sut.transferTitleAmount = "1"
        // When
        sut.getData()
        sut.combineData()
        // Then
        XCTAssertEqual(sut.receptionCountry, "\(CountryCase.philippines.getCountryTitle())")
        XCTAssertEqual(sut.outputAmount, "수취금액은 147.98 PHP 입니다.")
        XCTAssertEqual(sut.exchangeRate, "56.02 PHP / USD")
    }
    func test_getData과combineData_메서드를실행시켰을떄_transferTitleAmount는범위안_국가는한국으로나오는지확인() {
        // Given
        sut.countryCase = .korea
        sut.transferTitleAmount = "1"
        // When
        sut.getData()
        sut.combineData()
        // Then
        XCTAssertEqual(sut.receptionCountry, "\(CountryCase.korea.getCountryTitle())")
        XCTAssertEqual(sut.outputAmount, "수취금액은 1,333.79 KRW 입니다.")
        XCTAssertEqual(sut.exchangeRate, "1,333.79 KRW / USD")
    }
    func test_getData과combineData_메서드를실행시켰을떄_transferTitleAmount를벗어나서_outputAmount_transferTitleAmount_receptionAmountState_초기화되는지확인() {
        // Given
        sut.transferTitleAmount = "100000"
        // When
        sut.getData()
        sut.combineData()
        // Then
        XCTAssertEqual(sut.transferTitleAmount, "")
        XCTAssertEqual(sut.outputAmount, "")
        XCTAssertEqual(sut.receptionAmountState, false)
    }
}
