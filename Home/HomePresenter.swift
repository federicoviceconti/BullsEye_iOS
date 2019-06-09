//
//  HomePresenter.swift
//  BullsEye
//
//  Created by Viceconti Federico on 09/06/2019.
//  Copyright © 2019 Viceconti Federico. All rights reserved.
//

import Foundation

class HomePresenter {
    var view: HomeView
    var currentValues: HomeFields
    
    init(view: HomeView) {
        self.view = view
        self.currentValues = HomeFields()
    }
    
    func initValues(min: Int, max: Int, value: Int) {
        self.currentValues.currentValue = value
        self.currentValues.min = min
        self.currentValues.max = max
    }
    
    func startNewRound() {
        updateValues()
        view.updateLabels(values: currentValues)
    }
    
    private func updateValues() {
        self.currentValues.targetValue = Int.random(in: currentValues.min...currentValues.max)
        self.currentValues.currentRoundValue += 1
    }
    
    func onHitMeButtonClicked() {
        let difference = updateScoreAndGetDifference(currentValue: Int(currentValues.currentValue))
        let titleAlert = getTitleByAccuracy(value: difference)
        
        view.onShowAlert(titleAlert: titleAlert, earnedPoints: difference, values: currentValues)
    }
    
    func onStartOverClicked() {
        self.currentValues.currentRoundValue = 0
        self.currentValues.currentScoreValue = 0
        startNewRound()
    }
    
    func onSliderValueChanged(value: Int) {
        self.currentValues.currentValue = value
    }
    
    private func getTitleByAccuracy(value: Int) -> String {
        let score = Score.init(rawValue: value)
        switch score {
        case .max?:
            return "The perfection exists!"
        case .half?:
            return "You almost had it!"
        case .quarter?:
            return "Next time you'll be better!"
        default:
            return "Keep trying!"
        }
    }
    
    private func updateScoreAndGetDifference(currentValue: Int) -> Int {
        let difference = abs(currentValue - currentValues.targetValue)
        let accuracy = getAccuracy(difference: difference)
        currentValues.currentScoreValue += accuracy
        return accuracy
    }
    
    private func getAccuracy(difference: Int) -> Int {
        var value = Score.zero
        
        if(difference > -1 && difference <= 5) {
            value = Score.max
        } else if(difference > 5 && difference <= 15) {
            value = Score.half
        } else if(difference > 15 && difference < 30) {
            value = Score.quarter
        }
        
        return value.rawValue
    }
}

struct HomeFields {
    var currentValue: Int = 0
    var targetValue: Int = 0
    var currentRoundValue: Int = 0
    var currentScoreValue: Int = 0
    var min: Int = 0
    var max: Int = 0
}

enum Score: Int  {
    case max = 100
    case half = 50
    case quarter = 15
    case zero = 0
}
