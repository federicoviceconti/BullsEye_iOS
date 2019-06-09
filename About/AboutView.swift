//
//  AboutView.swift
//  BullsEye
//
//  Created by Viceconti Federico on 09/06/2019.
//  Copyright © 2019 Viceconti Federico. All rights reserved.
//

import Foundation

protocol AboutView {
    func isWebViewHidden() -> Bool
    func changeLabelButton(label: String)
    func showWebView()
    func hideWebView()
    func showBioText()
    func hideBioText()
    func startLoading()
    func stopLoading()
}
