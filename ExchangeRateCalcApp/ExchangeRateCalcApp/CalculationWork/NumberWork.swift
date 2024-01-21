//
//  DecimalPointWork.swift
//  ExchangeRateCalcApp
//
//  Created by 류창휘 on 1/17/24.
//

import Foundation
/*
 콤마기능 참고
 https://velog.io/@juh2/Swift-%EC%88%AB%EC%9E%90%EC%97%90-%EC%BD%A4%EB%A7%88-%EB%84%A3%EA%B8%B0-%EB%B9%BC%EA%B8%B0-%EA%B0%80%EA%B2%A9-%ED%91%9C%EC%8B%9C
 */
struct NumberWork {
    static func truncateDecimal(_ value: Double, point: Int) -> Double {
        let multiplier = pow(10.0, Double(point))
        return Double(Int(value * multiplier)) / multiplier
    }
    static func addComma(_ value: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: value)) ?? ""
    }
    static func checkReceptionAmountState(amount: Double) -> Bool {
        var returnValue: Bool = true
        if amount < 0 || amount > 10000 {
            returnValue = false
        }
        return returnValue
    }
}
