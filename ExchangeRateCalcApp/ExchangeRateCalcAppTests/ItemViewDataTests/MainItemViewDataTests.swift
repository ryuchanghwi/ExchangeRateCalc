//
//  MainItemViewDataTests.swift
//  ExchangeRateCalcAppTests
//
//  Created by 류창휘 on 1/22/24.
//

import XCTest
@testable import ExchangeRateCalcApp

final class MainItemViewDataTests: XCTestCase {
    var sut: MainItemViewData!
    override func tearDownWithError() throws {
        sut = nil
    }
    func test_MainItemViewData_ExchangeRateInformationDTO데이터가주어질때_원하는형식으로반환되는지확인() {
        // Given
        sut = MainItemViewData(exchangeRateInformationData: ExchangeRateInformationConstants.dummyData)
        let expectedViewTime = DateWork.timestampToString(timeStamp: ExchangeRateInformationConstants.dummyData.timestamp!, types: .yyyyMMddHHmm)
        let expectedExchageRate = "\(NumberWork.addComma(NumberWork.truncateDecimal(ExchangeRateInformationConstants.dummyData.quotes.koreaExChangeRate!, point: 2))) KRW / USD"
        let expectedKrwRate = ExchangeRateInformationConstants.dummyData.quotes.koreaExChangeRate!
        let expectedJpyRate = ExchangeRateInformationConstants.dummyData.quotes.japenExChangeRate!
        let expectedPhpRate = ExchangeRateInformationConstants.dummyData.quotes.philippinesChangeRate!
        // When
        let returnedViewTime = sut.viewTime
        let returnedViewExchangeRate = sut.exchangeRate
        let returnedExpectedKrwRate = sut.krwRate
        let returnedJpyRate = sut.jpyRate
        let returnedPhpRate = sut.phpRate
        // Then
        XCTAssertEqual(expectedViewTime, returnedViewTime)
        XCTAssertEqual(expectedExchageRate, returnedViewExchangeRate)
        XCTAssertEqual(expectedKrwRate, returnedExpectedKrwRate)
        XCTAssertEqual(expectedJpyRate, returnedJpyRate)
        XCTAssertEqual(expectedPhpRate, returnedPhpRate)
    }
    func test_MainItemViewData_ExchangeRateInformationDTO에값이없을때_원하는형식으로반환되는지확인() {
        // Given
        let nullMainItemViewData = ExchangeRateInformationDTO(success: nil, terms: nil, privacy: nil, timestamp: nil, source: nil, quotes: Quotes(koreaExChangeRate: nil, japenExChangeRate: nil, philippinesChangeRate: nil))
        sut = MainItemViewData(exchangeRateInformationData: nullMainItemViewData)
        let expectedViewTime = DateWork.timestampToString(timeStamp: 0, types: .yyyyMMddHHmm)
        let expectedExchageRate = "\(NumberWork.addComma(NumberWork.truncateDecimal(0, point: 2))) KRW / USD"
        let expectedKrwRate: Double = 0
        let expectedJpyRate: Double = 0
        let expectedPhpRate: Double = 0
        // When
        let returnedViewTime = sut.viewTime
        let returnedExchangeRate = sut.exchangeRate
        let returnedKrwRate = sut.krwRate
        let returnedJpyRate = sut.jpyRate
        let returnedPhpRate = sut.phpRate
        // Then
        XCTAssertEqual(expectedViewTime, returnedViewTime)
        XCTAssertEqual(expectedExchageRate, returnedExchangeRate)
        XCTAssertEqual(expectedKrwRate, returnedKrwRate)
        XCTAssertEqual(expectedJpyRate, returnedJpyRate)
        XCTAssertEqual(expectedPhpRate, returnedPhpRate)
    }
}
