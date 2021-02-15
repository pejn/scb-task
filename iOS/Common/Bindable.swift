//
//  Bindable.swift
//  scb-recruitment-task
//
//  Created by Konrad Siemczyk on 07/02/2021.
//

import Foundation

final class Bindable<T> {
    var value: T? {
        didSet {
            assert(Thread.isMainThread || !notifyOnMainThread)
            observer?(value)
        }
    }
    private var observer: ((T?) -> Void)?
    private let notifyOnMainThread: Bool
    
    func bind(observer: @escaping (T?) -> Void) {
        self.observer = observer
    }
    
    init(notifyOnMainThread: Bool = true) {
        self.notifyOnMainThread = notifyOnMainThread
    }
}
