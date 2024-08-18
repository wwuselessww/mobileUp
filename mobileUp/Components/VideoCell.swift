//
//  VideoCell.swift
//  mobileUp
//
//  Created by Alexander Kozharin on 18.08.24.
//

import UIKit

class VideoCell: UICollectionViewCell {
    static let identifier = "VideoCell"
    private let innerHorrisontalPadding:CGFloat = 12
    private let innerVerticalPadding:CGFloat = 4
    
    var backgroundImageView: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFill
        v.layer.masksToBounds = true
        return v
    }()
    
    var lblTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.layer.masksToBounds = true
        l.textColor = .black
        l.layer.cornerRadius = 12
        l.text = "alkdnma;ldna;l"
        return l
    }()
    
    let blurView: UIView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let v = UIVisualEffectView(effect: blurEffect)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 16
        v.clipsToBounds = true
        return v
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(lblTitle)
        contentView.addSubview(blurView)
        contentView.bringSubviewToFront(lblTitle)

        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            lblTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16 - innerHorrisontalPadding),
            lblTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16 - innerHorrisontalPadding),
            
            blurView.topAnchor.constraint(equalTo: lblTitle.topAnchor, constant: -1 * innerVerticalPadding),
            blurView.bottomAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: innerVerticalPadding),
            blurView.trailingAnchor.constraint(equalTo: lblTitle.trailingAnchor, constant: innerHorrisontalPadding),
            blurView.leadingAnchor.constraint(equalTo: lblTitle.leadingAnchor, constant: -1 * innerHorrisontalPadding),
        ])
    }
}
