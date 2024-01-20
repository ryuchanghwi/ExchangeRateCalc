//
//  ExchangeRateinformationRepository.swift
//  ExchangeRateCalcApp
//
//  Created by 류창휘 on 1/20/24.
//

import Foundation
import Combine

struct ExchangeRateinformationRepository: ExchangeRateinformationRepositoryInterface {
    private let service: GetService
    init(service: GetService) {
        self.service = service
    }
    func data() -> AnyPublisher<ExchangeRateInformationDTO, ErrorTypes> {
        self.service.request(from: "\(Secrets.baseURL)live?access_key=\(Secrets.apiKey)")
    }
}
