//
//  ViewController.swift
//  mobileUp
//
//  Created by Alexander Kozharin on 13.08.24.
//

import UIKit
import WebKit

class LoginViewController: UIViewController, WKNavigationDelegate {
    
    var lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Mobile Up Gallery"
        lbl.font = .systemFont(ofSize: 44, weight: UIFont.Weight(400))
        lbl.numberOfLines = 2
        lbl.textColor = AppColors.lblColor
        return lbl
    }()
    
    var btnLogin : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = AppColors.btnLogin
        btn.setTitleColor(AppColors.btnLoginLbl, for: .normal)
        btn.setTitle("Вход через VK", for: .normal)
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    var webView: WKWebView!
    
    override func loadView() {
        super.loadView()
        webView = WKWebView()
        webView.navigationDelegate = self
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            let data = try KeychainManager.fetch(service: "mobileup", account: "useless")
            if let data = data {
                print(String(decoding: data, as: UTF8.self))
                if let navigationController = navigationController {
                    let mainVC = MainViewController()
                    print("ada")
                    navigationController.pushViewController(mainVC, animated: true)
                }
                
            } else {
                let vkLoginWebView = VKLoginWebView()
                present(vkLoginWebView, animated: true)
            }
        } catch {
            print(error)
        }
        
    }
    
    
}

