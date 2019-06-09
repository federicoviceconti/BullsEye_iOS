//
//  HomeView.swift
//  BullsEye
//
//  Created by Viceconti Federico on 09/06/2019.
//  Copyright © 2019 Viceconti Federico. All rights reserved.
//

import Foundation

protocol HomeView {
    func updateLabels(values: HomeFields)
    func onShowAlert(titleAlert: String, earnedPoints: Int, values: HomeFields)
}
