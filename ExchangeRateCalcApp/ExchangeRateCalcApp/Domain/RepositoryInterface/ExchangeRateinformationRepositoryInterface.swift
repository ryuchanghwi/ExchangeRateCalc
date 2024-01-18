//
//  ExchangeRateinformationRepositoryInterface.swift
//  ExchangeRateCalcApp
//
//  Created by 류창휘 on 1/18/24.
//

import Foundation
import Combine

protocol ExchangeRateinformationRepositoryInterface {
    func data() -> AnyPublisher<ExchangeRateInformationDTO, ErrorTypes>
}
