//
//  ChaiOnboardingVC.swift
//  ChaiOnboarding
//
//  Created by 한상진 on 2021/07/05.
//

import UIKit
import SPMManager
import HVBottomSheet

import Then
import SnapKit

public final class ChaiOnboardingVC: UIViewController {

    // MARK: UI Property
    
    private let confirmButton: UIButton = .init().then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setBackgroundColor(.systemGray4, for: .disabled)
        $0.setBackgroundColor(.black, for: .normal)
        $0.isEnabled = false
        $0.isHidden = true
        $0.addTarget(self, action: #selector(pushToCertification), for: .touchUpInside)
    }
    
    private let titleLabel: UILabel = .init().then {
        $0.text = "휴대폰 번호를\n입력해주세요"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.numberOfLines = 0
    }
    
    private let stackView: UIStackView = .init().then {
        $0.axis = .vertical
        $0.spacing = 10
    }
    
    private lazy var highlighView: UIView = .init().then {
        $0.backgroundColor = .clear
        
        $0.isUserInteractionEnabled = false
        
        $0.layer.cornerRadius = 15
        
//        $0.clipsToBounds = true
        $0.layer.masksToBounds = false
        
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 3
        
        $0.layer.shadowOpacity = 0.5
        $0.layer.shadowRadius = 3
        $0.layer.shadowOffset = .init(width: 1, height: 1)
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
        
        setPhoneNumberFirstResponder()
    }
}

// MARK: Setup UI

extension ChaiOnboardingVC {
    private func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.backgroundColor = .systemGray6
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            $0.leading.equalToSuperview().offset(30)
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        stackView.addArrangedSubview(nameTextFieldView)
        nameTextFieldView.snp.makeConstraints {
            $0.height.equalTo(80)
        }
        
        stackView.addArrangedSubview(telecomTextFieldView)
        telecomTextFieldView.snp.makeConstraints {
            $0.height.equalTo(80)
        }
        
        stackView.addArrangedSubview(residentTextFieldView)
        residentTextFieldView.snp.makeConstraints {
            $0.height.equalTo(80)
        }
        
        stackView.addArrangedSubview(phoneTextFieldView)
        phoneTextFieldView.snp.makeConstraints {
            $0.height.equalTo(80)
        }
        
        view.addSubview(highlighView)
        highlighView.snp.makeConstraints {
            $0.edges.equalTo(phoneTextFieldView)
        }
        
        view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.height.equalTo(50)
        }
    }
    
    private func setPhoneNumberFirstResponder() {
        phoneTextFieldView.customBecomeFirstResponder()
    }
    
    @objc private func pushToCertification() {
        let vc = ChaiCertificationVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ChaiOnboardingVC: ChaiTextFieldDelegate {
    /// ChaiTextField에서 Validation 검사를 한 뒤에 알맞은 text를 return시키게 하면 될 듯..?
    func textChanged(sectionType: ChaiOnboardSection, text: String?) {
        guard let text = text else { return }
        switch sectionType {
        case .phone:
            guard text.count == 11 else { return }
            
            view.endEditing(true)
            residentTextFieldView.customBecomeFirstResponder()
            UIView.animate(withDuration: 0.3) {
                self.residentTextFieldView.isHidden = false
                self.titleLabel.text = "주민번호 앞 7자리를\n입력해주세요"
            }
        case .residentNumber:
            guard text.count == 7 else { return }
            
            view.endEditing(true)
            self.telecomTextFieldView.customBecomeFirstResponder()
            UIView.animate(withDuration: 0.3) {
                self.telecomTextFieldView.isHidden = false
                self.titleLabel.text = "통신사를\n선택해주세요"
            }
        case .telecom:
            view.endEditing(true)
            print(text)
        case .name:
            print(text)
        case .certification:
            print(text)
        }
    }
    
    func textFieldBecomeFirstResponder(sectionType: ChaiOnboardSection) {
        switch sectionType {
        case .phone:
            UIView.animate(withDuration: 0.3) {
                self.highlighView.snp.remakeConstraints {
                    $0.edges.equalTo(self.phoneTextFieldView)
                }
            }
        case .residentNumber:
            UIView.animate(withDuration: 0.3) {
                self.highlighView.snp.remakeConstraints {
                    $0.edges.equalTo(self.residentTextFieldView)
                }
            }
        case .telecom:
            view.endEditing(true)
            UIView.animate(withDuration: 0.3) {
                self.highlighView.snp.remakeConstraints { // prepareConstraints
                    $0.edges.equalTo(self.telecomTextFieldView)
                }
                
                let bottomSheet = ChaiTelecomBottomSheetVC(heightRatio: .half, hideDragView: false)
                bottomSheet.delegate = self
                self.present(bottomSheet, animated: true)
            }
        case .certification:
            break
        case .name:
            break
        }
        
    }
}

extension ChaiOnboardingVC: ChaiTelecomBottomSheetDelegate {
    func telecomSelected(text: String) {
        telecomTextFieldView.setTextToTextField(with: text)
        confirmButton.isHidden = false
        confirmButton.isEnabled = true
    }
}

extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
         
        self.setBackgroundImage(backgroundImage, for: state)
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
