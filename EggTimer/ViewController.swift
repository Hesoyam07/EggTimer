//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTime = ["Soft": 3, "Medium": 5, "Hard": 7]
    var timer = Timer()
    var totalTime = 0 // всего время
    var secondsPassed = 0 // времени прошло
    var audioPlayer: AVAudioPlayer?
    
    
    @IBOutlet weak var progressBar: UIProgressView! // прогресс
    @IBOutlet weak var titleLabel: UILabel! // надпись над яйцами
    
    func playSound() { // плеер
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: ".mp3") else { return }
        audioPlayer = try! AVAudioPlayer(contentsOf: url)
        audioPlayer?.play()
    }
    @IBAction func hardnessSelected(_ sender: UIButton) { // настройки кнопок и их логики
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTime[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeRemaining), userInfo: nil, repeats: true)
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
    }
    @objc func timeRemaining () { // метод таймера и прогрес бар
        if secondsPassed <= totalTime {
            
            progressBar.progress = Float(secondsPassed) / Float (totalTime)
            print(Float(secondsPassed) / Float (totalTime))
            
            secondsPassed += 1
            
        } else { // обнуление таймера, завершение работы и проигрывание звука
            timer.invalidate()
            titleLabel.text = "Done"
            playSound()
        }
        
        
    }
    
    
    
    
}

