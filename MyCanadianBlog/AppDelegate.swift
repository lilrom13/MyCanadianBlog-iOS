//
//  AppDelegate.swift
//  MyCanadianBlog
//
//  Created by Romain Margheriti on 01/08/2016.
//  Copyright © 2016 Romain Margheriti. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import TwitterKit
import Material
import OAuthSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyboard: UIStoryboard?
    var rootViewController: UIViewController?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]
        let pushNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        
        self.storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.rootViewController = self.window?.rootViewController
        
        Fabric.sharedSDK().debug = true
        Fabric.with([Crashlytics.self, Twitter.self])
        
        application.registerUserNotificationSettings(pushNotificationSettings)
        application.registerForRemoteNotifications()
        
        if let options = launchOptions {
            print(options)
        }
        return true
    }
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        if (url.host == "oauth-callback") {
            OAuthSwift.handleOpenURL(url)
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
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        print("DEVICE TOKEN = \(deviceToken)")
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print(error)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        if let postId = userInfo["postId"] as? String {
            print(postId)
            
            let api = EVWordPressAPI(wordpressOauth2Settings: Wordpress.wordpressOauth2Settings, site: Wordpress.siteName)
            
            api.postById(postId) { post in
                if (post != nil) {
                    for child in (self.rootViewController?.childViewControllers)! {
                        if child.restorationIdentifier == "LastestPostsNavigationController"{
                            let lastestPostsTableViewController = (child.childViewControllers[0]) as! LastestPostsTableViewController
                            let simplePostVC = (self.storyboard?.instantiateViewControllerWithIdentifier("PostViewController"))! as! PostViewController
                            
                            simplePostVC.post = post
                            lastestPostsTableViewController.navigationController?.pushViewController(simplePostVC, animated: true)
                        }
                    }
                } else {
                    print("An error occurred")
                }
            }
            
        }
    }
}

