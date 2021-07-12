//
//  HVBottomSheetVC.swift
//  HVBottomSheet
//
//  Created by 한상진 on 2021/07/09.
//

import UIKit

public final class HVBottomSheetVC: UIViewController {
    
    // MARK: Contant
    
    enum SheetViewState {
        case normal
        case expanded
        case dismiss
    }
    
    // MARK: Property
    
    private var cardViewHeightConstraint: NSLayoutConstraint?
    private var currentHeight: CGFloat?
    
    // MARK: UI Property
    
    private lazy var dragGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragIndicatorMoved(_:)))
    
    private lazy var dragIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.alpha = 0
        view.addGestureRecognizer(self.dragGesture)
        return view
    }()
    
    private lazy var dimmerViewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.changeState(at: .dismiss)))
    
    private lazy var dimmerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        view.backgroundColor = .systemGray.withAlphaComponent(0.7)
        view.addGestureRecognizer(self.dimmerViewTapGesture)
        return view
    }()
    
    private let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    // MARK: Init
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: LifeCycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showBottomSheet()
    }
    
    // MARK: UI
    
    private func setupUI() {
        view.backgroundColor = .clear
        setupDimmerView()
        setupCardView()
        setupDragIndicatorView()
    }
    
    private func setupDimmerView() {
        view.addSubview(dimmerView)
        NSLayoutConstraint.activate([
            dimmerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmerView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    private func setupDragIndicatorView() {
        view.addSubview(dragIndicatorView)
        NSLayoutConstraint.activate([
            dragIndicatorView.widthAnchor.constraint(equalToConstant: 50),
            dragIndicatorView.heightAnchor.constraint(equalToConstant: dragIndicatorView.layer.cornerRadius * 2),
            dragIndicatorView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            dragIndicatorView.bottomAnchor.constraint(equalTo: cardView.topAnchor, constant: -10)
        ])
    }
    
    private func setupCardView() {
        view.addSubview(cardView)
        
        cardViewHeightConstraint = cardView.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cardViewHeightConstraint ?? cardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func showBottomSheet() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height / 2
        let bottomPadding = view.safeAreaInsets.bottom
        cardViewHeightConstraint?.constant = safeAreaHeight + bottomPadding
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.dragIndicatorView.alpha = 1
            self.dimmerView.alpha = 0.7
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: Method

extension HVBottomSheetVC {
    @objc private func changeState(at state: HVBottomSheetVC.SheetViewState = .normal) {
        switch state {
        case .normal:
            break
        case .expanded:
            break
        case .dismiss:
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                self.cardViewHeightConstraint?.constant = 0
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.dismiss(animated: false)
            }
        }
    }
    
    @objc private func dragIndicatorMoved(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        
        switch recognizer.state {
        case .began:
            self.currentHeight = self.cardViewHeightConstraint?.constant
            
        case .changed:
            guard let currentHeight = self.currentHeight else { break }
            if self.currentHeight ?? 0 + translation.y > 30 {
                print("true")
            }
            self.cardViewHeightConstraint?.constant = currentHeight - translation.y
            
        case .ended:
//            guard let currentHeight = self.currentHeight,
//                  let changedHeight = self.cardViewHeightConstraint?.constant
//            else { break }
//            let diffHeight = currentHeight - changedHeight // 400 - 100
//            let quarterHeight = self.view.frame.height
//            
//            if diffHeight > quarterHeight {
//                self.dismiss(animated: false)
//            } else if diffHeight < -quarterHeight {
//                self.cardViewHeightConstraint?.constant = self.view.frame.height
//            }
        default:
            break
        }
    }
    
    @objc private func dimmerViewTapped() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.cardViewHeightConstraint?.constant = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
}

// MARK: Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct VCRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> HVBottomSheetVC {
        HVBottomSheetVC()
    }
    func updateUIViewController(_ uiViewController: HVBottomSheetVC, context: Context) {
    }
}
@available(iOS 13.0, *)
struct VCPreview: PreviewProvider {
    typealias Previews = VCRepresentable
    static var previews: Previews {
        return VCRepresentable()
    }
}
#endif
