//
//  MainViewModel.swift
//  ExchangeRateCalcApp
//
//  Created by 류창휘 on 1/20/24.
//

import Foundation
import Combine
/*
 CaseIterable는 프로토콜로 열거형의 케이스들을 배열 컬렉션과 같이 순회할 수 있도록 만들어줍니다.
 안에 AllCases라는 프로퍼티는 Collection이라는 프로토콜을 채택하는데
 이를 통해 인덱스의 시작과 끝을 알 수 있고 인덱스로 접근이 가능합니다.
 */
enum CountryCase: String, CaseIterable {
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
// ObservableObject 이건 필요 없었음
// ObservableObject는 프로토콜로 AnyObject가 있어서 클래스와 함께 사용해야함
// ObservableObject를 채택한 클래스의 Published 변수의 변화를 관찰하고
// willChange로 ObservableObject 알리기 위해서 사용
// final class - 이 클래스는 오버라이드할 일이 없다라는 의미
/*
 final을 사용하면 런타임 성능이 향상된다.
 클래스는 기본적으로 런타임시 어떤 메소드를 호출할지 결정한다.
 
 */
final class MainViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let getExchangeRateInformationUsecase: GetExchangeRateInformationUsecaseProcotol
    init(getExchangeRateInformationUsecase: GetExchangeRateInformationUsecaseProcotol) {
        self.getExchangeRateInformationUsecase = getExchangeRateInformationUsecase
    }
    // Published는 class와 사용해야 하지만 그 이유를 찾지는 못했음
    // $ 는 퍼블리셔에 접근하기 위함
    @Published var exchangeRateInformationData: MainItemViewData?
    @Published var countryCase: CountryCase = .korea
    @Published var receptionCountry: String = CountryCase.korea.getCountryTitle()
    @Published var transferTitleAmount: String = ""
    @Published var outputAmount: String = ""
    @Published var exchangeRate: String = ""
    @Published var receptionAmountState: Bool = true
    // MARK: - In ViewController
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
            .sink { [weak self] country, amount in
                guard let self = self else { return }
                if showAlertState(amount: Double(amount) ?? 0) {
                    resetReceptionState()
                    resetOutputAmount()
                    resetTransferTitleAmount()
                } else {
                    self.calcResultAmount(country: country, amount: amount)
                }
            }
            .store(in: &cancellables)
    }
    func changeCountry(country: CountryCase) {
        countryCase = country
    }
    func inputTransferAmount(amount: String) {
        transferTitleAmount = amount
    }
    // MARK: - In ViewModel
    private func calcResultAmount(country: CountryCase, amount: String) {
        switch country {
        case .korea:
            receptionCountry = getReceptionCountry(country: .korea)
            outputAmount = getResultAmount(exchangeRate: exchangeRateInformationData?.krwRate ?? 0, country: .korea, amount: amount)
            exchangeRate = getExchangeRate(exchangeRate: exchangeRateInformationData?.krwRate ?? 0, country: .korea)
        case .japen:
            receptionCountry = getReceptionCountry(country: .japen)
            outputAmount = getResultAmount(exchangeRate: exchangeRateInformationData?.jpyRate ?? 0, country: .japen, amount: amount)
            exchangeRate = getExchangeRate(exchangeRate: exchangeRateInformationData?.jpyRate ?? 0, country: .japen)
        case .philippines:
            receptionCountry = getReceptionCountry(country: .philippines)
            outputAmount = getResultAmount(exchangeRate: exchangeRateInformationData?.jpyRate ?? 0, country: .philippines, amount: amount)
            exchangeRate = getExchangeRate(exchangeRate: exchangeRateInformationData?.phpRate ?? 0, country: .philippines)
        }
    }
    private func resetOutputAmount() {
        outputAmount = ""
    }
    private func resetTransferTitleAmount() {
        transferTitleAmount = ""
    }
    private func resetReceptionState() {
        receptionAmountState = false
    }
    private func showAlertState(amount: Double) -> Bool {
        return !NumberWork.checkReceptionAmountState(amount: amount)
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


final class MainViewModel2: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let getExchangeRateInformationUsecase: GetExchangeRateInformationUsecaseProcotol
    private let dateWork: DateWork2
    init(getExchangeRateInformationUsecase: GetExchangeRateInformationUsecaseProcotol, dateWork: DateWork2) {
        self.getExchangeRateInformationUsecase = getExchangeRateInformationUsecase
        self.dateWork = dateWork
    }
    @Published var exchangeRateInformationData: MainItemViewData?
    @Published var countryCase: CountryCase = .korea
    @Published var receptionCountry: String = CountryCase.korea.getCountryTitle()
    @Published var transferTitleAmount: String = ""
    @Published var outputAmount: String = ""
    @Published var exchangeRate: String = ""
    @Published var receptionAmountState: Bool = true
    // MARK: - In ViewController
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
            .sink { [weak self] country, amount in
                guard let self = self else { return }
                if showAlertState(amount: Double(amount) ?? 0) {
                    resetReceptionState()
                    resetOutputAmount()
                    resetTransferTitleAmount()
                } else {
                    self.calcResultAmount(country: country, amount: amount)
                }
            }
            .store(in: &cancellables)
    }
    func changeCountry(country: CountryCase) {
        countryCase = country
    }
    func inputTransferAmount(amount: String) {
        transferTitleAmount = amount
    }
    // MARK: - In ViewModel
    private func calcResultAmount(country: CountryCase, amount: String) {
        switch country {
        case .korea:
            receptionCountry = getReceptionCountry(country: .korea)
            outputAmount = getResultAmount(exchangeRate: exchangeRateInformationData?.krwRate ?? 0, country: .korea, amount: amount)
            exchangeRate = getExchangeRate(exchangeRate: exchangeRateInformationData?.krwRate ?? 0, country: .korea)
        case .japen:
            receptionCountry = getReceptionCountry(country: .japen)
            outputAmount = getResultAmount(exchangeRate: exchangeRateInformationData?.jpyRate ?? 0, country: .japen, amount: amount)
            exchangeRate = getExchangeRate(exchangeRate: exchangeRateInformationData?.jpyRate ?? 0, country: .japen)
        case .philippines:
            receptionCountry = getReceptionCountry(country: .philippines)
            outputAmount = getResultAmount(exchangeRate: exchangeRateInformationData?.jpyRate ?? 0, country: .philippines, amount: amount)
            exchangeRate = getExchangeRate(exchangeRate: exchangeRateInformationData?.phpRate ?? 0, country: .philippines)
        }
    }
    private func resetOutputAmount() {
        outputAmount = ""
    }
    private func resetTransferTitleAmount() {
        transferTitleAmount = ""
    }
    private func resetReceptionState() {
        receptionAmountState = false
    }
    private func showAlertState(amount: Double) -> Bool {
        return !NumberWork.checkReceptionAmountState(amount: amount)
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
