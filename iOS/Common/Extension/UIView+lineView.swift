//
//  UIView+lineView.swift
//  scb-recruitment-task
//
//  Created by Konrad Siemczyk on 14/02/2021.
//

import UIKit

extension UIView {
    static func lineView() -> UIView {
        let view = UIView()
        view.height(0.5)
        view.backgroundColor = .lightGray
        return view
    }
}
