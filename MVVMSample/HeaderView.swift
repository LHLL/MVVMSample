//
//  HeaderView.swift
//  MVVMSample
//
//  Created by 李玲 on 4/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

protocol HeaderViewDataSource {
    var title:String{get}
}

class HeaderView:UIView {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var top: NSLayoutConstraint!
    
    private var reverse = false
    private var timer:Timer!

    @IBAction func trigger(_ sender: UISwitch) {
        
    }
    
}
