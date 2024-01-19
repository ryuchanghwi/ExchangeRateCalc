//
//  Secrets.swift
//  ExchangeRateCalcApp
//
//  Created by 류창휘 on 1/19/24.
//

import Foundation

/*
 해당 코드 참고 - https://velog.io/@raindrop/CocoaPods-%ED%99%98%EA%B2%BD%EC%97%90%EC%84%9C-xcconfig-%EC%B6%94%EA%B0%80%ED%95%B4%EC%84%9C-%EB%AF%BC%EA%B0%90%ED%95%9C-%EC%A0%95%EB%B3%B4API-%EC%88%A8%EA%B8%B0%EA%B8%B0
 */
struct Secrets {
    struct Keys {
        static let baseURL = "BASE_URL"
        static let apiKey = "API_KEY"
    }
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("")
        }
        return dict
    }()
    
    static let baseURL: String = {
        guard let key = Secrets.infoDictionary["BASE_URL"] as? String else {
            fatalError("")
        }
        return key
    }()
    static let apiKey: String = {
        guard let key = Secrets.infoDictionary["API_KEY"] as? String else {
            fatalError("")
        }
        return key
    }()
}
