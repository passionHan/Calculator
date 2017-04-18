//
//  ViewController.swift
//  Calculator
//
//  Created by passionHan on 2017/3/30.
//  Copyright © 2017年 www.hopechina.cc 中和黄埔. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!

    fileprivate var brain = CalculatorBrain()
    var userIsInTheMiddleOfTypeingMember = false
    var displayVale: Double {
        get {
            return Double(displayLabel.text!)!
        } set {
            displayLabel.text = "\(newValue)"
            userIsInTheMiddleOfTypeingMember = false
        }
    }
    
    @IBAction func appendDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypeingMember {
            displayLabel.text = displayLabel.text! + digit
        } else {
            displayLabel.text = digit
            userIsInTheMiddleOfTypeingMember = true
        }
    }
    
    @IBAction func operate(_ sender: UIButton) {
        if userIsInTheMiddleOfTypeingMember {
            enter()
        }
        
        if let operation = sender.currentTitle{
            if let result = brain.performOperation(symbol: operation) {
                displayVale = result
            } else {
                displayVale = 0
            }
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypeingMember = false
        if let result = brain.pushOperand(operand: displayVale) {
            displayVale = result
        } else {
            displayVale = 0
        }
    }

}

