//
//  GetExchangeRateInformationUsecase.swift
//  ExchangeRateCalcApp
//
//  Created by 류창휘 on 1/18/24.
//

import Foundation
import Combine

protocol GetExchangeRateInformationUsecaseProcotol {
    func execute() -> AnyPublisher<ExchangeRateInformationDTO, ErrorTypes>
}

struct GetExchangeRateInformationUsecase: GetExchangeRateInformationUsecaseProcotol {
    private let exchangeRateInformationRepository: ExchangeRateinformationRepositoryInterface
    init(exchangeRateInformationRepository: ExchangeRateinformationRepositoryInterface) {
        self.exchangeRateInformationRepository = exchangeRateInformationRepository
    }
    func execute() -> AnyPublisher<ExchangeRateInformationDTO, ErrorTypes> {
        return self.exchangeRateInformationRepository.data()
    }
}
