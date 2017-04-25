//
//  Utility.swift
//  MVVMSample
//
//  Created by 李玲 on 4/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

protocol Shakeable {}
extension Shakeable where Self:UIView{
    func shake(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4, y: self.center.y))
        layer.add(animation, forKey: "position")
    }
}
extension GenericHeaderView:Shakeable{}

protocol Shrinkable{}
extension Shrinkable where Self:UIView {
    func shrink(){
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = 0.25
        animation.autoreverses = true
        animation.fromValue = 1
        animation.toValue = 1.5
        layer.add(animation, forKey: "scale")
    }
}
extension UITableViewCell:Shrinkable{}
