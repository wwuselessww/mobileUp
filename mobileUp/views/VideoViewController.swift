//
//  VideoViewController.swift
//  mobileUp
//
//  Created by Alexander Kozharin on 18.08.24.
//

import UIKit
import WebKit

class VideoViewController: UIViewController, WKNavigationDelegate{
    var webView: WKWebView = {
        let v = WKWebView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    var linkToVideoPlayer = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        view.backgroundColor = .green
        navigationItem.backButtonDisplayMode = .minimal
        guard let url = URL(string: linkToVideoPlayer) else {fatalError("wrong link")}
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    func setupView() {
        view.addSubview(webView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    
    
    
    
}
