//
//  AboutViewController.swift
//  BullsEye
//
//  Created by Viceconti Federico on 09/06/2019.
//  Copyright © 2019 Viceconti Federico. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: UIViewController, WKNavigationDelegate, AboutView {
    @IBOutlet weak var showBtn: UIButton!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var bioTv: UITextView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    lazy private var presenter: AboutPresenter = AboutPresenter(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        
        presenter.initPresenter()
    }
    
    @IBAction func loadWebSite() {
        if let htmlPath = Bundle.main.path(forResource: "BullsEye", ofType: "html") {
            let url = URL(fileURLWithPath: htmlPath)
            let urlRequest = URLRequest(url: url)
            
            webView.load(urlRequest)
            presenter.onLoadWebView()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        presenter.onLoadFinishedWebView()
    }
    
    @IBAction func close() { dismiss(animated: true, completion: nil) }
    
    func showWebView() { webView.isHidden = false }
    
    func hideWebView() { webView.isHidden = true }
    
    func showBioText() { bioTv.isHidden = false }
    
    func hideBioText() { bioTv.isHidden = true }
    
    func startLoading() { loader.isHidden = false }
    
    func stopLoading() { loader.isHidden = true }
    
    func isWebViewHidden() -> Bool {  return webView.isHidden }
    
    func changeLabelButton(label: String) {
        showBtn.setTitle(label, for: .normal)
    }
}
