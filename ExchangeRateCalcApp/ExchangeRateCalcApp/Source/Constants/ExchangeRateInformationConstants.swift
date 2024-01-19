//
//  ExchangeRateInformationConstants.swift
//  ExchangeRateCalcApp
//
//  Created by 류창휘 on 1/18/24.
//

import Foundation

struct ExchangeRateInformationConstants {
    static let dummyData = ExchangeRateInformationDTO(succes: true, terms: "https://currencylayer.com/terms", privacy: "https://currencylayer.com/privacy", timestamp: 1705572303, source: "USD", quotes: Quotes(koreaExChangeRate: 320.489701, japenExChangeRate: 147.811026, philippinesChangeRate: 55.828506))
    static let jsonString = """
{
    "success": true,
    "terms": "https://currencylayer.com/terms",
    "privacy": "https://currencylayer.com/privacy",
    "timestamp": 1705572303,
    "source": "USD",
    "quotes": {
        "USDKRW": 3.67288,
        "USDJPY": 72.820546,
        "USDPHP": 95.306269
}

"""
}
