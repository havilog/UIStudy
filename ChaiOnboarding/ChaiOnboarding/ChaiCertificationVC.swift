//
//  ChaiCertificationVC.swift
//  ChaiOnboarding
//
//  Created by 한상진 on 2021/07/19.
//

import UIKit

public final class ChaiCertificationVC: UIViewController {
    
    // MARK: UI Prop
    
    private let titleLabel: UILabel = .init().then {
        $0.text = "인증번호를\n입력해주세요"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.numberOfLines = 0
    }
    
    private let highlightView: UIView = .init().then {
        $0.backgroundColor = .clear
        
        $0.isUserInteractionEnabled = false
        
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = false
        
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 3
        
        $0.layer.shadowOpacity = 0.5
        $0.layer.shadowRadius = 3
        $0.layer.shadowOffset = .init(width: 1, height: 1)
    }
    
    private lazy var certificationTextField: ChaiTextFieldView = .init(
        sectionType: .certification,
        text: "인증번호"
    ).then {
        $0.delegate = self
    }
    
    // MARK: Init
    
    // MARK: Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        certificationTextField.startTimer()
    }
    
    // MARK: UI
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            $0.leading.equalToSuperview().offset(30)
        }
        
        view.addSubview(certificationTextField)
        certificationTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(80)
        }
        
        view.addSubview(highlightView)
        highlightView.snp.makeConstraints {
            $0.edges.equalTo(certificationTextField)
        }
    }
    
}

extension ChaiCertificationVC: ChaiTextFieldDelegate {
    func textChanged(sectionType: ChaiOnboardSection, text: String?) {
        
    }
    
    func textFieldBecomeFirstResponder(sectionType: ChaiOnboardSection) {
        
    }
}

// MARK: Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct ChaiCertificationVCRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ChaiCertificationVC {
        ChaiCertificationVC()
    }
    func updateUIViewController(_ uiViewController: ChaiCertificationVC, context: Context) {
    }
}
@available(iOS 13.0, *)
struct VCPreview: PreviewProvider {
    typealias Previews = ChaiCertificationVCRepresentable
    static var previews: Previews {
        return ChaiCertificationVCRepresentable()
    }
}
#endif
