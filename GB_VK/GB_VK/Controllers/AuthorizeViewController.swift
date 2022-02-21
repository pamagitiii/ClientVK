//
//  AuthorizeViewController.swift
//  GB_VK
//
//  Created by Anatoliy on 19.11.2021.
//

import UIKit
import WebKit

class AuthorizeViewController: UIViewController {

    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
           
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openauthPage()
    }
    
    func openauthPage() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8004757"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "270342"), //262150
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
}

extension AuthorizeViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment
        else { decisionHandler(.allow)
            return }

        let params = fragment.components(separatedBy: "&").map { $0.components(separatedBy: "=") }.reduce([String: String]() ) {
            result, param in
            
            var dict = result
            let key = param[0]
            let value = param[1]
            dict[key] = value
            
            return dict
        }
        
        guard let token = params["access_token"] else { return }
        print("TOKEN is \(token)")
        Session.instance.token = token
        print(" ")
        guard let id = params["user_id"] else { return }
        print("USER ID is \(id)")
        Session.instance.userId = id
        
        
        decisionHandler(.cancel)
        
        self.performSegue(withIdentifier: "signedInSegue", sender: nil)
        
    }
}





//https://vk.com/dev/friends.get?params[user_id]=339996497&params[order]=name&params[count]=10&params[offset]=0&params[fields]=photo_100&params[v]=5.131


