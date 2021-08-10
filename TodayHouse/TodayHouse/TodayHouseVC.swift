//
//  TodayHouseVC.swift
//  TodayHouse
//
//  Created by 한상진 on 2021/07/25.
//

import UIKit
import SPMManager

import SnapKit
import Then

public final class TodayHouseVC: UIViewController {
    
    // MARK: Property
    
    private lazy var searchTextField: THSearchTextField = .init().then {
        $0.delegate = self
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    
    private let markButton: UIButton = .init().then {
        $0.setImage(UIImage(systemName: "bookmark"), for: .normal)
        $0.contentMode = .scaleAspectFill
        $0.contentHorizontalAlignment = .fill
        $0.contentVerticalAlignment = .fill
        $0.tintColor = .gray
    }
    
    private let cartButton: UIButton = .init().then {
        $0.setImage(UIImage(systemName: "cart"), for: .normal)
        $0.contentMode = .scaleAspectFill
        $0.contentHorizontalAlignment = .fill
        $0.contentVerticalAlignment = .fill
        $0.tintColor = .gray
    }
    
    // MARK: Init
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(type(of: self), #function)
    }
    
    // MARK: LifeCycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(cartButton)
        cartButton.snp.makeConstraints {
            $0.top.right.equalTo(view.safeAreaLayoutGuide).inset(5)
            $0.size.equalTo(50)
        }
        
        view.addSubview(markButton)
        markButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(5)
            $0.right.equalTo(cartButton.snp.left)
            $0.size.equalTo(50)
        }
        
        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.right.equalTo(markButton.snp.left).offset(-10)
            $0.height.equalTo(50)
        }
        
    }
}

extension TodayHouseVC: UITextFieldDelegate {
    
}

// MARK: Preview

#if canImport(SwiftUI) && DEBUG

import SwiftUI

@available(iOS 13.0, *)
struct TodayHouseVCRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> TodayHouseVC {
        TodayHouseVC()
    }
    func updateUIViewController(_ uiViewController: TodayHouseVC, context: Context) {
    }
}

@available(iOS 13.0, *)
struct TodayHouseVCPreview: PreviewProvider {
    typealias Previews = TodayHouseVCRepresentable
    static var previews: Previews {
        return TodayHouseVCRepresentable()
    }
}

#endif
