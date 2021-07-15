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
    
    weak var delegate: ChaiTextFieldDelegate?
    
    private lazy var textLabel: UILabel = .init().then {
        $0.text = "\(self.text)"
        $0.textColor = .systemGray
        $0.font = .systemFont(ofSize: 14)
    }
    
    private lazy var textfield: UITextField = .init().then {
        $0.tintColor = .systemRed
        $0.delegate = self
        $0.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
//        $0.addTarget(self, action: #selector(textFieldBecomeFirstResponder(_:)), for: .editingDidBegin)
        if self.sectionType == .residentNumber || self.sectionType == .phone {
            $0.keyboardType = .numberPad
        }
    }
    
    init(
        frame: CGRect = .zero,
        sectionType: ChaiOnboardSection,
        text: String
    ) {
        self.sectionType = sectionType
        self.text = text
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
        
        self.addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(15)
        }
        
        self.addSubview(textfield)
        textfield.snp.makeConstraints {
            $0.top.equalTo(textLabel).offset(5)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().offset(-5)
        }
    }
    
    @objc func textDidChanged(_ sender: UITextField) {
        delegate?.textChanged(sectionType: self.sectionType, text: sender.text)
    }
    
    @objc func textFieldBecomeFirstResponder(_ sender: UITextField) {
        delegate?.textFieldBecomeFirstResponder(sectionType: self.sectionType)
    }
    
    func setTextToTextField(with text: String) {
        self.textfield.text = text
    }
}

protocol ChaiTextFieldDelegate: AnyObject {
    func textChanged(sectionType: ChaiOnboardSection, text: String?)
    func textFieldBecomeFirstResponder(sectionType: ChaiOnboardSection)
}

extension ChaiTextFieldView: UITextFieldDelegate {
    func customBecomeFirstResponder() {
        textfield.becomeFirstResponder()
    }
    
    func customResignFirstResponder() {
        textfield.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldBecomeFirstResponder(sectionType: self.sectionType)
    }
}
