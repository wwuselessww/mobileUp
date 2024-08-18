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
        videoCollectionView.register(VideoCell.self, forCellWithReuseIdentifier: VideoCell.identifier)
    }
    
    func setupCollectionView() {
        view.addSubview(photoCollectionView)
        view.addSubview(videoCollectionView)
        
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.prefetchDataSource = self
        photoCollectionView.backgroundColor = .clear
        photoCollectionView.layer.zPosition = 0
        setPhotoLayout()
        
        videoCollectionView.isHidden = true
        videoCollectionView.delegate = self
        videoCollectionView.dataSource = self
        videoCollectionView.prefetchDataSource = self
        videoCollectionView.backgroundColor = .clear
        videoCollectionView.layer.zPosition = 1
        setVideoLayout()
        
        registerCells()
        setupCollectionViewConstraints()
    }
    
    private func setupCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            photoCollectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
            photoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            videoCollectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
            videoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            videoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == photoCollectionView {
            return vm.photoArr.count
        }
        return vm.videoArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == photoCollectionView{
            
            guard let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else {fatalError("no cells")}
            
            cell.contentView.backgroundColor = .orange
            Task {
                cell.backgroundImage.image = await self.vm.getPhoto(urlString: Array(self.vm.photoArr.values)[indexPath.item])
            }
            return cell
            
        } else {
            guard let cell = videoCollectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.identifier, for: indexPath) as? VideoCell else {fatalError("no cells")}
            cell.contentView.backgroundColor = .green
            Task {
//                cell.backgroundImageView.image = await self.vm.getPhoto(urlString: vm.videoArr[indexPath.item])
                cell.backgroundImageView.image = await self.vm.getPhoto(urlString: Array(vm.videoArr.values)[indexPath.item])
                cell.lblTitle.text = Array(vm.videoArr.keys)[indexPath.item]
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for i in indexPaths {
//            Task {
//                await vm.cachedImages.setObject( vm.getPhoto(urlString: vm.photoArr[i.row]), forKey: vm.photoArr[i.row] as NSString)
//
//            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == photoCollectionView {
            var fullPhotoVC = FullImageViewController()
            Task {
                fullPhotoVC.imageView.image = await vm.getPhoto(urlString: Array(vm.photoArr.values)[indexPath.item])
            }
            fullPhotoVC.title = Array(vm.photoArr.keys)[indexPath.item]
            navigationItem.backButtonDisplayMode = .minimal
            navigationController?.pushViewController(fullPhotoVC, animated: true)
        } else {
            var fullVideoVC = VideoViewController()
            Task {
//                fullVideoVC.imageView.image = await vm.getPhoto(urlString: vm.photoArr[indexPath.item])
            }
            
            fullVideoVC.title = Array(vm.videoArr.keys)[indexPath.item]
            print(Array(vm.videoArr.keys)[indexPath.item])
            navigationItem.backButtonDisplayMode = .minimal
            navigationController?.pushViewController(fullVideoVC, animated: true)
            
        }
        
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
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        videoCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    
    
    
    
}
