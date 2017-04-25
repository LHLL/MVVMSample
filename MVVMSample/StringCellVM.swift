//
//  StringCellVM.swift
//  MVVMSample
//
//  Created by 李玲 on 4/1/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

class StringCellVM:Tags {
    
    var viewSize:CGSize{return CGSize(width: 335, height: 66)}
    var identifier:String{return "stringCell"}
    var type: Any = Account(n:"Sample")
    fileprivate var realData:Account!
    
    func updateData(_ data: Any) {
        if data is Account {
            self.realData = data as! Account
        }
    }
}

extension StringCellVM:StringCellDataSource {
    var title:String{return realData.name}
}
