//
//  ViewController.swift
//  Calculator
//
//  Created by Vlad on 04.07.17.
//  Copyright © 2017 Vlad. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    var buttonWithBorder: UIButton!
    var startTyping: Bool = true
    var dotIsPlaced: Bool = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign: String = ""
    var currentInput : Double {
        get {
            return Double(resultLabel.text!)!
        }
        
        set {
            let value = "\(newValue)"
            let splitArray = value.components(separatedBy: ".")
            if splitArray.count == 1{
                return
            }
            if splitArray[1] == "0" {
                resultLabel.text = "\(splitArray[0])"
            } else {
                resultLabel.text = "\(newValue)"
            }
            startTyping = true
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func clearResultLabel(_ sender: UIButton) {
        resultLabel.text = "0"
        startTyping = true
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        operationSign = ""
        dotIsPlaced = false
    }
    
    
    @IBAction func numberPressed(_ sender: UIButton) {
        if buttonWithBorder != nil {
            buttonWithBorder.layer.borderWidth = 0
        }
        if resultLabel.text!.characters.count < 10 {
            if resultLabel.text! == "0" && sender.currentTitle == "0" {
                return
            }
            if startTyping {
                resultLabel.text! = sender.currentTitle!
                startTyping = false
            } else {
                if resultLabel.text! == "0" {
                    resultLabel.text! = sender.currentTitle!
                    return
                }
                resultLabel.text! += sender.currentTitle!
            }
        }
    }
    

    @IBAction func operationButtonCklicked(_ sender: UIButton) {
        if buttonWithBorder != nil {
            buttonWithBorder.layer.borderWidth = 0
        }
        firstOperand = currentInput
        startTyping = true
        operationSign = sender.currentTitle!
        sender.layer.borderWidth = 1.0
        sender.layer.borderColor = UIColor.black.cgColor
        buttonWithBorder = sender
        dotIsPlaced = false
    }
    
    func makeOperation(operation: (Double, Double) -> Double) {
        if secondOperand == 0 && operationSign ==  "÷" {
            secondOperand = 1
        }
        currentInput = operation(firstOperand, secondOperand)
        startTyping = true
    }
    
    @IBAction func equalSignPressed(_ sender: UIButton) {
        if !startTyping {
            secondOperand = currentInput
        }
        dotIsPlaced = false
        switch operationSign {
        case "+":
            makeOperation {$0 + $1}
        case "-":
            makeOperation {$0 - $1}
        case "x":
            makeOperation {$0 * $1}
        case "÷":
            makeOperation {$0 / $1}
        default: break
        }
    }

    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        currentInput = -currentInput
        startTyping = false
    }
    
    @IBAction func percentButtonPressed(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
        startTyping = true
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        if !startTyping && !dotIsPlaced {
            resultLabel.text = resultLabel.text! + "."
            dotIsPlaced = true
        } else if startTyping && !dotIsPlaced {
            resultLabel.text = "0."
            dotIsPlaced = true
            startTyping = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resultLabel.text = "0"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


