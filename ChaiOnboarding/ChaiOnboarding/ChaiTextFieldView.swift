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
    
    private let timer: ChaiTimerProgressView = .init(frame: .zero)
    
    private let timeLabel: UILabel = .init().then {
        $0.text = "3:00"
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
        
        if self.sectionType == .certification {
            self.addSubview(timer)
            timer.snp.makeConstraints {
                $0.trailing.top.bottom.equalToSuperview().inset(10)
                $0.width.equalTo(timer.snp.height)
            }
            
            self.addSubview(timeLabel)
            timeLabel.snp.makeConstraints {
                $0.center.equalTo(timer)
            }
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
    
    func startTimer(duration: TimeInterval = 180) {
        var time = duration
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            time -= 1
            self.timeLabel.text = self.timeToText(sec: Int(time))
            if time == 0 { timer.invalidate() }
        }
        self.timer.progressAnimation(duration: duration)
    }
    
    private func timeToText(sec: Int) -> String {
        let minute = (sec % 3600) / 60
        let second = (sec % 3600) % 60
        
        if second < 10 {
            return String(minute) + ":0" + String(second)
        } else {
            return String(minute) + ":" + String(second)
        }
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
