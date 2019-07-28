//
//  TimerClass.swift
//  Knight_Fit_Beta
//
//  Created by Evan Ringo on 7/26/19.
//  Copyright © 2019 Evan Ringo. All rights reserved.
//

import Foundation

class DisplayTimer{
    
     private var observations = [ObjectIdentifier : Observation]()
    
    //Time to countdown should always be # min * num sec
    //Currently hard coded to 5 misn
    let startTimeMin :Int
    let startTimeSec :Int
    var internalTimer : Timer
    var secondsLeft :Int = 0 {
        didSet{timeUpdate()}
    }
    
    
    
    convenience init(){
        self.init(min: 1*60, sec: 0)
    }
    
    init(min: Int, sec : Int) {
        startTimeMin = min
        startTimeSec = sec
        secondsLeft = startTimeMin + startTimeSec
        internalTimer = Timer()
        
    }
    
    func runTimer()
    {
        internalTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() -> Int {
            secondsLeft -= 1
            return secondsLeft
        
    }
    
}

private extension DisplayTimer{
    func timeUpdate(){
        for (id, observation) in observations {
            // If the observer is no longer in memory, we
            // can clean up the observation for its ID
            guard let observer = observation.observer else {
                observations.removeValue(forKey: id)
                continue
                
            }
            
            observer.displayTimer(self)
            
            
        }
        
        
    }
}

protocol DisplayTimerObserver : class {
    func displayTimer(_ timer: DisplayTimer)
}

extension DisplayTimerObserver {
    func displayTimer(_ timer: DisplayTimer){
        
    }
}

private extension DisplayTimer {
    struct Observation {
        weak var observer : DisplayTimerObserver?
    }
}

extension DisplayTimer{
    func addObserver(_ observer: DisplayTimerObserver){
        let id = ObjectIdentifier(observer)
        observations[id] = Observation(observer: observer)
    }
    
    func removerObserver(_ observer: DisplayTimerObserver) {
        let id = ObjectIdentifier(observer)
        observations.removeValue(forKey: id)
    }
}
