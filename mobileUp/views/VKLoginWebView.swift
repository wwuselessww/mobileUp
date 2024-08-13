//
//  VKLoginWebView.swift
//  mobileUp
//
//  Created by Alexander Kozharin on 13.08.24.
//

import UIKit
import WebKit

class VKLoginWebView: UIViewController, WKNavigationDelegate {
    var webview: WKWebView!
    
    override func loadView() {
        super.loadView()
        webview = WKWebView()
        webview.navigationDelegate = self
        view = webview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://google.com")!
        webview.load(URLRequest(url: url))
        webview.allowsBackForwardNavigationGestures = true
    }
}
