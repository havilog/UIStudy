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
    
    // MARK: Constant
    
    enum Section: Hashable {
        case all
    }
    
    typealias PinterestDatasource = UICollectionViewDiffableDataSource<Section, Photo>
    typealias PinterestSnapshot = NSDiffableDataSourceSnapshot<Section, Photo>
    
    // MARK: Prop
    
    private var photos: [Photo] = Photo.allPhotos()
    
    // MARK: UI Prop
    
    private lazy var datasource: PinterestDatasource = PinterestDatasource(collectionView: collectionView) { collectionView, indexPath, photo in
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PinterestCell.reusableID, for: indexPath) as? PinterestCell else {
            preconditionFailure()
        }
        
        cell.bind(with: photo)
        
        return cell
    }
    
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
        applySnapshot()
    }
    
    private func setupUI() {
        view.backgroundColor = .yellow
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func applySnapshot() {
        var snapshot = PinterestSnapshot()
        snapshot.appendSections([.all])
        snapshot.appendItems(photos, toSection: .all)
        datasource.apply(snapshot, animatingDifferences: false)
    }
}

// 일반 데이터소스로 구현
//extension PinterestVC: UICollectionViewDataSource {
//
//    public func collectionView(
//        _ collectionView: UICollectionView,
//        numberOfItemsInSection section: Int
//    ) -> Int {
//        return photos.count
//    }
//
//    public func collectionView(
//        _ collectionView: UICollectionView,
//        cellForItemAt indexPath: IndexPath
//    ) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PinterestCell.reusableID, for: indexPath)
//        if let cell = cell as? PinterestCell {
//            cell.bind(with: photos[indexPath.item])
//        }
//        return cell
//    }
//
//}

extension PinterestVC: PinterestLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath: IndexPath
    ) -> CGFloat {
        return photos[indexPath.item].image.size.height
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
