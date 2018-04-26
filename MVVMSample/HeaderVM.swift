//
//  HeaderVM.swift
//  MVVMSample
//
//  Created by 李玲 on 4/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

class HeaderVM {
    fileprivate var realData:String!
}

extension HeaderVM:Manageable{
    
    var identifier:String{return "HeaderView"}
    
    var type:AnyClass{return Content.self}
    
    func updateData(data:Any){
        if data is String {
            realData = data as! String
        }
    }
}

extension HeaderVM:HeaderViewDataSource{
    var title:String{return realData}
}
