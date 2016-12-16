//
//  AnimatingGroupButton.swift
//  AnimatingGroupButton
//
//  Created by Nikhila Mohan on 08/12/16.
//  Copyright © 2016 qbuser. All rights reserved.
//

import UIKit

public  class AnimatingGroupButton: UIButton {
    var firstButton = UIButton()
    var middleButton = UIButton()
    var lastButton = UIButton()
    var previousRect = CGRect(x: 0, y: 0, width: 100, height: 100)
    var previousTag = 0;
    let firstButtonTag = 100;
    let middleButtonTag = 200;
    let lastButtonTag = 300;
    let animationTime = 0.8;
    let cornerRadius = 25;
    
    
    let subLayer = CAShapeLayer()
    let progressLayer = CAShapeLayer()
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
        self.tintColor = UIColor.white
        self.setTitle("", for: .normal)
        createButtonGroups()
        
    }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        createButtonGroups()
    }
    
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        createButtonGroups()
    }
    
    open func createButtonGroups() {
        self.addTarget(self, action: #selector(buttonPressed), for:.touchUpInside)
        firstButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.frame.size.width/3, height: self.frame.size.height))
        firstButton.addTarget(self, action: #selector(buttonPressed), for:.touchUpInside)
        firstButton .setTitle("First", for: .normal)
        firstButton.setTitleColor(UIColor(red:(0/255), green: (163/255), blue: (123/255), alpha: 1), for: .normal)
        firstButton.tag = firstButtonTag
        self.addSubview(firstButton)
        middleButton = UIButton(frame: CGRect(x: self.frame.size.width/3, y: 0, width: self.frame.size.width/3, height: self.frame.size.height))
        middleButton .setTitle("Middle", for: .normal)
        middleButton.setTitleColor(UIColor(red:(0/255), green: (163/255), blue: (123/255), alpha: 1), for: .normal)
        middleButton.tag = middleButtonTag
        middleButton.addTarget(self, action: #selector(buttonPressed), for:.touchUpInside)
        self.addSubview(middleButton)
        lastButton = UIButton(frame: CGRect(x: (self.frame.size.width/3)*2, y: 0, width: self.frame.size.width/3, height: self.frame.size.height))
        lastButton .setTitle("Last", for: .normal)
        lastButton.setTitleColor(UIColor(red:(0/255), green: (163/255), blue: (123/255), alpha: 1), for: .normal)
        lastButton.tag = lastButtonTag
        
        lastButton.addTarget(self, action: #selector(buttonPressed), for:.touchUpInside)
        
        subLayer.strokeColor = UIColor(red:(0/255), green: (163/255), blue: (123/255), alpha: 1).cgColor
        subLayer.fillColor = UIColor.clear.cgColor
        self.addSubview(lastButton)
        
        previousRect = middleButton.frame
        previousTag = middleButton.tag
        self.addInitialLayer()
        
    }
    
    open func addInitialLayer() {
        let initialShape = UIBezierPath()
        initialShape.cgPath = UIBezierPath(roundedRect: middleButton.frame, cornerRadius: CGFloat(cornerRadius)).cgPath
        // set initial shape
        subLayer.path = initialShape.cgPath
        self.layer.addSublayer(subLayer)
    }
    
    
    open func buttonPressed(_ sender: UIButton)
    {
        if sender.tag != previousTag
        {
            
            let startShape = UIBezierPath()
            var newRect = CGRect(x: 0, y: 0, width: 100, height: 100)
            let xOffset = self.getxOffsetAndMultiplier(sender).xOffset
            let multiplier = self.getxOffsetAndMultiplier(sender).multiplier
            
            
            newRect = CGRect(x: xOffset, y: 0, width: (previousRect.size.width)*CGFloat(multiplier), height: previousRect.size.height)
            startShape.cgPath = UIBezierPath(roundedRect: newRect, cornerRadius: CGFloat(cornerRadius)).cgPath
            
            let endShape = UIBezierPath(roundedRect: sender.frame, cornerRadius: CGFloat(cornerRadius)).cgPath
            
            if sender.tag>previousTag
            {
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.duration = animationTime // duration is 0.4 sec
                animation.fromValue = 0.0;
                animation.toValue = 1.0;
                
                subLayer.add(animation, forKey: "strokeEndAnimation")
                
            }
            else
            {
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.duration = animationTime // duration is 0.4 sec
                animation.fromValue = 0.0;
                animation.toValue = 1.0;
                
                subLayer.add(animation, forKey: "strokeEndAnimation")
                
            }
            subLayer.path = startShape.cgPath
            self.layer.addSublayer(subLayer)
            
            let dispatchTime = DispatchTime.now() + animationTime/2
            DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
                // your function here
                
                self.subLayer.path = endShape
            }
            
            previousRect = sender.frame
            previousTag = sender.tag
        }
        
    }
    
    
    open  func getxOffsetAndMultiplier(_ sender:UIButton) -> (xOffset: CGFloat, multiplier: Int) {
        
        var multiplier = 0
        var xOffset: CGFloat = 0
        if sender.tag-previousTag==firstButtonTag  {
            multiplier = 2;
            xOffset = previousRect.origin.x
        }
        else if sender.tag-previousTag == -firstButtonTag
        {
            multiplier = 2;
            xOffset = sender.frame.origin.x
            
        }
        else if sender.tag-previousTag==middleButtonTag
        {
            multiplier = 3
            xOffset = previousRect.origin.x
            
        }
        else if sender.tag-previousTag == -middleButtonTag
        {
            multiplier = 3
            xOffset = sender.frame.origin.x
            
        }
        
        return ( xOffset, multiplier)
    }
    
}
