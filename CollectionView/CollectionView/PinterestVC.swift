//
//  PinterestVC.swift
//  Features
//
//  Created by 한상진 on 2021/07/08.
//  Copyright © 2021 softbay. All rights reserved.
//

import UIKit
import SPMManager

import Then
import SnapKit

public final class PinterestVC: UIViewController {
    
    // MARK: Prop
    
    private var photos: [Photo] = Photo.allPhotos()
    
    // MARK: UI Prop
    
    private lazy var collectionView: UICollectionView = .init(
        frame: .zero,
        collectionViewLayout: collectionViewLayout
    ).then {
        if let pinterestLayout = $0.collectionViewLayout as? PinterestLayout {
            pinterestLayout.delegate = self
        }
        
        $0.register(PinterestCell.self, forCellWithReuseIdentifier: PinterestCell.reusableID)
        $0.contentInset = UIEdgeInsets(top: 23, left: 10, bottom: 10, right: 10)
    }
    
    private let collectionViewLayout: PinterestLayout = .init()
    
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
    
    private func setupUI() {
        view.backgroundColor = .yellow
    }
}

extension PinterestVC: PinterestLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath: IndexPath
    ) -> CGFloat {
        return 0
    }
}

// MARK: Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct PinterestVCRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> PinterestVC {
        PinterestVC()
    }
    func updateUIViewController(_ uiViewController: PinterestVC, context: Context) {
    }
}
@available(iOS 13.0, *)
struct PinterestVCPreview: PreviewProvider {
    typealias Previews = PinterestVCRepresentable
    static var previews: Previews {
        return PinterestVCRepresentable()
    }
}
#endif
