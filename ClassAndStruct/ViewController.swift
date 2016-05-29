//
//  ViewController.swift
//  ClassAndStruct
//
//  Created by Jatin Arora on 29/05/16.
//  Copyright © 2016 JatinArora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myScreen = Screen(height:640, width:480)
        let totalPixels = myScreen.calculateTotalPixels()
        print("Total pixels on the screen are = \(totalPixels)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

