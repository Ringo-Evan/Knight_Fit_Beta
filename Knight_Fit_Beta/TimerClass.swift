//
//  TimerClass.swift
//  Knight_Fit_Beta
//
//  Created by Evan Ringo on 7/26/19.
//  Copyright © 2019 Evan Ringo. All rights reserved.
//

import Foundation

class Timer{
    
    //Time to countdown should always be # min * num sec
    //Currently hard coded to 5 misn
    let startTimeMin :Int
    let startTimeSec :Int
    
    init(){
        startTimeSec = 0
        startTimeMin = 60*5
    }
    init(min: Int, sec : Int){
        startTimeMin = min
        startTimeSec = sec
    }
    
}
