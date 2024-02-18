//
//  ExchangeRateInformationSession.swift
//  ExchangeRateCalcApp
//
//  Created by 류창휘 on 1/20/24.
//

import Foundation
import Combine

struct Session: Requestable {
    // 해당 제네릭이 어떤 프로토콜을 따르는지 알 수 없기 때문에 where로 알려주는 것
    func request<T: Decodable>(from url: String) -> AnyPublisher<T, ErrorTypes> {
        guard let apiUrl = URL(string: url) else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        return URLSession.DataTaskPublisher(request: URLRequest(url: apiUrl), session: .shared)
            .map(\.data) // keypath를 통해 접근
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                ErrorTypes.decoingError
            }
            .eraseToAnyPublisher()
    }
}
struct MockSession: Requestable {
    func request<T>(from url: String) -> AnyPublisher<T, ErrorTypes> where T : Decodable {
        let jsonString = ExchangeRateInformationConstants.jsonString.data(using: .utf8)
        do {
            let decodedData = try! JSONDecoder().decode(T.self, from: jsonString!)
            return Just(decodedData)
                .setFailureType(to: ErrorTypes.self)
                .eraseToAnyPublisher()
            // Failure 타입이 Never일 때, publihser의 Error Type을 변경
        }
    }
}
struct MockFailSession: Requestable {
    func request<T>(from url: String) -> AnyPublisher<T, ErrorTypes> where T : Decodable {
        return Fail(error: .invalidURL).eraseToAnyPublisher()
    }
}
// 반환타입은 AnyPublisher<T, ErrorTypes>
// AnyPublisher를 만들어 주기 위해 eraseToAnyPublisher 사용
