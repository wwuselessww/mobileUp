//
//  MainVC+Bindings.swift
//  mobileUp
//
//  Created by Alexander Kozharin on 17.08.24.
//

import UIKit
import Combine

extension MainViewController {
    func setupBinders() {
        vm.$albumsArr.sink { [weak self] albums in
           print("array binded")
            DispatchQueue.main.async {
                self?.photoCollectionView.reloadData()
            }
            
        }
        .store(in: &cancellables)
        
        vm.$photoArr.sink {[weak self] photos in
            print("photos")
            DispatchQueue.main.async {
                self?.photoCollectionView.reloadData()
            }
        }
        .store(in: &cancellables)
        
        vm.$photoImagesArr.sink {[weak self] image in
            print("photos")
            DispatchQueue.main.async {
                self?.photoCollectionView.reloadData()
            }
        }
        .store(in: &cancellables)
        
        vm.$token.sink {[weak self] token in
            print("token binded")
        }
        .store(in: &cancellables)
        
        vm.$chosenCollection.sink {[weak self] collection in
            print("collection chosen")
            DispatchQueue.main.async {
                self?.photoCollectionView.reloadData()
            }
        }
        .store(in: &cancellables)
        
    }
}
