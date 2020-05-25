//
//  ViewController.swift
//  EggTimer
//
//  Created by Anjali on 5/25/20.
//  Copyright © 2020 Anjali. All rights reserved.
//


import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var TitleLabel: UILabel!
    
    let eggTimes = ["Soft": 300, "Medium" : 420, "Hard" : 720]
    var timer = Timer()
    var totalTime = 0
    var secondPassed = 0
    var player: AVAudioPlayer!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
          super.viewDidLoad()
    }

    @objc func updateCounter() {
        if secondPassed < totalTime {
            secondPassed += 1
            let processValue = Float(secondPassed)/Float(totalTime)
            progressBar.progress = processValue
            
        } else {
            timer.invalidate()
            playSound(soundName: "alarm_sound")
            TitleLabel.text = "Done"
        }
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        secondPassed = 0
        progressBar.progress = 0.0
        let hardness = sender.currentTitle!
        TitleLabel.text = "\(hardness)"
        totalTime = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
    }
}

