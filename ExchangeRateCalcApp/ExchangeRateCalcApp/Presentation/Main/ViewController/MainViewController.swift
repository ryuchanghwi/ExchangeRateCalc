//
//  MainViewController.swift
//  ExchangeRateCalcApp
//
//  Created by 류창휘 on 1/17/24.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    // MARK: - Property
    private let viewModel = MainViewModel(getExchangeRateInformationUsecase: GetExchangeRateInformationUsecase(exchangeRateInformationRepository: ExchangeRateinformationRepository(service: GetService(session: MockSession()))))
    private var cancellables: Set<AnyCancellable> = []
    // MARK: - UI Property
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "환율 계산"
        label.textColor = .black
        label.font = .systemFont(ofSize: 40)
        return label
    }()
    private let transferCountryInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "송금국가 : "
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    private let transferCountryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "미국(USD)"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    private let receptionCountryInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "수취국가 : "
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    private let receptionCountryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "한국 (KRW)"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    private let exchangeRateInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "환율 : "
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    private let exchangeRateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "1,130.05 KRW / USD"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    private let viewTimeInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "조회시간 : "
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    private let viewTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "2019-03-20 16:13"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    private let transferInfoAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "송금액 : "
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    private let usdInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "USD"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    private let transferTitleAmountTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1
        textField.textAlignment = .right
        textField.keyboardType = .numberPad
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.alignment = .trailing
        return stackView
    }()
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.alignment = .leading
        return stackView
    }()
    private let pickerView: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "수취금액은 113,004.98 KRW 입니다"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setConfig()
        setDelegate()
        actions()
        viewModel.getData()
        viewModel.combineData()
        setBinding()
    }
    // MARK: - Bind
    private func setBinding() {
        viewModel.$exchangeRateInformationData
            .receive(on: RunLoop.main)
            .sink { [weak self] data in
                guard let self = self else { return }
                self.viewTimeTitleLabel.text = data?.viewTime
                self.exchangeRateTitleLabel.text = data?.exchangeRate
                self.resultLabel.text = data?.result
            }
            .store(in: &cancellables)
        viewModel.$receptionCountry
            .receive(on: RunLoop.main)
            .sink { [weak self] data in
                guard let self = self else { return }
                self.receptionCountryTitleLabel.text = data
            }
            .store(in: &cancellables)
        viewModel.$outputAmount
            .receive(on: RunLoop.main)
            .sink { [weak self] data in
                guard let self = self else { return }
                self.resultLabel.text = data
            }
            .store(in: &cancellables)
        viewModel.$exchnageRate
            .receive(on: RunLoop.main)
            .sink { [weak self] data in
                guard let self = self else { return }
                self.exchangeRateTitleLabel.text = data
            }
            .store(in: &cancellables)
        viewModel.$receptionAmountState
            .receive(on: RunLoop.main)
            .sink { [weak self] data in
                guard let self = self else { return }
                if data == false {
                    showAlert()
                }
            }
            .store(in: &cancellables)
    }
    // MARK: - Action Helper
    private func actions() {
        self.transferTitleAmountTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
    }
    private func showAlert() {
        let alert = UIAlertController(title: "알림", message: "송금액이 바르지 않습니다.", preferredStyle: .alert)
        self.present(alert, animated: true)
        self.resetTextField()
        Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { _ in
            alert.dismiss(animated: true)
        }
    }
    // MARK: - @objc Methods
    @objc func textFieldDidChange() {
        viewModel.inputTransferAmount(amount: transferTitleAmountTextField.text ?? "")
    }
}
// MARK: - Extensions
extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CountryCase.allCases.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let countryCases = CountryCase.allCases
        let selectedCountry = countryCases[row]
        return selectedCountry.getCountryTitle()
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 70
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            viewModel.changeCountry(country: .korea)
        case 1:
            viewModel.changeCountry(country: .japen)
        case 2:
            viewModel.changeCountry(country: .philippines)
        default:
            print("default")
        }
    }
}
extension MainViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        addToolBar()
    }
}
extension MainViewController {
    // MARK: - Custom Method
    private func resetTextField() {
        transferTitleAmountTextField.text = ""
    }
    private func addToolBar() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonClicked))
        toolBar.items = [doneButton]
        transferTitleAmountTextField.inputAccessoryView = toolBar
    }
    // MARK: - @objc Methods
    @objc func doneButtonClicked() {
        transferTitleAmountTextField.resignFirstResponder()
    }
    // MARK: - Setting
    private func setDelegate() {
        pickerView.delegate = self
        pickerView.dataSource = self
        transferTitleAmountTextField.delegate = self
    }
    private func setLayout() {
        [titleLabel, infoStackView, titleStackView, usdInfoLabel, pickerView, resultLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        [transferCountryInfoLabel, receptionCountryInfoLabel, exchangeRateInfoLabel, viewTimeInfoLabel, transferInfoAmountLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            infoStackView.addArrangedSubview($0)
        }
        [transferCountryTitleLabel, receptionCountryTitleLabel, exchangeRateTitleLabel, viewTimeTitleLabel, transferTitleAmountTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            titleStackView.addArrangedSubview($0)
        }
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            infoStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30)
        ])
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            titleStackView.leadingAnchor.constraint(equalTo: infoStackView.trailingAnchor, constant: 5)
        ])
        NSLayoutConstraint.activate([
            transferTitleAmountTextField.widthAnchor.constraint(equalToConstant: 100)
        ])
        NSLayoutConstraint.activate([
            usdInfoLabel.leadingAnchor.constraint(equalTo: transferTitleAmountTextField.trailingAnchor, constant: 5),
            usdInfoLabel.centerYAnchor.constraint(equalTo: transferTitleAmountTextField.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            pickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            pickerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            pickerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            pickerView.heightAnchor.constraint(equalToConstant: 300)
        ])
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 40),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    private func setConfig() {
        view.backgroundColor = .white
    }
}
