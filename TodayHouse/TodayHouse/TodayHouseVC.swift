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
    
    private var currentPageNumber: Int = 0
    
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
    
    private lazy var segmentedControl: HVSegmentedControl = .init(
        buttonTitles: [
            "1",
            "2",
            "3",
            "4"
        ]
    ).then {
        $0.selectedIndex = self.currentPageNumber
        $0.delegate = self
    }
    
    private let todayViewControllers: [UIViewController] = [
        UIViewController().then { $0.view.backgroundColor = .red },
        UIViewController().then { $0.view.backgroundColor = .orange },
        UIViewController().then { $0.view.backgroundColor = .green },
        UIViewController().then { $0.view.backgroundColor = .yellow },
    ]
    
    private lazy var pageVC: UIPageViewController = .init(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal,
        options: nil
    ).then {
        $0.delegate = self
        $0.dataSource = self
        
        guard let firstVC = todayViewControllers.first else { return }
        $0.setViewControllers([firstVC], direction: .forward, animated: false)
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
        
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(searchTextField.snp.bottom)
            $0.height.equalTo(50)
        }
        
        view.addSubview(pageVC.view)
        pageVC.view.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom)
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension TodayHouseVC: UIPageViewControllerDelegate {
    public func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
//        let test = pageViewController.viewControllers?[0] as? TodayHouseVC
//        segmentedControl.selectedIndex
    }
}

extension TodayHouseVC: UIPageViewControllerDataSource {
    public func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let currentIndex = todayViewControllers.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = currentIndex - 1
        
//        print("previous", previousIndex, currentIndex)
//        segmentedControl.selectedIndex = currentIndex
        return previousIndex < 0 ? todayViewControllers.last : todayViewControllers[previousIndex]
    }
    
    public func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let currentIndex = todayViewControllers.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = currentIndex + 1
        
//        print("next" , nextIndex, currentIndex)
//        segmentedControl.selectedIndex = currentIndex
        
        return nextIndex >= todayViewControllers.count ? todayViewControllers.first : todayViewControllers[nextIndex]
    }
}


extension TodayHouseVC: HVSegmentedControlDelegate {
    func selectedButtonChanged(_ sender: UIButton) {
        guard let vc = todayViewControllers[safe: sender.tag] else { return }
        
        pageVC.setViewControllers(
            [vc],
            direction: currentPageNumber < sender.tag ? .forward : .reverse,
            animated: true
        )
        
        currentPageNumber = sender.tag
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
