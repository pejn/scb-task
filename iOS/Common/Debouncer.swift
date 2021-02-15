//
//  Debouncer.swift
//  scb-recruitment-task
//
//  Created by Konrad Siemczyk on 07/02/2021.
//

import Foundation

final class Debouncer: NSObject {
    private var callback: () -> Void
    private var delay: TimeInterval
    private weak var timer: Timer?
    
    deinit {
        timer?.invalidate()
    }
    
    init(delay: TimeInterval, callback: @escaping () -> Void = {}) {
        self.delay = delay
        self.callback = callback
    }
    
    func call(callback: @escaping () -> Void = {}) {
        self.callback = callback
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(fireNow),
                                     userInfo: nil, repeats: false)
    }
    
    @objc private func fireNow() {
        callback()
    }
}
