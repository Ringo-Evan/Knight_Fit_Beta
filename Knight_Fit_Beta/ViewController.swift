//
//  ViewController.swift
//  Knight_Fit_Beta
//
//  Created by Evan Ringo on 7/20/19.
//  Copyright © 2019 Evan Ringo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var displayTimer : DisplayTimer = DisplayTimer()
    
    var audioPlayer : AVAudioPlayer!


    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startOrEnd_Button: UIButton!
    @IBOutlet weak var timePickerSelect: UIPickerView!
    
    @IBOutlet weak var sectionPickerSelect: UIPickerView!
    var isRunning : Bool = false
    
   
    @IBAction func startOrEnd(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        displayTimer.addObserver(self)
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func startOrEndPressed(_ sender: Any) {
        
        if(!isRunning){
            runTimer()
           
        }
        else
        {
            
            setUpTimer()
        }
        
        
    }
    
    @IBAction func selectMusicPressed(_ sender: Any) {
    }
    @IBAction func movementSelectPressed(_ sender: Any) {
    }
    
    func setUpTimer(){
        
        startOrEnd_Button.setTitle("start", for: .normal)
        isRunning = false
        displayTimer.removerObserver(self)
        timeLabel.text = String(3*60)
        displayTimer = DisplayTimer(min: 3*60, sec: 0)
        displayTimer.addObserver(self)
    }
    
    func runTimer(){
        isRunning = true
        displayTimer.runTimer()
        startOrEnd_Button.setTitle("End", for: .normal)
        timeLabel.text = String(displayTimer.secondsLeft)
    }
    

    func playSound(selectedSoundFileName : String) {
        
        
        let soundURL = Bundle.main.url(forResource: selectedSoundFileName, withExtension: "wav")
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
            
            audioPlayer.play()
        }
        catch {
            
        }
    }
}


extension ViewController : DisplayTimerObserver{
    func displayTimer(_ timer: DisplayTimer) {
        if(displayTimer.secondsLeft > 0){
            
            timeLabel.text = "\(displayTimer.secondsLeft)"
        }
        else{

            playSound(selectedSoundFileName: "rest")
            setUpTimer()
        }
        
        
    }
    
}
