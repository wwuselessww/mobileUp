//
//  MainViewController.swift
//  mobileUp
//
//  Created by Alexander Kozharin on 13.08.24.
//

import UIKit

class MainViewController: UIViewController {
    var vm = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationControls()
        setupView()
        Task {
            await vm.getFullInfo()
        }
    }
    
    func setupView() {
        view.backgroundColor = .red
    }
    
    func setupNavigationControls() {
        navigationItem.title = "MobileUp Gallery"
        let btnLogout = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(btnLogoutTapped))
        navigationItem.rightBarButtonItem = btnLogout
    }
    
    @objc func btnLogoutTapped() {
        print("btnTapped")
        navigationController?.popViewController(animated: true)

    }
}
