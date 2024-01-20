//
//  MainViewModel.swift
//  ExchangeRateCalcApp
//
//  Created by 류창휘 on 1/20/24.
//

import Foundation
import Combine

enum CountryCase: String {
    case korea = "USDKRW"
    case japen = "USDJPY"
    case philippines = "USDPHP"
    
    func getCountryTitle() -> String {
        switch self {
        case .korea:
            return "한국 (KRW)"
        case .japen:
            return "일본 (JPY)"
        case .philippines:
            return "필리핀 (PHP)"
        }
    }
}
final class MainViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let getExchangeRateInformationUsecase: GetExchangeRateInformationUsecaseProcotol
    init(getExchangeRateInformationUsecase: GetExchangeRateInformationUsecaseProcotol) {
        self.getExchangeRateInformationUsecase = getExchangeRateInformationUsecase
    }
    @Published var exchangeRateInformationData: MainItemViewData?
    @Published var countryCase: CountryCase = .korea
    @Published var receptionCountry: String = CountryCase.korea.getCountryTitle()
    @Published var transferTitleAmount: String = ""
    @Published var outputAmount: String = "수취금액은 0 KRW 입니다"
    @Published var exchnageRate: String = ""
    
    func getData() {
        getExchangeRateInformationUsecase.execute()
            .sink { completion in
                switch completion {
                case .finished:
                    return
                case .failure(_):
                    return
                }
            } receiveValue: { [weak self] data in
                guard let self = self else { return }
                self.exchangeRateInformationData = MainItemViewData(exchangeRateInformationData: data)
            }
            .store(in: &cancellables)
    }
    func combineData() {
        Publishers.CombineLatest($countryCase, $transferTitleAmount)
            .sink { [weak self]country, amount in
                guard let self = self else { return }
                print(country, amount, "????")
                self.calcResultAmount(country: country, amount: amount)
            }
            .store(in: &cancellables)
    }
    func changeCountry(country: CountryCase) {
        countryCase = country
    }
    func inputTransferAmount(amount: String) {
        transferTitleAmount = amount
    }
    private func calcResultAmount(country: CountryCase, amount: String) {
        switch country {
        case .korea:
            receptionCountry = getReceptionCountry(country: .korea)
            outputAmount = getResultAmount(exchangeRate: exchangeRateInformationData?.krwRate ?? 0, country: .korea, amount: amount)
            exchnageRate = getExchangeRate(exchangeRate: exchangeRateInformationData?.krwRate ?? 0, country: .korea)
        case .japen:
            receptionCountry = getReceptionCountry(country: .japen)
            outputAmount = getResultAmount(exchangeRate: exchangeRateInformationData?.jpyRate ?? 0, country: .japen, amount: amount)
            exchnageRate = getExchangeRate(exchangeRate: exchangeRateInformationData?.jpyRate ?? 0, country: .japen)
        case .philippines:
            receptionCountry = getReceptionCountry(country: .philippines)
            outputAmount = getResultAmount(exchangeRate: exchangeRateInformationData?.jpyRate ?? 0, country: .philippines, amount: amount)
            exchnageRate = getExchangeRate(exchangeRate: exchangeRateInformationData?.phpRate ?? 0, country: .philippines)
        }
    }
    private func getReceptionCountry(country: CountryCase) -> String {
        return country.getCountryTitle()
    }
    private func getResultAmount(exchangeRate: Double, country: CountryCase, amount: String) -> String {
        guard let doubleAmount = Double(amount) else { return "" }
        switch country {
        case .korea:
            return "수취금액은 \(numberWorks(amount: exchangeRate * doubleAmount)) KRW 입니다."
        case .japen:
            return "수취금액은 \(numberWorks(amount: exchangeRate * doubleAmount)) JPY 입니다."
        case .philippines:
            return "수취금액은 \(numberWorks(amount: exchangeRate * doubleAmount)) PHP 입니다."
        }
    }
    private func getExchangeRate(exchangeRate: Double, country: CountryCase) -> String {
        switch country {
        case .korea:
            return "\(numberWorks(amount: exchangeRate)) KRW / USD"
        case .japen:
            return "\(numberWorks(amount: exchangeRate)) JPY / USD"
        case .philippines:
            return "\(numberWorks(amount: exchangeRate)) PHP / USD"
        }
    }
    private func numberWorks(amount: Double) -> String {
        return NumberWork.addComma(NumberWork.truncateDecimal(amount, point: 2))
    }
}
