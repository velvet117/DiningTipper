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
    let defaults = UserDefaults.standard
    var billAmount:Double = 0
    var formatter = NumberFormatter()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaultTip = defaults.integer(forKey: "defaultTip")
        tipControl.selectedSegmentIndex = defaultTip
        
        billField.placeholder = "$"
        billAmount = Double(billField.text!) ?? 0
        
        if billAmount == 0 {
            resultsView.alpha = 0
        }
        
        self.calculateTip(tipControl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipCalculatorView.backgroundColor = self.backgroundColor
        tipCalculatorView.tintColor = self.tintColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isOpaque = true
        
        totalLabel.textColor = self.fontColor
        tipLabel.textColor = self.fontColor
        
        hairline.backgroundColor = tintColor
        
        billField.becomeFirstResponder()
        billField.textColor = self.fontColor
        billField.tintColor = self.tintColor
        
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = NSLocale.current
        formatter.maximumFractionDigits = 2
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        defaults.set(billAmount, forKey: "billAmount")
        defaults.synchronize()
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        
        if billField.text != "" {
            UIView.animate(withDuration: 0.4, animations: {
                self.resultsView.alpha = 1
            })
        }
        
        billAmount = Double(billField.text!) ?? 0
        
        let tip = billAmount * self.tipPercentages[tipControl.selectedSegmentIndex]
        let total = billAmount + tip

        tipLabel.text = formatter.string(from: NSNumber(value: Double(tip)))
        totalLabel.text = formatter.string(from: NSNumber(value: Double(total)))
    }
}

