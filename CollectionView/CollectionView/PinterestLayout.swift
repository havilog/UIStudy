//
//  PinterestLayout.swift
//  Features
//
//  Created by 한상진 on 2021/07/08.
//  Copyright © 2021 softbay. All rights reserved.
//

import UIKit

/// pinterest UI같은 경우 기존의 Flow Layout으로 구현하기에 어려움이 있다.
/// 따라서 다음 링크들을 참조하여 custom layout을 만든다.
/// https://linux-studying.tistory.com/23?category=410369
/// https://devmjun.github.io/archive/CollectionView-Pinterest

protocol PinterestLayoutDelegate: AnyObject {
    /// collection view의 높이가 컨텐츠의 높이에 따라 달라지기 때문에 동적으로 계산해야하므로 선언
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}

final class PinterestLayout: UICollectionViewLayout {
    
    // MARK: Property
    
    /// 높이를 결정할 delegate
    weak var delegate: PinterestLayoutDelegate?
    
    /// collectionView의 열과 padding
    private var numberOfColums: Int = 2
    private var cellPadding: CGFloat = 6
    
    /// content size를 저장하기 위한 속성들
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    /// 연산된 property를 캐시하기 위한 배열
    /// prepare 시점에서 계산된 아이템의 속성을 캐시에 추가하고 효율적으로 연산
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    /// 보이는 contents 뿐만 아니라 전체 content의 width와 height 결정
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    /// layout 연산이 발생할 때마다 호출.
    /// 아이템의 위치, collectionview의 사이즈 등을 결정
    override func prepare() {
        /// cache가 비어있고, collectionView가 있을 때만 연산 진행
        guard let collectionView = collectionView,
              let delegate = delegate,
              cache.isEmpty
        else {
            return
        }
        
        /// xoffset은 정해져있기 때문에 배열을 채우고 시작, yoffset은 0
        let columnWidth: CGFloat = contentWidth / CGFloat(numberOfColums)
        var xOffset: [CGFloat] = []
        for column in 0..<numberOfColums {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset: [CGFloat] = Array(repeating: 0, count: numberOfColums)
        
        /// 단일 섹션일 경우 모든 아이템 반복
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            /// frame 계산 수행
            let photoHeight = delegate.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath)
            let height = (cellPadding * 2) + photoHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            ///instance 생성, 캐시 추가
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] += height
            
            column = column < (numberOfColums - 1) ? (column + 1) : 0
        }
    }
    
    /// 주어진 범위 내에 모든 아이템의 레이아웃 속성을 반환
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    /// 요구한 레이아웃 정보를 제공
    /// 반드시 override해야하고, 요청한 indexpath의 아이템을 반환
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
