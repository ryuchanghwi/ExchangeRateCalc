//
//  ExchangeRateInformationSession.swift
//  ExchangeRateCalcApp
//
//  Created by 류창휘 on 1/20/24.
//

import Foundation
import Combine

struct Session: Requestable {
    func request<T>(from url: String) -> AnyPublisher<T, ErrorTypes> where T : Decodable {
        guard let apiUrl = URL(string: url) else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        return URLSession.DataTaskPublisher(request: URLRequest(url: apiUrl), session: .shared)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                ErrorTypes.decoingError
            }
            .eraseToAnyPublisher()
    }
}
struct MockSession: Requestable {
    func request<T>(from url: String) -> AnyPublisher<T, ErrorTypes> where T : Decodable {
        return Just(ExchangeRateInformationConstants.dummyData as! T)
            .setFailureType(to: ErrorTypes.self)
            .eraseToAnyPublisher()
    }
}
struct MockFailSession: Requestable {
    func request<T>(from url: String) -> AnyPublisher<T, ErrorTypes> where T : Decodable {
        return Fail(error: .invalidURL).eraseToAnyPublisher()
    }
}
