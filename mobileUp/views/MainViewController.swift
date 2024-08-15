//
//  MainViewController.swift
//  mobileUp
//
//  Created by Alexander Kozharin on 13.08.24.
//

import UIKit

class MainViewController: UIViewController {
    var vm = MainViewModel()
    var segmentedControl = UISegmentedControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationControls()
        setupView()
        setupConstraints()
        Task {
            await vm.getFullInfo()
        }
    }
    
    func setupView() {
        view.backgroundColor = AppColors.background
        let newAction = UIAction(title: "Фото", handler: { _ in print("photo selected") })
        let newAction2 = UIAction(title: "Видео", handler: { _ in print("video selected") })
        segmentedControl = UISegmentedControl(frame: .zero, actions: [newAction, newAction2])
        view.addSubview(segmentedControl)
        

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
    
    func setupNavigationControls() {
        navigationItem.title = "MobileUp Gallery"
        let btnLogout = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(btnLogoutTapped))
        navigationItem.rightBarButtonItem = btnLogout
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
