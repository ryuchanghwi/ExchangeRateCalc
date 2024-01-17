//
//  DecimalPointWork.swift
//  ExchangeRateCalcApp
//
//  Created by 류창휘 on 1/17/24.
//

import Foundation

struct DecimalPointWork {
    static func truncateDecimal(_ value: Double, point: Int) -> Double {
        let multiplier = pow(10.0, Double(point))
        return Double(Int(value * multiplier)) / multiplier
    }
}
