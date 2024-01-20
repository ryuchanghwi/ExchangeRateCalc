//
//  GetService.swift
//  ExchangeRateCalcApp
//
//  Created by 류창휘 on 1/19/24.
//

import Foundation
import Combine

final class GetService {
    private let session: Requestable
    init(session: Requestable = Session()) {
        self.session = session
    }
    static let shared = GetService()
    func request<T: Decodable>(from url: String) -> AnyPublisher<T, ErrorTypes> {
        return session.request(from: url)
    }
}
