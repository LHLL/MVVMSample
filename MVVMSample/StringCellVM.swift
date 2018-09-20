//
//  StringCellVM.swift
//  MVVMSample
//
//  Created by 李玲 on 4/1/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit
import JXCollectionManager

class StringCellVM:Manageable {
    
    var viewSize:CGSize{return CGSize(width: 335, height: 66)}
    var identifier:String{return "stringCell"}
    var type: AnyClass = Account.self
    private var realData:Account!
    
    func updateData(data: Any) {
        if let data = data as? Account {
            self.realData = data
        }
    }
}

extension StringCellVM:StringCellDataSource {
    var title:String{return realData.name}
}
