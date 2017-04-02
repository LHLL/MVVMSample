//
//  DependencyLoadingService.swift
//  MVVMSample
//
//  Created by 李玲 on 3/29/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

class DependencyLoading:NSObject, ApplicationService {
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        //Let's pretend to have a Reachability class
        Reachability.shared.checkInternetAccessbility()
        
        //let str1 = String(describing: )
        //let str2 = String(describing: UIView())
//        var ss = [AnyClass]()
//        if ss[0] === type(of: "ss") as! AnyClass {
//        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        Reachability.shared.stopMonitotingReachability()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        Reachability.shared.startMonitoringReachability()
    }
}

extension DependencyLoading:ReachabilityDelegate {
    
    func didLostInternetConnection() {
        /*
         Please Remember this name, next time anything breaks including you forgot your AD-ENT password, make sure you call 
         this guy before step 2.
         */
        print("Siri, call Andrew Martinez...")
    }
}
