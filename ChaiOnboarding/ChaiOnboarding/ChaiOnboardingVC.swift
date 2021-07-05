//
//  ChaiOnboardingVC.swift
//  ChaiOnboarding
//
//  Created by 한상진 on 2021/07/05.
//

import UIKit

public final class ChaiOnboardingVC: UIViewController {
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension ChaiOnboardingVC {
    private func setupUI() {
        view.backgroundColor = .yellow
    }
}
