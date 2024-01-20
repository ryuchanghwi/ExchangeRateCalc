//
//  Requestable.swift
//  ExchangeRateCalcApp
//
//  Created by 류창휘 on 1/20/24.
//

import Foundation
import Combine
/*
 방식 참고 - https://hoonha.tistory.com/7
 */
protocol Requestable {
    func getService<T: Decodable>(from url: String) -> AnyPublisher<T, ErrorTypes>
}
