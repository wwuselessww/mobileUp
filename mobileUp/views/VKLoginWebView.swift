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
        let appID = "51640152"
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "oauth.vk.com"
        urlComponent.path = "/authorize"
        
        urlComponent.queryItems = [
            URLQueryItem(name: "client_id", value: appID),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "response_type", value: "token"),
        ]

        guard let url = urlComponent.url else {fatalError("no url")}
        webview.load(URLRequest(url: url))
        webview.allowsBackForwardNavigationGestures = true
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html" else {
            decisionHandler(.allow)
            return
        }
        var token = ""
        if let params = url.fragment?.components(separatedBy: "&").map({$0.components(separatedBy: "=")}) {
            for index in params.enumerated() {
                if index.element.first == "access_token" {
                    token = index.element.last ?? "no token"
                }
            }
        } else {
            token = "no token"
        }
            print(token)
        decisionHandler(.cancel)
    }
}
