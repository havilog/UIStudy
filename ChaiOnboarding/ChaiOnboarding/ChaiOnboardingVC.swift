//
//  ChaiOnboardingVC.swift
//  ChaiOnboarding
//
//  Created by 한상진 on 2021/07/05.
//

import UIKit
import SPMManager

import Then
import SnapKit

public final class ChaiOnboardingVC: UIViewController {

    // MARK: UI Property
    
    private let titleLabel: UILabel = .init().then {
        $0.text = "휴대폰 번호를\n입력해주세요"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.numberOfLines = 0
    }
    
    private let stackView: UIStackView = .init().then {
        $0.axis = .vertical
        $0.spacing = 10
    }
    
    private let highlighView: ChaiHighlightView = .init().then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 2    
    }
    
    private lazy var phoneTextFieldView: ChaiTextFieldView = .init(
        sectionType: .phone,
        text: "휴대폰번호"
    ).then {
        $0.delegate = self
    }
    
    private lazy var residentTextFieldView: ChaiTextFieldView = .init(
        sectionType: .residentNumber,
        text: "주민등록번호"
    ).then {
        $0.delegate = self
        $0.isHidden = true
    }
    
    private lazy var telecomTextFieldView: ChaiTextFieldView = .init(
        sectionType: .telecom,
        text: "통신사"
    ).then {
        $0.delegate = self
        $0.isHidden = true
    }
    
    private lazy var nameTextFieldView: ChaiTextFieldView = .init(
        sectionType: .name,
        text: "이름"
    ).then {
        $0.delegate = self
        $0.isHidden = true
    }
    
    // MARK: Init
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupHighlightView()
    }
}

// MARK: Setup UI

extension ChaiOnboardingVC {
    private func setupUI() {
//        view.backgroundColor = .systemGray.withAlphaComponent(0.2)
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalToSuperview().offset(30)
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        stackView.addArrangedSubview(nameTextFieldView)
        nameTextFieldView.snp.makeConstraints {
            $0.height.equalTo(70)
        }
        
        stackView.addArrangedSubview(telecomTextFieldView)
        telecomTextFieldView.snp.makeConstraints {
            $0.height.equalTo(70)
        }
        
        stackView.addArrangedSubview(residentTextFieldView)
        residentTextFieldView.snp.makeConstraints {
            $0.height.equalTo(70)
        }
        
        stackView.addArrangedSubview(phoneTextFieldView)
        phoneTextFieldView.snp.makeConstraints {
            $0.height.equalTo(70)
        }
    }
    
    private func setupHighlightView() {
        view.addSubview(highlighView)
        
        highlighView.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(stackView)
            $0.height.equalTo(70)
        }
    }
}

extension ChaiOnboardingVC: ChaiTextFieldDelegate {
    func textChanged(sectionType: ChaiOnboardSection, text: String?) {
        guard let text = text else { return }
        switch sectionType {
        case .phone:
            guard text.count == 11 else {
                return
            }
            
            UIView.animate(withDuration: 0.3) {
                self.residentTextFieldView.isHidden.toggle()
            }
        case .residentNumber:
            guard text.count == 7 else {
                return
            }
            
            UIView.animate(withDuration: 0.3) {
                self.telecomTextFieldView.isHidden.toggle()
            }
        case .telecom:
            print(text)
        case .name:
            print(text)
        case .certification:
            print(text)
        }
    }
}

// MARK: Preview

#if canImport(SwiftUI) && DEBUG

import SwiftUI

@available(iOS 13.0, *)
struct ChaiOnboardingVCRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ChaiOnboardingVC {
        ChaiOnboardingVC()
    }
    func updateUIViewController(_ uiViewController: ChaiOnboardingVC, context: Context) {
    }
}

@available(iOS 13.0, *)
struct ChaiOnboardingVCPreview: PreviewProvider {
    typealias Previews = ChaiOnboardingVCRepresentable
    static var previews: Previews {
        return ChaiOnboardingVCRepresentable()
    }
}

#endif
