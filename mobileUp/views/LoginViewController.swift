//
//  ViewController.swift
//  mobileUp
//
//  Created by Alexander Kozharin on 13.08.24.
//

import UIKit
import WebKit

class LoginViewController: UIViewController, VKLoginDelegate {
    
    lazy var vkLoginWebView = VKLoginWebView()
    lazy var mainVC = MainViewController()
    
    var vm = LoginViewModel()
    var lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Mobile Up Gallery"
        lbl.font = .systemFont(ofSize: 44, weight: UIFont.Weight(400))
        lbl.numberOfLines = 2
        lbl.textColor = AppColors.lblColor
        return lbl
    }()
    var isLoginIn: Bool = false
    var btnLogin : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = AppColors.btnLogin
        btn.setTitleColor(AppColors.btnLoginLbl, for: .normal)
        btn.setTitle("Вход через VK", for: .normal)
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            isLoginIn = await vm.checkToken()
            checkIfLogin(loginState: isLoginIn)
        }
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        view.backgroundColor = AppColors.background
        view.addSubview(lblTitle)
        view.addSubview(btnLogin)
        btnLogin.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            lblTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 126),
            lblTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            lblTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -124),
            lblTitle.heightAnchor.constraint(equalToConstant: 106),
            
            btnLogin.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 8),
            btnLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            btnLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            btnLogin.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    @objc func btnTapped() {
        do {
            let data = try KeychainManager.fetch(service: KeychainCreds.service, account: KeychainCreds.account)
            
            vkLoginWebView.vkDelegate = self
            if let data = data {
                print(String(decoding: data, as: UTF8.self))
                if let navigationController = navigationController {
                    let mainVC = MainViewController()
                    print("ada")
                    navigationController.pushViewController(mainVC, animated: true)
                }
            } else {
                navigationController?.present(vkLoginWebView, animated: true)
            }
        } catch {
            print(error)
        }
    }
    func didDismiss() {
        print("didDismiss")
        if let navigationController = navigationController {
            
            navigationController.pushViewController(mainVC, animated: true)
        }
    }
    
    func checkIfLogin(loginState: Bool) {
        if loginState {
            navigationController?.pushViewController(mainVC, animated: true)
        }
    }
    
}

