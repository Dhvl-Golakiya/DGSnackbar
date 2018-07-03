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
    public var interval = TimeInterval()
    public var dismisTimer = Timer()
    var actionBlock : ((DGSnackbar) -> Void)?
    var dismissBlock : ((DGSnackbar) -> Void)?
    
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
        self.messageLabel.textColor = UIColor.white
        self.messageLabel.backgroundColor = UIColor.clear
        self.messageLabel.font = UIFont.systemFont(ofSize: 14)
        self.messageLabel.numberOfLines = 0
        self.messageLabel.textAlignment = .center;
        self.backgroundView.addSubview(self.messageLabel)
        
        self.actionButton = UIButton()
        self.actionButton.frame = self.bounds
        self.actionButton.titleLabel?.textColor = UIColor.white
        self.actionButton.backgroundColor = UIColor.clear
        self.actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.actionButton.addTarget(self, action: #selector(onActionButtonPressed(button:)), for: UIControlEvents.touchUpInside)
        self.backgroundView.addSubview(self.actionButton)
        
        interval = 0
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(deviceOrientationDidChange(sender:)),
            name: NSNotification.Name.UIDeviceOrientationDidChange,
            object: nil
        )
        
    }
    
    @objc func deviceOrientationDidChange(sender: AnyObject?) {
        updateView()
    }
    
    required convenience public init?(coder aDecoder: NSCoder) {
        self.init()
    }

    
    func updateView() {
        
        let deviceWidth = UIScreen.main.bounds.width
        let constraintSize = CGSize(width: deviceWidth * (260.0 / 320.0), height: CGFloat.greatestFiniteMagnitude)
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
        self.messageLabel.center = CGPoint(x: self.messageLabel.center.x, y: self.backgroundView.center.y)
        
        self.actionButton.frame = CGRect(
            x: deviceWidth - 51,
            y: 5,
            width: buttonWidth,
            height: buttonWidth
        )
        self.setViewToBottom()
        
    }
    
    public func makeSnackbar(message : String?, actionButtonTitle : String?, interval : TimeInterval , actionButtonBlock : @escaping ((DGSnackbar) -> Void), dismisBlock : @escaping ((DGSnackbar) -> Void))-> (){
        
        self.messageLabel.text = message
        self.actionButton.setTitle(actionButtonTitle, for: UIControlState.normal)
        self.interval = interval
        self.actionBlock = actionButtonBlock
        self.dismissBlock = dismisBlock
        show()
    }
    
    public func makeSnackbar(message : String?, actionButtonImage : UIImage?, interval : TimeInterval , actionButtonBlock : @escaping ((DGSnackbar) -> Void), dismisBlock : @escaping ((DGSnackbar) -> Void))-> (){
        
        
        let status = UserDefaults.standard.bool(forKey: "DGSnackbar")
        
        if status {
            self.dismissSnackBar()
        }
        
        self.messageLabel.text = message
        self.actionButton.setImage(actionButtonImage, for: UIControlState.normal)
        self.interval = interval
        self.actionBlock = actionButtonBlock
        self.dismissBlock = dismisBlock
        show()
    }
    
    public func makeSnackbar(message : String?, interval : TimeInterval, dismisBlock : @escaping ((DGSnackbar) -> Void)) -> () {
        self.messageLabel.text = message
        self.actionButton.setTitle("", for: UIControlState.normal)
        self.interval = interval
        self.dismissBlock = dismisBlock
        show()
        
    }
    
    func setViewToBottom() {
        let screenSize = UIScreen.main.bounds.size
        self.frame = CGRect(x: 0, y: screenSize.height , width: screenSize.width, height: self.backgroundView.frame.size.height);
    }
    
    func showView() {
        let screenSize = UIScreen.main.bounds.size
        self.frame = CGRect(x: 0, y: screenSize.height - self.backgroundView.frame.size.height - 2, width: screenSize.width, height: self.backgroundView.frame.size.height);
    }
    
    override public var window: UIWindow {
        for window in UIApplication.shared.windows {
            if NSStringFromClass(type(of: window)) == "UITextEffectsWindow" {
                return window
            }
        }
        return UIApplication.shared.windows.first!
    }
    
    func show() {
        
        DispatchQueue.main.async {
            self.updateView()
            self.alpha = 0
            self.window.addSubview(self)
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                options: UIViewAnimationOptions.curveEaseOut,
                animations: {
                    self.showView()
                    self.alpha = 1
                },
                completion: nil)
            self.dismisTimer = Timer.scheduledTimer(timeInterval: self.interval, target: self, selector: #selector(self.dismissSnackBar), userInfo: nil, repeats: false)
            
        }
    }
    
    @objc func dismissSnackBar() {
        self.dismisTimer.invalidate()
        UIView.animate(
            withDuration: 0.0,
            delay: 0,
            options: UIViewAnimationOptions.curveEaseIn,
            animations: {
                self.setViewToBottom()
                self.alpha = 0
            },
            completion: { animation in
                self.dismissBlock!(self)
                self.removeFromSuperview()
        })
    }
    
    @objc func onActionButtonPressed(button : UIButton!) {
        self.actionBlock!(self)
        dismissSnackBar()
    }
}

