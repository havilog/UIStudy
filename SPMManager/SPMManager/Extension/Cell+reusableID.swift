//
//  Cell+reusableID.swift
//  SPMManager
//
//  Created by 한상진 on 2021/07/08.
//

import UIKit

public protocol ReuseIdentifiable {
    static var reusableID: String { get }
}

public extension ReuseIdentifiable {
    static var reusableID: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifiable {}
extension UICollectionViewCell: ReuseIdentifiable {}
