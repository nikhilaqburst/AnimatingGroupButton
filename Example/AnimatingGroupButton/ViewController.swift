//
//  ViewController.swift
//  AnimatingGroupButton
//
//  Created by Nikhila Mohan on 12/15/2016.
//  Copyright (c) 2016 Nikhila Mohan. All rights reserved.
//

import UIKit
import AnimatingGroupButton

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = AnimatingGroupButton(frame: CGRect(x: 30, y: 100, width: 300, height: 50))
        button.firstButtonTitle = "One"
        button.middleButtonTitle = "Two"
        button.lastButtonTitle = "Three"
        button.setTitleColor(UIColor.red, for: .normal)
        self.view.addSubview(button)

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

