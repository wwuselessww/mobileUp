//
//  VideoCell.swift
//  mobileUp
//
//  Created by Alexander Kozharin on 18.08.24.
//

import UIKit

class VideoCell: UICollectionViewCell {
    static let identifier = "VideoCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.backgroundColor = .red
    }
    
    func setupConstraints() {
        
    }
}
