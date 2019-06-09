//
//  AboutAuthorPresenter.swift
//  BullsEye
//
//  Created by Viceconti Federico on 09/06/2019.
//  Copyright © 2019 Viceconti Federico. All rights reserved.
//

import Foundation

class AboutPresenter {
    private var view: AboutView!
    
    init(view: AboutView) {
        self.view = view
    }
    
    func initPresenter() {
        closeWebView()
    }
    
    func onLoadWebView() {
        if(view.isWebViewHidden()) {
            view.hideBioText()
            view.changeLabelButton(label: "Hide web view")
            view.showWebView()
            view.startLoading()
        } else {
            closeWebView()
            view.changeLabelButton(label: "Show web view")
        }
    }
    
    func onLoadFinishedWebView() {
        view.stopLoading()
    }
    
    func closeWebView() {
        view.stopLoading()
        view.hideWebView()
        view.showBioText()
    }
}
