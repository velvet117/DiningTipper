//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Anastasia Blodgett on 9/7/16.
//  Copyright © 2016 Anastasia Blodgett. All rights reserved.
//
import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipTabBar: UISegmentedControl!
    @IBOutlet var SettingsView: UIView!
    
    var defaultTipValue:Int = 0
    let defaults = UserDefaults.standard
    
    let backgroundColor = UIColor(red: 23/255, green: 31/255, blue: 50/255, alpha: 1)
    let tintColor = UIColor(red: 208/255, green: 208/255, blue: 208/255, alpha: 1)
    let fontColor = UIColor(red: 106/255, green: 116/255, blue: 130/255, alpha: 1)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        defaultTipTabBar.selectedSegmentIndex = defaults.integer(forKey: "defaultTip")
        SettingsView.backgroundColor = self.backgroundColor
        SettingsView.tintColor = self.tintColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        defaultTipValue = defaultTipTabBar.selectedSegmentIndex
        defaults.set(defaultTipValue, forKey: "defaultTip")
        defaults.synchronize()
    }
}
