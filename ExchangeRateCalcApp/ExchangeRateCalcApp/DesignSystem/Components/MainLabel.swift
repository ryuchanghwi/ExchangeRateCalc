//
//  MainLabel.swift
//  ExchangeRateCalcApp
//
//  Created by 류창휘 on 1/22/24.
//

import Foundation
import UIKit

/*
 비슷한 컴포넌트들은 다음과 같이 묶어 바로 사용할 수 있도록 만듦
 
 enum을 통해 케이스와 연관값으로 구성
 */

enum MainLabelTypes {
    case title(text: String)
    case content(text: String)
    case result(text: String)
}

/*
 클래스 안의 모든 프로퍼티는 초기 값을 가지고 있어야함
 때문에 init전에 초기값을 채워줌
 그리고 초기화 진행
 
 1단계 초기화 - 초기값을 갖지 않는 프로퍼티에 한해서 초기값을 지정해주고,
 부모 클래스의 생성자를 호출
 2단계 초기화 - init이후 인스턴스가 생성되기 떄문에 init 다음으로 호출할 수 있음
 부모의 초기화에 의해 자식의 초기화가 덮어지는 것을 막을 수 있음
 */
final class MainLabel: UILabel {
    private let types: MainLabelTypes
    init(types: MainLabelTypes) {
        self.types = types
        super.init(frame: .zero) // 부모 클래스의 init을 완성시켜줌
        setup() // 내부에 있기 떄문에 init 아래에?
    }
    /*
     서브 클래스에서 반드시 구현해야 하는 생성자의 경우
     슈퍼 클래스에서 required init으로 설정
     NSCoding이라는 프로토콜 때문에
     UI를 만들때 스토리보드나 Xib 형태로 만들 때
     화면으로 가져오는 역할을 하는 것이 NSCoder
     */
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
        case .result(text: let text):
            textColor = .black
            font = .systemFont(ofSize: 20)
            self.text = text
        }
    }
}
