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
    
    private let titleLabel: UILabel = .init().then {
        $0.text = "휴대폰 번호를\n입력해주세요"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.numberOfLines = 0
    }
    
    private let stackView: UIStackView = .init().then {
        $0.axis = .vertical
        $0.spacing = 10
    }
    
    private lazy var highlighView: ChaiHighlightView = .init().then {
        $0.backgroundColor = .clear
        
        $0.layer.cornerRadius = 15
        
        // TODO: 평소에 항상 clipToBounds = true로 잡아주고 썼었는데...
        // 이게 겹치는 경우가 있을거 같은데 ...?
//        $0.clipsToBounds = true
        $0.layer.masksToBounds = false
        
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 3
        
        /*
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(rect: $0.bounds).cgPath
        shadowLayer.fillColor = UIColor.darkGray.cgColor
        shadowLayer.shadowOffset = .zero
        shadowLayer.opacity = 0.5
        shadowLayer.cornerRadius = 3
        $0.layer.insertSublayer(shadowLayer, at: 0)
         */
        
        $0.layer.shadowOpacity = 0.5
        $0.layer.shadowRadius = 3
        $0.layer.shadowOffset = .init(width: 1, height: 1)
//        $0.layer.shadowColor = UIColor.darkGray.cgColor
        
        // TODO: shadow를 쓰려면 expensive하다는데..?
        // path를 쓰라는데 ..?
        // path를 쓰면 그림자가 안나옴 ..?
        // path는 어찌 쓰는거지 ㅇㅁㅇ..
//        $0.layer.shadowPath = UIBezierPath(rect: $0.bounds).cgPath
        
//        $0.layer.shouldRasterize = true // cache해서 다시 그리지 않게
// If you want to go down the rasterization route, you should make sure iOS caches the shadow at the same drawing scale as the main screen, otherwise it will look pixelated:
//        $0.layer.rasterizationScale = UIScreen.main.scale
    }
    
    // TODO: let으로 쓰고 싶은데, viewDidLoad에서 configure도 안하고 싶고,,
    // 좋은 방법이 있을라나요?
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
    }
    
    private func setPhoneNumberFirstResponder() {
        phoneTextFieldView.customBecomeFirstResponder()
    }
}

extension ChaiOnboardingVC: ChaiTextFieldDelegate {
    /// ChaiTextField에서 Validation 검사를 한 뒤에 알맞은 text를 return시키게 하면 될 듯..?
    func textChanged(sectionType: ChaiOnboardSection, text: String?) {
        guard let text = text else { return }
        switch sectionType {
        case .phone:
            guard text.count == 11 else {
                return
            }
            
            view.endEditing(true)
            residentTextFieldView.customBecomeFirstResponder()
            UIView.animate(withDuration: 0.3) {
                self.residentTextFieldView.isHidden = false
                self.titleLabel.text = "주민번호 앞 7자리를\n입력해주세요"
            }
        case .residentNumber:
            guard text.count == 7 else {
                return
            }
            
            view.endEditing(true)
            self.telecomTextFieldView.customBecomeFirstResponder()
            UIView.animate(withDuration: 0.3) {
                self.telecomTextFieldView.isHidden = false
                self.titleLabel.text = "통신사를\n선택해주세요"
            }
        case .telecom:
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
                self.view.layoutIfNeeded()
            }
            
            
        case .residentNumber:
            UIView.animate(withDuration: 0.3) {
                self.highlighView.snp.remakeConstraints {
                    $0.edges.equalTo(self.residentTextFieldView)
                }
                self.view.layoutIfNeeded()
            }
        case .telecom:
                    
            view.endEditing(true)
            
            UIView.animate(withDuration: 0.3) {
                self.highlighView.snp.remakeConstraints {
                    $0.edges.equalTo(self.telecomTextFieldView)
                }

                self.view.layoutIfNeeded()
                
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
