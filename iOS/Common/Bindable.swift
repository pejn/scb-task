//
//  Bindable.swift
//  scb-recruitment-task
//
//  Created by Konrad Siemczyk on 07/02/2021.
//

import Foundation

final class Bindable<T> {
    var value: T {
        didSet {
            observer?(value)
        }
    }
    
    private var observer: ((T) -> ())?
    
    func bind(observer: @escaping (T) -> ()) {
        self.observer = observer
    }
    
    init(value: T) {
        self.value = value
    }
}
