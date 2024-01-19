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
        "USDKRW": 320.489701,
        "USDJPY": 147.811026,
        "USDPHP": 55.828506
}

"""
}
