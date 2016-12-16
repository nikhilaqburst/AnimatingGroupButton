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
        let buttonGroup = AnimatingGroupButton(frame: CGRect(origin: CGPoint(x: 5,y :30), size: CGSize(width: 325, height: 50)))
        self.view.addSubview(buttonGroup)

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

