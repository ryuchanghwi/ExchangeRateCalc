//
//  MainLabel.swift
//  ExchangeRateCalcApp
//
//  Created by 류창휘 on 1/22/24.
//

import Foundation
import UIKit

enum MainLabelTypes {
    case title(text: String)
    case content(text: String)
}

final class MainLabel: UILabel {
    private let types: MainLabelTypes
    init(types: MainLabelTypes) {
        self.types = types
        super.init(frame: .zero)
        setup()
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setup() {
        switch types {
        case .title(let text):
            textAlignment = .center
            textColor = .black
            font = .systemFont(ofSize: 40)
            self.text = text
        case .content(let text):
            textColor = .black
            font = .systemFont(ofSize: 16)
            self.text = text
        }
    }
}
