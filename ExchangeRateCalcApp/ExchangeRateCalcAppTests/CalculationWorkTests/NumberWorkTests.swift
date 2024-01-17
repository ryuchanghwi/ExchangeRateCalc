//
//  NumberWorkTests.swift
//  ExchangeRateCalcAppTests
//
//  Created by 류창휘 on 1/17/24.
//

import XCTest
@testable import ExchangeRateCalcApp

final class NumberWorkTests: XCTestCase {
    // MARK: - truncateDecimal
    func test_truncateDecimal_Double값이주어졌을때_두번째소수점에서자르는지확인() {
        // Given
        let value: Double = 123.123
        let expectedValue = 123.12
        // When
        let returnValue = NumberWork.truncateDecimal(value, point: 2)
        // Then
        XCTAssertEqual(returnValue, expectedValue)
    }
    func test_truncateDecimal_소수가없는값이주어졌을때_소수두번째값까지0이이나오는지확인() {
        // Given
        let value: Double = 123
        let expectedValue = 123.00
        // When
        let returnValue = NumberWork.truncateDecimal(value, point: 2)
        // Then
        XCTAssertEqual(returnValue, expectedValue)
    }
    func test_truncateDecimal_소수점첫번째자리까지값이주어졌을때_소수두번째값에0이이나오는지확인() {
        // Given
        let value: Double = 123.1
        let expectedValue = 123.10
        // When
        let returnValue = NumberWork.truncateDecimal(value, point: 2)
        // Then
        XCTAssertEqual(returnValue, expectedValue)
    }
    // MARK: - addComma
    func test_addComma_Double값이주어졌을때_콤마가제대로찍혀서나오는지확인() {
        // Given
        let value: Double = 123123.12
        let expectedValue: String = "123,123.12"
        // When
        let returnValue = NumberWork.addComma(value)
        // Then
        XCTAssertEqual(returnValue, expectedValue)
    }
    func test_addComma_0이주어졌을때_콤마없이0이나오는지확인() {
        // Given
        let value: Double = 0
        let expectedValue: String = "0"
        // When
        let returnValue = NumberWork.addComma(value)
        // Then
        XCTAssertEqual(returnValue, expectedValue)
    }
}