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

class HeaderView:GenericHeaderView {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var top: NSLayoutConstraint!
    
    private var reverse = false
    private var timer:Timer!

    @IBAction func trigger(_ sender: UISwitch) {
        if !sender.isOn {
            timer.invalidate()
            self.progress.progress = 0
        }
        updateHandler(section)
        reverse = !reverse
    }
    
    override func configureHeaderView<T>(t: T) {
        if t is HeaderVM {
            statusLabel.text = (t as! HeaderVM).title
        }
    }
    
    override func updateUI() {
        if !reverse {
            self.top.constant = -2
            self.progress.isHidden = true
        }else {
            self.top.constant = 8
            self.progress.isHidden = false
            countDown()
        }
    }
    
    private func countDown(){
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
            guard self.progress.progress != 1 else {
                timer.invalidate()
                self.shake()
                return
            }
            DispatchQueue.main.async {
                self.progress.progress += 0.1
            }
        })
    }
}
