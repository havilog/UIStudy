//
//  HVSegmentedControl.swift
//  TodayHouse
//
//  Created by 한상진 on 2021/08/10.
//

import UIKit

// MARK: Protocol

protocol HVSegmentedControlDelegate: AnyObject {
    func selectedButtonChanged(_ sender: UIButton)
}

// MARK: HVSegmentedControl

final class HVSegmentedControl: UIView {
    
    // MARK: Delegate
    
    weak var delegate: HVSegmentedControlDelegate?
    
    // MARK: UI Property
    
    private let stackView: UIStackView = .init().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    private lazy var buttons: [UIButton] = buttonTitles
        .enumerated()
        .map { index, title -> UIButton in
            return UIButton().then {
                $0.setTitle(title, for: .normal)
                $0.setTitleColor(textColor, for: .normal)
                $0.setTitleColor(highlightColor, for: .selected)
                $0.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
                $0.tag = index
            }
        }
    
    private lazy var highlightView: UIView = .init().then {
        $0.backgroundColor = highlightColor
    }
    
    // MARK: Property
    
    private let buttonTitles: [String]
    var textColor: UIColor = .brown
    var highlightColor: UIColor = .purple
    var selectedIndex: Int {
        didSet {
            self.changeSelectedButton(with: oldValue)
        }
    }
    
    // MARK: Init
    
    init(buttonTitles: [String]) {
        self.buttonTitles = buttonTitles
        self.selectedIndex = 0
        
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    
    private func setupUI() {
        self.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        buttons.forEach {
            stackView.addArrangedSubview($0)
        }

        self.addSubview(highlightView)
        highlightView.snp.makeConstraints {
            $0.height.equalTo(5)
            $0.bottom.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(buttons.count)
        }
    }
    
    // MARK: Method
    
    @objc private func buttonClicked(_ sender: UIButton) {
        changeSelectedButton(with: sender.tag)
        delegate?.selectedButtonChanged(sender)
    }
    
    private func changeSelectedButton(with index: Int) {
        buttons.forEach { $0.isSelected = false }
        
        guard let toSelectButton = buttons[safe: index] else { return }
        toSelectButton.isSelected = true
        
        let position = frame.width / CGFloat(buttons.count) * CGFloat(index)
        UIView.animate(withDuration: 0.3) {
            self.highlightView.frame.origin.x = position
        }
    }
}

public extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
