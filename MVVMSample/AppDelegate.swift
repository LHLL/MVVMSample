//
//  AppDelegate.swift
//  MVVMSample
//
//  Created by 李玲 on 3/29/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: LifeCycleService {
    
    //Again, this should not be computed property if you don't have LifeCycleService class!!!!!!!!!
    override var services: [ApplicationService] {
        return [    /*
                       Here is checkin list and checkin is mandatory for every one!
                    */
                    LifeCycleService(),
                    DependencyLoading()
               ]
    }
}

