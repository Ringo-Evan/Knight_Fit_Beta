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


    @IBOutlet weak var testText: UITextView!
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
        testText.text = ""
        
        
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
    
    @IBAction func movementSelectionPressed(_ sender: Any) {
    }
    
    @IBAction func selectMusicPressed(_ sender: Any) {
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
        
        var isPunching = false
        var timeToCallAgain = 0
        
        if(displayTimer.secondsLeft > 0){
            timeLabel.text = "\(displayTimer.secondsLeft)"
            
            if !isPunching && Int.random(in: 1...4) == 1{
                isPunching = true
                timeToCallAgain = displayTimer.secondsLeft - 5
                let numShots = Int.random(in: 1...5)
                var shotString = ""
                for i in 0 ... numShots{
                    
                    let shot = Int.random(in: 0...8)
                    if shot == 0{
                        continue
                    }
                    shotString.append(String(shot))
                    
                    let hieght = Int.random(in: 0...3)
                    switch hieght {
                    case 1:
                        shotString.append("T")
                    case 2:
                        shotString.append("M")
                    case 3:
                        shotString.append("B")
                    default:
                        ()
                        
                    }
                    
                    let side = Int.random(in: 0...2)
                    switch side {
                    case 1:
                        shotString.append("L")
                    case 2:
                        shotString.append("R")
                    default:
                        ()
                    }
                    
                    if i != numShots{
                        shotString.append(", ")
                    }
                }
                if shotString != ""{
                    testText.insertText(shotString + "\n")
                    shotString = ""                    
                }
                
            }
            else if timeToCallAgain == displayTimer.secondsLeft{
                isPunching = false
            }
            
                
        }
        else{

            playSound(selectedSoundFileName: "rest")
            setUpTimer()
        }
        
        
    }
    
}
