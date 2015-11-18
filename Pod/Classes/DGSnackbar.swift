//
//  DGSnackbar.swift
//  DGSnackbar
//
//  Created by Dhvl on 03/09/15.
//  Copyright (c) 2015 Dhvl. All rights reserved.
//

import UIKit


@objc public class DGSnackbar: UIView {
    
   public  var backgroundView: UIView!
   public  var messageLabel: UILabel!
    public var textInsets: UIEdgeInsets!
    public var actionButton : UIButton!
    public var interval = NSTimeInterval()
    public var dismisTimer = NSTimer()
    var actionBlock : (DGSnackbar -> Void)?
    var dismissBlock : (DGSnackbar -> Void)?
    
    let buttonWidth : CGFloat = 44
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        // 3. Setup view from .xib file
        setAllViews()
    }
    
    
    func setAllViews() {
        
        
        self.backgroundView = UIView()
        self.backgroundView.frame = self.bounds
        self.backgroundView.backgroundColor = UIColor(white: 0.1, alpha: 0.9)
        self.backgroundView.layer.cornerRadius = 3
        self.backgroundView.clipsToBounds = true
        self.addSubview(self.backgroundView)
        
        self.messageLabel = UILabel()
        self.messageLabel.frame = self.bounds
        self.messageLabel.textColor = UIColor.whiteColor()
        self.messageLabel.backgroundColor = UIColor.clearColor()
        self.messageLabel.font = UIFont.systemFontOfSize(14)
        self.messageLabel.numberOfLines = 0
        self.messageLabel.textAlignment = .Center;
        self.backgroundView.addSubview(self.messageLabel)
        
        self.actionButton = UIButton()
        self.actionButton.frame = self.bounds
        self.actionButton.titleLabel?.textColor = UIColor.whiteColor()
        self.actionButton.backgroundColor = UIColor.clearColor()
        self.actionButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        self.actionButton.addTarget(self, action: "onActionButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.backgroundView.addSubview(self.actionButton)
        
        interval = 0
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "deviceOrientationDidChange:",
            name: UIDeviceOrientationDidChangeNotification,
            object: nil
        )
        
    }
    
    func deviceOrientationDidChange(sender: AnyObject?) {
        updateView()
    }
    
    required convenience public init?(coder aDecoder: NSCoder) {
        self.init()
    }

    
    func updateView() {
        
        let deviceWidth = CGRectGetWidth(UIScreen.mainScreen().bounds)
        let constraintSize = CGSize(width: deviceWidth * (260.0 / 320.0), height: CGFloat.max)
        let textLabelSize = self.messageLabel.sizeThatFits(constraintSize)
        self.messageLabel.frame = CGRect(
            x: 5,
            y: 5,
            width: textLabelSize.width,
            height: textLabelSize.height
        )
        self.backgroundView.frame = CGRect(
            x: 2,
            y: 0,
            width: deviceWidth - 4,
            height: self.messageLabel.frame.size.height + 10 >= 54 ? self.messageLabel.frame.size.height + 10 : 54
        )
        self.messageLabel.center = CGPointMake(self.messageLabel.center.x, self.backgroundView.center.y)
        
        self.actionButton.frame = CGRect(
            x: deviceWidth - 51,
            y: 5,
            width: buttonWidth,
            height: buttonWidth
        )
        self.setViewToBottom()
        
    }
    
    public func makeSnackbar(message : String?, actionButtonTitle : String?, interval : NSTimeInterval , actionButtonBlock : (DGSnackbar -> Void), dismisBlock : (DGSnackbar -> Void))-> (){
        
        self.messageLabel.text = message
        self.actionButton.setTitle(actionButtonTitle, forState: UIControlState.Normal)
        self.interval = interval
        self.actionBlock = actionButtonBlock
        self.dismissBlock = dismisBlock
        show()
    }
    
   public func makeSnackbar(message : String?, actionButtonImage : UIImage?, interval : NSTimeInterval , actionButtonBlock : (DGSnackbar -> Void), dismisBlock : (DGSnackbar -> Void))-> (){
        
        
        let status = NSUserDefaults.standardUserDefaults().boolForKey("DGSnackbar")
        
        if status {
            self.dismissSnackBar()
        }
        
        self.messageLabel.text = message
        self.actionButton.setImage(actionButtonImage, forState: UIControlState.Normal)
        self.interval = interval
        self.actionBlock = actionButtonBlock
        self.dismissBlock = dismisBlock
        show()
    }
    
    public func makeSnackbar(message : String?, interval : NSTimeInterval, dismisBlock : (DGSnackbar -> Void)) -> () {
        self.messageLabel.text = message
        self.actionButton.setTitle("", forState: UIControlState.Normal)
        self.interval = interval
        self.dismissBlock = dismisBlock
        show()
        
    }
    
    func setViewToBottom() {
        let screenSize = UIScreen.mainScreen().bounds.size
        self.frame = CGRect(x: 0, y: screenSize.height , width: screenSize.width, height: self.backgroundView.frame.size.height);
    }
    
    func showView() {
        let screenSize = UIScreen.mainScreen().bounds.size
        self.frame = CGRect(x: 0, y: screenSize.height - self.backgroundView.frame.size.height - 2, width: screenSize.width, height: self.backgroundView.frame.size.height);
    }
    
    override public var window: UIWindow {
        for window in UIApplication.sharedApplication().windows ?? [] {
            if NSStringFromClass(window.dynamicType) == "UITextEffectsWindow" {
                return window
            }
        }
        return UIApplication.sharedApplication().windows.first!
    }
    
    func show() {
        
        dispatch_async(dispatch_get_main_queue(), {
            self.updateView()
            self.alpha = 0
            self.window.addSubview(self)
            UIView.animateWithDuration(
                0.2,
                delay: 0,
                options: UIViewAnimationOptions.CurveEaseOut,
                animations: {
                    self.showView()
                    self.alpha = 1
                },
                completion: nil)
            self.dismisTimer = NSTimer.scheduledTimerWithTimeInterval(self.interval, target: self, selector: "dismissSnackBar", userInfo: nil, repeats: false)
            
        })
    }
    
    func dismissSnackBar() {
        self.dismisTimer.invalidate()
        UIView.animateWithDuration(
            0.0,
            delay: 0,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: {
                self.setViewToBottom()
                self.alpha = 0
            },
            completion: { animation in
                self.dismissBlock!(self)
                self.removeFromSuperview()
        })
    }
    
    func onActionButtonPressed(button : UIButton!) {
        self.actionBlock!(self)
        dismissSnackBar()
    }
}

