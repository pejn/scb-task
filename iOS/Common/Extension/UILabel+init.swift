//
//  UILabel+init.swift
//  scb-recruitment-task
//
//  Created by Konrad Siemczyk on 14/02/2021.
//

import UIKit

extension UILabel {
    convenience init(numberOfLines: Int, font: UIFont? = nil) {
        self.init()
        self.numberOfLines = numberOfLines
        self.font = font
    }
}
