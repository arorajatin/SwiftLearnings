//
//  JAAppRater.swift
//  JAAppRater
//
//  Created by Jatin Arora on 19/02/16.
//  Copyright © 2016 Jatin Arora. All rights reserved.
//

import Foundation
import UIKit

public class JAAppRater: NSObject, UIAlertViewDelegate {
    
    public let JA_TOTAL_LAUNCHES = "com.jatinarora.totalLaunchesBeforePopup"
    public let JA_RATING_POPUP_SHOWN = "com.jatinarora.ratingPopupShown"
    
    var application: UIApplication!
    var userDefaults = NSUserDefaults()
    let minimumLaunchesRequiredBeforeLaunch = 0
    public static var sharedInstance = JAAppRater()
    public var appID: String?
    
    //MARK: Initialize
    override init() {
        super.init()
        setup()
    }
    
    func setup() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appDidFinishLaunching:", name:UIApplicationDidFinishLaunchingNotification , object: nil)
    }
    
    func appDidFinishLaunching(notification : NSNotification) {
        
        if let _application = notification.object as? UIApplication {
            self.application = _application
            displayRatingsPopupIfRequired()
        }
        
    }
    
    //MARK: Ratings
    private func displayRatingsPopupIfRequired() {
        
        let totalLaunches = getLaunchCount()
        if totalLaunches >= minimumLaunchesRequiredBeforeLaunch {
            showPopup()
        }
        
        incrementLaunchCount()
    }
    
    func showPopup() {
        
        let appName = NSBundle(forClass: self.application.delegate!.dynamicType).infoDictionary!["CFBundleName"] as? String
        let title = "Rate Us"
        let message = "Would you like to rate the app \(appName!)?"
        let notNow = "Not Now"
        
        if #available(iOS 8.0, *) {
            
            //Use AlertViewController
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            let notNowAction = UIAlertAction(title: notNow, style: .Cancel, handler: { (action) -> Void in
                self.resetLaunchCount()
            })
            
            let rateAction = UIAlertAction(title: "Rate Us", style: .Default, handler: { (action) -> Void in
                
                let url = NSURL(string: "itms-apps://itunes.apple.com/app/id\(self.appID)")
                UIApplication.sharedApplication().openURL(url!)
                
                self.setAppRatingShown(true)
            })
            
            alertController.addAction(notNowAction)
            alertController.addAction(rateAction)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                let window = self.application.windows[0]
                window.rootViewController!.presentViewController(alertController, animated: true, completion: nil)
                
            })
            
        } else {
            
            //Use UIAlertView
            
            let alertView = UIAlertView(title: title, message: message, delegate: self, cancelButtonTitle: notNow, otherButtonTitles: title)
            alertView.show()
            
        }
        
        incrementLaunchCount()
    }
    
    //MARK: App Launch Count
    func incrementLaunchCount() {
        
        var totalLaunches = userDefaults.integerForKey(JA_TOTAL_LAUNCHES)
        totalLaunches = totalLaunches + 1
        userDefaults.setInteger(totalLaunches, forKey: JA_TOTAL_LAUNCHES)
        userDefaults.synchronize()
        
    }
    
    func resetLaunchCount() {
        userDefaults.setInteger(0, forKey: JA_TOTAL_LAUNCHES)
        userDefaults.synchronize()
    }
    
    func getLaunchCount() -> Int {
        
        if let totalLaunches = userDefaults.valueForKey(JA_TOTAL_LAUNCHES) as? Int {
            return totalLaunches
        }
        
        return 0
    }
    
    func setAppRatingShown(shown : Bool) {
        
        userDefaults.setBool(true, forKey: JA_RATING_POPUP_SHOWN)
        userDefaults.synchronize()
        
    }
    
    //MARK: UIAlertViewDelegate 
    
    public func alertViewCancel(alertView: UIAlertView) {
        resetLaunchCount()
    }
    
    public func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        let url = NSURL(string: "itms-apps://itunes.apple.com/app/id\(self.appID)")
        UIApplication.sharedApplication().openURL(url!)
        
        self.setAppRatingShown(true)
    }
}