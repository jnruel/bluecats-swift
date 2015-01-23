//
//  AppDelegate.swift
//  BlueCatsTest
//
//  Created by Joe Ruel on 1/22/15.
//  Copyright (c) 2015 Joseph Ruel. All rights reserved.
//


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, BCMicroLocationManagerDelegate {
    
    var window: UIWindow?
    
    var microLocationManager: BCMicroLocationManager?
    var appToken: String = "app won't work until you put the app token from BlueCats into here."
    
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Override point for customization after application launch.
        
        microLocationManager = BCMicroLocationManager.sharedManager()
        self.microLocationManager!.delegate = self
        
        BlueCatsSDK.setAppToken(self.appToken)
        
        let purring: Void = BlueCatsSDK.startPurring { (status: BCStatus) -> Void in
            if(status == BCStatus.PurringWithErrors)
            {
                println("Errors...")
                let tokenVerificationStatus = BlueCatsSDK.appTokenVerificationStatus()
                if(tokenVerificationStatus == BCAppTokenVerificationStatus.NotProvided || tokenVerificationStatus == BCAppTokenVerificationStatus.Invalid)
                {
                    if(tokenVerificationStatus == BCAppTokenVerificationStatus.NotProvided)
                    {
                        //BlueCatsSDK.setAppToken(self.appToken)
                        println("no token")
                    }
                    else if(tokenVerificationStatus == BCAppTokenVerificationStatus.Invalid)
                    {
                        //app token invalid
                        println("invalid token")
                    }
                }
                if(!BlueCatsSDK.isLocationAuthorized())
                {
                    println("Location usage hasn't been authorized")
                    BlueCatsSDK.requestAlwaysLocationAuthorization()
                }
                if(!BlueCatsSDK.isNetworkReachable())
                {
                    //output if no network connection
                    println("No network connection")
                }
                if(!BlueCatsSDK.isBluetoothEnabled())
                {
                    println("Bluetooth is disabled")
                }
                
            }
            else
            {
                println("Awww yeah, no errors, yet")
                
            }
            
            
            self.microLocationManager!.startUpdatingMicroLocation()
            
            
        }
        
        if(application.respondsToSelector("registerUserNotificationSettings:")) {
            application.registerUserNotificationSettings(
                UIUserNotificationSettings(
                    forTypes: UIUserNotificationType.Alert | UIUserNotificationType.Sound,
                    categories: nil
                )
            )
        }
        
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    
    
    
    
    
    func requestStateForNearbySites()
    {
        let nearbySites = self.microLocationManager!.nearbySites
        println(nearbySites.count)
        
        nearbySites.enumerateObjectsUsingBlock { (elem, idx, stop) -> Void in
            println("\(idx): \(elem)")
        }
        
        
        
    }
    
    
    //    BCMicroLocationDelegate Methods
    
    func microLocationManager(microLocationManager: BCMicroLocationManager!, didUpdateNearbySites sites: [AnyObject]!) {
        println("did update nearby sites")
    }
    
    func microLocationManager(microLocationManager: BCMicroLocationManager!, didEnterSite site: BCSite!) {
        println("entered a site")
    }
    
    func microLocationManager(microLocationManager: BCMicroLocationManager!, didUpdateMicroLocations microLocations: [AnyObject]!) {
        println("did update micro locations")
        self.requestStateForNearbySites()
    }
    
    
    
    func microLocationManager(microLocationManager: BCMicroLocationManager!, didStartMonitoringForSite site: BCSite!) {
        println("did start monitoring")
    }
    
    
    
    
}

