//
//  TimerClass.swift
//  Knight_Fit_Beta
//
//  Created by Evan Ringo on 7/26/19.
//  Copyright © 2019 Evan Ringo. All rights reserved.
//

import Foundation

class DisplayTimer{
    
    //Time to countdown should always be # min * num sec
    //Currently hard coded to 5 misn
    let startTimeMin :Int
    let startTimeSec :Int
    var internalTimer : Timer
    var secondsLeft :Int
    
    convenience init(){
        self.init(min: 5*60, sec: 0)
    }
    init(min: Int, sec : Int){
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
