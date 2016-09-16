//
//  ViewController.swift
//  TipCalculator
//
//  Created by Anastasia Blodgett on 9/7/16.
//  Copyright © 2016 Anastasia Blodgett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tipCalculatorView: UIView!
    @IBOutlet weak var hairline: UIView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var resultsView: UIView!
    
    let backgroundColor = UIColor(red: 23/255, green: 31/255, blue: 50/255, alpha: 1)
    
    let tintColor = UIColor(red: 208/255, green: 208/255, blue: 208/255, alpha: 1)
    
    let fontColor = UIColor(red: 106/255, green: 116/255, blue: 130/255, alpha: 1)
    
    let tipPercentages = [0.15, 0.18, 0.2]
    let defaults = NSUserDefaults.standardUserDefaults()
    var billAmount:Double = 0
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaultTip = defaults.integerForKey("defaultTip")
        tipControl.selectedSegmentIndex = defaultTip
        
        billAmount = Double(billField.text!) ?? 0
        defaults.setDouble(billAmount, forKey: "billAmount")
        defaults.synchronize()
        
        if billField.text == "" {
            resultsView.alpha = 0
        }
        
        self.calculateTip(tipControl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipCalculatorView.backgroundColor = self.backgroundColor
        tipCalculatorView.tintColor = self.tintColor
        
        totalLabel.textColor = self.fontColor
        tipLabel.textColor = self.fontColor
        
        hairline.backgroundColor = tintColor
        
        billField.becomeFirstResponder()
        billField.textColor = self.fontColor
        billField.tintColor = self.tintColor
        
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        
        if billField.text != "" {
            UIView.animateWithDuration(0.4, animations: {
                self.resultsView.alpha = 1
            })
        }
        
        let bill = Double(billField.text!) ?? 0
        
        let tip = bill * self.tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip

        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f",total)
    }
}

