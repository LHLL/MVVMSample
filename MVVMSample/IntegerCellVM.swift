//
//  IntegerCellModel.swift
//  MVVMSample
//
//  Created by 李玲 on 4/1/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

class IntegerCellVM:Tags {
    var viewSize:CGSize{return CGSize(width: 244, height: 44)}
    var identifier:String{return "IntCell"}
    fileprivate var realData:Int = 0
    
    func updateData(_ data: Any) {
        if data is Int {
            self.realData = data as! Int
        }
    }
}

extension IntegerCellVM:IntegerCellProtocol {
    var number:Int{return realData}
    func viberateHandler(sender:UIButton){
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        sender.layer.add(animation, forKey: "viberate")
    }
}
