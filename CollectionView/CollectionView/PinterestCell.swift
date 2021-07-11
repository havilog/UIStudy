//
//  PinterestCell.swift
//  Features
//
//  Created by 한상진 on 2021/07/08.
//  Copyright © 2021 softbay. All rights reserved.
//

import UIKit

final class PinterestCell: UICollectionViewCell {
    
    // MARK: UI Properties
    
    private let imageView: UIImageView = .init()
    private let captionLabel: UILabel = .init()
    private let commentLabel: UILabel = .init()
    
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
        contentView.backgroundColor = .systemGreen
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
        }
        
        contentView.addSubview(captionLabel)
        captionLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(4)
        }
        
        contentView.addSubview(commentLabel)
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(captionLabel.snp.bottom).offset(2)
            $0.bottom.equalToSuperview().offset(-10)
            $0.leading.trailing.equalToSuperview().inset(4)
        }
    }
}

// MARK: Binds

extension PinterestCell {
    func bind(with photo: Photo) {
        imageView.image = photo.image
        captionLabel.text = photo.caption
        commentLabel.text = photo.comment
    }
}

