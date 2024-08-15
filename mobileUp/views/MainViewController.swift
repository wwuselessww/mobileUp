//
//  MainViewController.swift
//  mobileUp
//
//  Created by Alexander Kozharin on 13.08.24.
//

import UIKit

class MainViewController: UIViewController {
    
    var photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.translatesAutoresizingMaskIntoConstraints = false
        
        return c
    }()
    
    var vm = MainViewModel()
    var segmentedControl = UISegmentedControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationControls()
        setupView()
        setupCollectionView()
        Task {
            await vm.getFullInfo()
        }
    }
    
    func setupView() {
        view.backgroundColor = AppColors.background
        let segmentedItems = ["Фото", "Видео"]
        segmentedControl = UISegmentedControl(items: segmentedItems)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
        view.addSubview(segmentedControl)
        setupConstraints()
        
        
    }
    
    func setupConstraints() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    @objc func segmentedControlChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0 :
            //photo
            print("0")
        case 1 :
            //video
            print("1")
        default:
            print("default")
        }
    }
    
    func setupNavigationControls() {
        navigationItem.title = "MobileUp Gallery"
        let btnLogout = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(btnLogoutTapped))
        navigationItem.rightBarButtonItem = btnLogout
        navigationItem.hidesBackButton = true
    }
    
    @objc func btnLogoutTapped() {
        print("btnTapped")
        navigationController?.popViewController(animated: true)
        do {
            try KeychainManager.delete(service: KeychainCreds.service, account: KeychainCreds.account)
        } catch {
            print(error)
        }
        
    }
}
