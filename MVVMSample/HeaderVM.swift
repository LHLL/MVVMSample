//
//  HeaderVM.swift
//  MVVMSample
//
//  Created by 李玲 on 4/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit
import JXTableManager

class HeaderVM {
    fileprivate var realData:String!
}

extension HeaderVM:Manageable{
    
    var identifier:String{return "HeaderView"}
    
    var type:AnyClass{return Content.self}
    
    func updateData(data:Any){
        if let data = data as? String {
            realData = data
        }
    }
}

extension HeaderVM:HeaderViewDataSource{
    var title:String{return realData}
}
