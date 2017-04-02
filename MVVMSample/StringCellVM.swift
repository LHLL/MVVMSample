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
    var type: Any = "String"
    fileprivate var realData:String!
    
    func updateData(_ data: Any) {
        if data is String {
            self.realData = data as! String
        }
    }
}

extension StringCellVM:StringCellDataSource {
    var title:String{return realData}
}
