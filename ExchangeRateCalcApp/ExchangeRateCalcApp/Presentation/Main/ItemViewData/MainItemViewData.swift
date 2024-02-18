//
//  MainItemViewData.swift
//  ExchangeRateCalcApp
//
//  Created by 류창휘 on 1/20/24.
//

import Foundation
/*
 데이터를 처음 호출할 때 뷰에 맞게끔 가공하기 위한 역할을 위해 만들었다. 
 */
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
