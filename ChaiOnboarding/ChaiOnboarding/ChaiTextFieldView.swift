//
//  ChaiTextFieldView.swift
//  ChaiOnboarding
//
//  Created by 한상진 on 2021/07/07.
//

import UIKit

enum ChaiOnboardSection {
    case phone
    case residentNumber
    case telecom
    case name
    case certification
}

final class ChaiTextFieldView: UIView {
    
    private let sectionType: ChaiOnboardSection
    private let text: String
//    var isHighlighted: Bool {
//        willSet {
//            if newValue == true {
//                UIView.animate(withDuration: 1) { 
//                    self.layer.borderColor = UIColor.black.cgColor
//                }
//            } else {
//                UIView.animate(withDuration: 1) { 
//                    self.layer.borderColor = UIColor.white.cgColor
//                }
//            }
//        }
//    }
    
    weak var delegate: ChaiTextFieldDelegate?
    
    // let으로 쓰고 싶은데 좋은 방법이 있을라나요?
    private lazy var textLabel: UILabel = .init().then {
        $0.text = "\(self.text)"
        $0.textColor = .systemGray
        $0.font = .systemFont(ofSize: 14)
    }
    
    private lazy var textfield: UITextField = .init().then {
        $0.tintColor = .systemRed
        $0.delegate = self
        $0.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
        if self.sectionType == .residentNumber || self.sectionType == .phone {
            $0.keyboardType = .numberPad
        }
    }
    
    init(
        frame: CGRect = .zero,
        sectionType: ChaiOnboardSection,
        text: String
//        isHighlighted: Bool = false
    ) {
        self.sectionType = sectionType
        self.text = text
//        self.isHighlighted = isHighlighted
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
//        self.layer.borderWidth = 2
        
        self.addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(10)
        }
        
        self.addSubview(textfield)
        textfield.snp.makeConstraints {
            $0.top.equalTo(textLabel).offset(5)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().offset(-5)
        }
    }
    
    @objc func textDidChanged(_ sender: UITextField) {
        delegate?.textChanged(sectionType: self.sectionType, text: sender.text)
    }
}

protocol ChaiTextFieldDelegate: AnyObject {
    func textChanged(sectionType: ChaiOnboardSection, text: String?)
}

extension ChaiTextFieldView: UITextFieldDelegate {
    
}
