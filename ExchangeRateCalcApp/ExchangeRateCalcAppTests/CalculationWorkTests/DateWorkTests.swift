//
//  DateWorkTests.swift
//  ExchangeRateCalcAppTests
//
//  Created by 류창휘 on 1/17/24.
//

import XCTest
@testable import ExchangeRateCalcApp

final class DateWorkTests: XCTestCase {
    func test_데이트값이들어왔을때_yyyyMMddHHmm형식으로반환되는지확인() {
        // Given
        let expectedValue = "2022-01-17 15:30"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let value = dateFormatter.date(from: expectedValue)!
        // When
        let returnValue = DateWork.convertToString(value, types: .yyyyMMddHHmm)
        // Then
        XCTAssertEqual(expectedValue, returnValue)
    }
    func test_데이트값이들어왔을때_yyyyMMdd형식으로반환되는지확인() {
        // Given
        let expectedValue = "2022-01-17"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let value = dateFormatter.date(from: expectedValue)!
        // When
        let returnValue = DateWork.convertToString(value, types: .yyyyMMdd)
        // Then
        XCTAssertEqual(expectedValue, returnValue)
    }
    func test_데이트값이들어왔을때_MMdd형식으로반환되는지확인() {
        // Given
        let expectedValue = "01-17"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        let value = dateFormatter.date(from: expectedValue)!
        // When
        let returnValue = DateWork.convertToString(value, types: .MMdd)
        // Then
        XCTAssertEqual(expectedValue, returnValue)
    }
}
