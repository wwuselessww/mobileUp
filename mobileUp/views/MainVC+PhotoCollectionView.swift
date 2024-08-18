//
//  MainVC+PhotoCollectionView.swift
//  mobileUp
//
//  Created by Alexander Kozharin on 15.08.24.
//

import UIKit

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    
    
    private func registerCells() {
        photoCollectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        photoCollectionView.register(VideoCell.self, forCellWithReuseIdentifier: VideoCell.identifier)
    }
    
    func setupCollectionView() {
        view.addSubview(photoCollectionView)

        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.prefetchDataSource = self
        photoCollectionView.backgroundColor = .clear
        registerCells()
        setupCollectionViewConstraints()
    }
    
    private func setupCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            photoCollectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
            photoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.photoArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if vm.chosenCollection == .photo {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else {fatalError("no cells")}
            
            cell.contentView.backgroundColor = .orange
            Task {
                cell.backgroundImage.image = await self.vm.getPhoto(urlString: self.vm.photoArr[indexPath.item])
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.identifier, for: indexPath) as? VideoCell else {fatalError("no cells")}
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for i in indexPaths {
            Task {
                await vm.cachedImages.setObject( vm.getPhoto(urlString: vm.photoArr[i.row]), forKey: vm.photoArr[i.row] as NSString)

            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        var fullPhotoVC = FullImageViewController()
//        fullPhotoVC.title = 
        Task {
            fullPhotoVC.imageView.image = await vm.getPhoto(urlString: vm.photoArr[indexPath.item])
        }
        navigationController?.pushViewController(fullPhotoVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 30) / 2
        return CGSize(width: size, height: size)
    }
    
    
    func setPhotoLayout() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        photoCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func setVideoLayout() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        photoCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    
    
    
    
}
