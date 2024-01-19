//
//  ExchangeRateInformationDTO.swift
//  ExchangeRateCalcApp
//
//  Created by 류창휘 on 1/18/24.
//

import Foundation

struct ExchangeRateInformationDTO: Decodable {
    let success: Bool?
    let terms: String?
    let privacy: String?
    let timestamp: Int?
    let source: String?
    let quotes: Quotes
}

struct Quotes: Decodable {
    let koreaExChangeRate: Double?
    let japenExChangeRate: Double?
    let philippinesChangeRate: Double?
    
    enum CodingKeys: String, CodingKey {
        case koreaExChangeRate = "USDKRW"
        case japenExChangeRate = "USDJPY"
        case philippinesChangeRate = "USDPHP"
    }
}
