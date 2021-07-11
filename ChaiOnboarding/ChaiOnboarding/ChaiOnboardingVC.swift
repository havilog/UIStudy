//
//  ChaiOnboardingVC.swift
//  ChaiOnboarding
//
//  Created by 한상진 on 2021/07/05.
//

import UIKit

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
        $0.spacing = 5
    }
    
    private lazy var phoneTextFieldView: ChaiTextFieldView = .init(
        text: "휴대폰번호", 
        isHighlighted: true
    ).then {
        $0.delegate = self
    }
    
    private lazy var residentTextFieldView: ChaiTextFieldView = .init(
        text: "주민등록번호",
        isHighlighted: true
    ).then {
        $0.delegate = self
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
}

// MARK: Setup UI

extension ChaiOnboardingVC {
    private func setupUI() {
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
        
        stackView.addArrangedSubview(phoneTextFieldView)
        phoneTextFieldView.snp.makeConstraints {
            $0.height.equalTo(70)
        }
    }
}

extension ChaiOnboardingVC: ChaiTextFieldDelegate {
    func textChanged(text: String?) {
        print(text)
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
