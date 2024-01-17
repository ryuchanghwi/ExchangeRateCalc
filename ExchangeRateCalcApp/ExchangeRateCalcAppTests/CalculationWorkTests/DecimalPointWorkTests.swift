//
//  DecimalPointWorkTests.swift
//  ExchangeRateCalcAppTests
//
//  Created by 류창휘 on 1/17/24.
//

import XCTest
@testable import ExchangeRateCalcApp

final class DecimalPointWorkTests: XCTestCase {
    func test_truncateDecimal_Double값이주어졌을때_두번째소수점에서자르는지확인() {
        // Given
        let value: Double = 123.123
        let expectedValue = 123.12
        // When
        let returnValue = DecimalPointWork.truncateDecimal(value, point: 2)
        // Then
        XCTAssertEqual(returnValue, expectedValue)
    }
    func test_truncateDecimal_소주가없는값이주어졌을때_소수두번째값까지0이이나오는지확인() {
        // Given
        let value:Double = 123
        let expectedValue = 123.00
        // When
        let returnValue = DecimalPointWork.truncateDecimal(value, point: 2)
        // Then
        XCTAssertEqual(returnValue, expectedValue)
    }
}
