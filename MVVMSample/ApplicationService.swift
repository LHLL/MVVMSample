//
//  ApplicationService.swift
//  MVVMSample
//
//  Created by 李玲 on 3/29/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

protocol ApplicationService:UIApplicationDelegate {}

class LifeCycleService:UIResponder,ApplicationService {
    
    var window: UIWindow?
    
    //Why computed? For AppDelegate to override. It should not be computed property if you don't adopt this structure.
    var services:[ApplicationService] {
        return []
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        for service in services {
            service.applicationDidFinishLaunching?(application)
        }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        for service in services {
            service.applicationWillResignActive?(application)
        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        for service in services {
            service.applicationDidEnterBackground?(application)
        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        for service in services {
            service.applicationWillEnterForeground?(application)
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        for service in services {
            service.applicationDidBecomeActive?(application)
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        for service in services {
            service.applicationWillTerminate?(application)
        }
    }
    /* To be continued...
       I know you don't like the word technologically, so theoretically, you should (another bad word here) implement all methods in the UIApplicationDelegate!!! Why I don't do it? Yes, you are right, because I am lazy. Although lazy is a good word to describe a developer.
     */
}
