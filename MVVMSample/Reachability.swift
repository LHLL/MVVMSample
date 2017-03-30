//
//  Reachability.swift
//  MVVMSample
//
//  Created by 李玲 on 3/29/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation

class Reachability {
    
    static let shared = Reachability()
    
    /*
     Why private? Educate your user, I create singlton, so you have to use it. 
     Under protest? Sorry, I am psycho contral freak.
    */
    private init(){}
    
    func checkInternetAccessbility(){
    
    }
    
    func startMonitoringReachability(){
    }
    
    func stopMonitotingReachability(){
    }
    
}

protocol ReachabilityDelegate:class {
    
    func didLostInternetConnection()
}
