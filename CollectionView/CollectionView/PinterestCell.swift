//
//  PinterestCell.swift
//  Features
//
//  Created by 한상진 on 2021/07/08.
//  Copyright © 2021 softbay. All rights reserved.
//

import UIKit

final class PinterestCell: UICollectionViewCell {
    
    // MARK: Properties
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: UI
    
    private func setupUI() {
        contentView.backgroundColor = .white
    }
}

// MARK: Binds

extension PinterestCell {
    func bind(with something: String) {
        
    }
}

