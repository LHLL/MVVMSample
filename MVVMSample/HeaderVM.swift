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

extension HeaderVM:FactoryViewDataSource{
    
    var viewHight:CGFloat{return UITableViewAutomaticDimension}
    
    var identifier:String{return "HeaderView"}
    
    var type:Any{return ""}
    
    func updateData(_ data:Any){
        if data is String {
            realData = data as! String
        }
    }
}

extension HeaderVM:HeaderViewDataSource{
    var title:String{return realData}
}
