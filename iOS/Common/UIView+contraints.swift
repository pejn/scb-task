//
//  UIView+contraints.swift
//  scb-recruitment-task
//
//  Created by Konrad Siemczyk on 07/02/2021.
//

import UIKit

extension UIView {
    func edgesToSuperview(insets: UIEdgeInsets = .zero) {
        guard let superview = superview else {
            fatalError("No superview")
        }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right).isActive = true
    }
    
    func centerInSuperview() {
        guard let superview = superview else {
            fatalError("No superview")
        }
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
    }
}
