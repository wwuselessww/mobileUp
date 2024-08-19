//
//  FullImageViewController.swift
//  mobileUp
//
//  Created by Alexander Kozharin on 17.08.24.
//

import UIKit

class FullPhotoViewController: UIViewController {
    var imageView: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.contentMode = .scaleAspectFit
        return i
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(btnShareTapped))
        setupView()
        setupConstraints()
        view.backgroundColor = AppColors.background
        
    }
    
    func setupView() {
        view.addSubview(imageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc func btnShareTapped() {
        print("btnShareTapped")
        let activityVc = UIActivityViewController(activityItems: [imageView.image ?? .placeholder], applicationActivities: nil)
        activityVc.popoverPresentationController?.sourceView = self.view
        self.present(activityVc, animated: true)
    }
    
}
