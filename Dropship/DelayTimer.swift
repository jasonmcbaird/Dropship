//
//  DelayTimer.swift
//  Dropship
//
//  Created by dev1 on 1/10/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation

class DelayTimer: Delayer {
    
    let loopTime: Int
    
    init(loopTime: Int) {
        self.loopTime = loopTime
    }
    
    func executeAfterDelay(completed: @escaping () -> (Bool)) {
        Timer.scheduledTimer(withTimeInterval: TimeInterval(loopTime), repeats: true) { timer in
            if completed() {
                timer.invalidate()
            }
        }
    }
    
}
