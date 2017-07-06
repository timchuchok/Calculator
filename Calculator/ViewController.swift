//
//  ViewController.swift
//  Calculator
//
//  Created by Vlad on 04.07.17.
//  Copyright © 2017 Vlad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func clearResultLabel(_ sender: UIButton) {
        resultLabel.text = "0"
    }
    
    
    @IBAction func numberPressed(_ sender: UIButton) {
        if resultLabel.text!.characters.count < 10 {
            if resultLabel.text! == "0" {
                resultLabel.text! = sender.currentTitle!
            } else {
                resultLabel.text! += sender.currentTitle!
            }
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

