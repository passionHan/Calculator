//
//  UIView+Extension.swift
//  Calculator
//
//  Created by passionHan on 13/04/2017.
//  Copyright © 2017 www.hopechina.cc 中和黄埔. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
}
