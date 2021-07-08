//
//  PinterestLayout.swift
//  Features
//
//  Created by 한상진 on 2021/07/08.
//  Copyright © 2021 softbay. All rights reserved.
//

/// pinterest UI같은 경우 기존의 Flow Layout으로 구현하기에 어려움이 있다.
/// 따라서 다음 링크들을 참조하여 custom layout을 만든다.
/// https://linux-studying.tistory.com/23?category=410369
/// https://devmjun.github.io/archive/CollectionView-Pinterest
///

import UIKit

protocol PinterestLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView)
}
