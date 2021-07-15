//
//  TelecomBottomSheetVC.swift
//  ChaiOnboarding
//
//  Created by 한상진 on 2021/07/15.
//

import UIKit
import HVBottomSheet

protocol ChaiTelecomBottomSheetDelegate: AnyObject {
    func telecomSelected(text: String)
}

final class ChaiTelecomBottomSheetVC: HVBottomSheetVC {
    fileprivate enum Telecom: String, CaseIterable {
        case skt = "SKT"
        case kt = "KT"
        case lg = "LG U+"
        case sktCheap = "SKT 알뜰폰"
        case ktCheap = "KT 알뜰폰"
        case lgCheap = "LG U+ 알뜰폰"
    }
    
    weak var delegate: ChaiTelecomBottomSheetDelegate?
    
    private let stackView: UIStackView = .init().then {
        $0.spacing = 0
        $0.axis = .vertical
        $0.alignment = .fill
    }
    
    private let topView: UIView = .init().then {
        $0.backgroundColor = .black
    }
    
    private let titleLabel: UILabel = .init().then {
        $0.text = "통신사 선택"
        $0.textColor = .white
        $0.font = .boldSystemFont(ofSize: 15)
    }
    
    private let closeButton: UIButton = .init().then {
        let title = NSAttributedString(string: "닫기", attributes: [.font: UIFont.systemFont(ofSize: 15)])
        $0.setTitleColor(.systemGray, for: .normal)
        $0.setAttributedTitle(title, for: .normal)
        $0.addTarget(self, action: #selector(hideCardViewAndDismiss), for: .touchUpInside)
    }
    
    override func setupUI() {
        super.setupUI()
        
        cardView.backgroundColor = .black.withAlphaComponent(0.9)
        
        cardView.addSubview(topView)
        topView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        topView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(30)
            $0.centerY.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.5)
        }
        
        topView.addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-30)
            $0.centerY.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.4)
        }
        
        cardView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(topView.snp.bottom).offset(30)
        }
        
        Telecom.allCases.forEach { telecom in
            let button = UIButton()
            button.setTitle(telecom.rawValue, for: .normal)
            button.setTitleColor(.systemGray, for: .normal)
            button.contentHorizontalAlignment = .leading
            button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
            button.snp.makeConstraints {
                $0.height.equalTo(50)
            }
            stackView.addArrangedSubview(button)
        }
    }
    
    @objc private func buttonClicked(_ sender: UIButton) {
        delegate?.telecomSelected(text: sender.titleLabel?.text ?? "")
        hideCardViewAndDismiss()
    }
}
