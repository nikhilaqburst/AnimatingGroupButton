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
    let firstButtonTag = 100
    let middleButtonTag = 200
    let lastButtonTag = 300
    let animationTime = 0.8
    let cornerRadius = 25
    var strokeColor = UIColor()
    public var firstButtonTitle = String()
    public var middleButtonTitle = String()
    public var lastButtonTitle = String()
    
    
    let subLayer = CAShapeLayer()
    let progressLayer = CAShapeLayer()
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
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
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if firstButtonTitle.isEmpty {
            firstButtonTitle = "First"
        }
        if middleButtonTitle.isEmpty {
            middleButtonTitle = "Middle"
        }
        if lastButtonTitle.isEmpty {
            lastButtonTitle = "Last"
        }
        firstButton.setTitle(firstButtonTitle, for: .normal)
        middleButton.setTitle(middleButtonTitle, for: .normal)
        lastButton.setTitle(lastButtonTitle, for: .normal)
        strokeColor = self.currentTitleColor
        subLayer.strokeColor = strokeColor.cgColor
        firstButton.setTitleColor(strokeColor, for: .normal)
        middleButton.setTitleColor(strokeColor, for: .normal)
        lastButton.setTitleColor(strokeColor, for: .normal)
        
    }
    
    open func createButtonGroups() {
        
        self.addTarget(self, action: #selector(buttonPressed), for:.touchUpInside)
        firstButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.frame.size.width/3, height: self.frame.size.height))
        firstButton.addTarget(self, action: #selector(buttonPressed), for:.touchUpInside)
        firstButton.tag = firstButtonTag
        self.addSubview(firstButton)
        middleButton = UIButton(frame: CGRect(x: self.frame.size.width/3, y: 0, width: self.frame.size.width/3, height: self.frame.size.height))
        middleButton.tag = middleButtonTag
        middleButton.addTarget(self, action: #selector(buttonPressed), for:.touchUpInside)
        self.addSubview(middleButton)
        lastButton = UIButton(frame: CGRect(x: (self.frame.size.width/3)*2, y: 0, width: self.frame.size.width/3, height: self.frame.size.height))
        lastButton.tag = lastButtonTag
        
        lastButton.addTarget(self, action: #selector(buttonPressed), for:.touchUpInside)
        
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
    
    
    func buttonPressed(_ sender: UIButton)
    {
        if sender.tag != previousTag
        {
            
            let startShape = UIBezierPath()
            let endShape = UIBezierPath()
            
            let xOffset = self.getxOffsetAndMultiplier(sender).xOffset
            let multiplier = self.getxOffsetAndMultiplier(sender).multiplier
            
            
            let newRect = CGRect(x: xOffset, y: 0, width: (previousRect.size.width)*CGFloat(multiplier), height: previousRect.size.height)
            let path = UIBezierPath(roundedRect: newRect, cornerRadius: newRect.size.height/2)
            
            let endPath = UIBezierPath(roundedRect: sender.frame, cornerRadius: sender.frame.size.height/2)
            
            if sender.tag>previousTag
            {
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.duration = animationTime // duration is 0.4 sec
                animation.fromValue = 0;
                animation.toValue = 1
                
                subLayer.add(animation, forKey: "strokeEndAnimation")
                startShape.cgPath = path.reversing().cgPath;
                endShape.cgPath = endPath.reversing().cgPath
                
                
            }
            else
            {
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.duration = animationTime // duration is 0.4 sec
                animation.fromValue = 0.0;
                animation.toValue = 1.0;
                
                subLayer.add(animation, forKey: "strokeEndAnimation")
                startShape.cgPath = path.cgPath;
                endShape.cgPath = endPath.cgPath
                
                
            }
            subLayer.path = startShape.cgPath
            self.layer.addSublayer(subLayer)
            
            let dispatchTime = DispatchTime.now() + animationTime-0.2
            DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
                // your function here
                
                self.subLayer.path = endShape.cgPath;
                
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
