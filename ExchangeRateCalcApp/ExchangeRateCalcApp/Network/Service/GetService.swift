//
//  GetService.swift
//  ExchangeRateCalcApp
//
//  Created by 류창휘 on 1/19/24.
//

import Foundation
import Combine

final class GetService {
    private let urlSession: URLSession
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    static let shared = GetService()
    func getService<T: Decodable>(from url: String) -> AnyPublisher<T, ErrorTypes> {
        guard let apiUrl = URL(string: url) else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        return urlSession.dataTaskPublisher(for: apiUrl)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                ErrorTypes.decoingError
            }
            .eraseToAnyPublisher()
    }
}
