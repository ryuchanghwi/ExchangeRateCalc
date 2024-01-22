//
//  MainItemViewData.swift
//  ExchangeRateCalcApp
//
//  Created by 류창휘 on 1/20/24.
//

import Foundation

struct MainItemViewData {
    let viewTime: String
    let exchangeRate: String
    let krwRate: Double
    let jpyRate: Double
    let phpRate: Double
    let exchangeRateInformationData: ExchangeRateInformationDTO
    init(exchangeRateInformationData: ExchangeRateInformationDTO) {
        self.exchangeRateInformationData = exchangeRateInformationData
        self.viewTime = DateWork.timestampToString(timeStamp: exchangeRateInformationData.timestamp ?? 0, types: .yyyyMMddHHmm)
        self.exchangeRate = "\(NumberWork.addComma(NumberWork.truncateDecimal(exchangeRateInformationData.quotes.koreaExChangeRate ?? 0, point: 2))) KRW / USD"
        self.krwRate = exchangeRateInformationData.quotes.koreaExChangeRate ?? 0
        self.jpyRate = exchangeRateInformationData.quotes.japenExChangeRate ?? 0
        self.phpRate = exchangeRateInformationData.quotes.philippinesChangeRate ?? 0
    }
}
