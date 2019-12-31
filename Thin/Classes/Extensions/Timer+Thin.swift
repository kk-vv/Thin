//
//  Timer+Thin.swift
//  Thin
//
//  Created by JuanFelix on 2019/12/30.
//

import Foundation

extension Thin where Base: Timer {
    static func scheduledTimer(timeInterval: TimeInterval,
                               repeats: Bool,
                               completion:@escaping ((_ timer:Timer)->())) -> Timer{
        
        return Timer.scheduledTimer(timeInterval: timeInterval,
                                    target: Timer.self,
                                    selector: #selector(Timer.completionLoop(timer:)),
                                    userInfo: completion,
                                    repeats: repeats)
    }
}

extension Timer {
    @objc static func completionLoop(timer:Timer) {
        guard let completion = timer.userInfo as? ((Timer) -> ()) else {
            return
        }
        completion(timer)
    }
}
