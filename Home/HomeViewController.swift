//
//  ViewController.swift
//  BullsEye
//
//  Created by Viceconti Federico on 09/06/2019.
//  Copyright © 2019 Viceconti Federico. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomeView {
    lazy private var presenter: HomePresenter = HomePresenter(view: self)
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var currentRoundLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.initValues(min: Int(slider.minimumValue),
                              max: Int(slider.maximumValue),
                              value: Int(slider.value))
        presenter.startNewRound()
        
        initUI()
    }
    
    private func initUI() {
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbHighlightedImage = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbHighlightedImage, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftImageResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightImageResizable = trackRightImage.resizableImage(withCapInsets: insets)
        
        slider.setMinimumTrackImage(trackLeftImageResizable, for: .normal)
        slider.setMaximumTrackImage(trackRightImageResizable, for: .normal)
    }
    
    func updateLabels(values: HomeFields) {
        targetLabel.text = "\(values.targetValue)"
        currentRoundLabel.text = "\(values.currentRoundValue)"
        currentScoreLabel.text = "\(values.currentScoreValue)"
        slider.value = Float(values.currentValue)
    }
    
    @IBAction func onSliderValueChange(_ slider: UISlider) {
        presenter.onSliderValueChanged(value: Int(slider.value))
    }
    
    @IBAction func hitMeButton() { presenter.onHitMeButtonClicked() }
    
    @IBAction func startOverButton() {
        showAlert(title: "Do you wanna start again?", description: "This will reset your score.", action:
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: { action in
                    self.startAgain()
                }
            )
        )
    }
    
    private func startAgain() {
        presenter.onStartOverClicked()
    }
    
    func onShowAlert(titleAlert: String, earnedPoints: Int, values: HomeFields) {
        showAlert(
            title: titleAlert,
            description: "You earn \(earnedPoints) points\n\nYou: \(values.currentValue)\nTarget: \(values.targetValue)",
            action: UIAlertAction(
                title: "OK",
                style: .default,
                handler: { action -> Void in self.roundFinished() }
            )
        )
    }
    
    private func showAlert(title: String, description: String, action: UIAlertAction) {
        let alert = UIAlertController(
            title: title,
            message: description,
            preferredStyle: .alert
        )
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func roundFinished() { presenter.startNewRound() }
}

