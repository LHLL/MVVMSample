//
//  ContentCellVM.swift
//  MVVMSample
//
//  Created by 李玲 on 4/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit
import JXTableManager

class Content{
    var color:UIColor
    var content:String
    
    init(c:UIColor,str:String) {
        color = c
        content = str
    }
}

protocol ContentCellVMDelegate{
    func didSelectCell(_ indexPath:IndexPath)
}

class ContentCellVM {
    var delegate:ContentCellVMDelegate!
    private var realData:Content!
}

extension ContentCellVM:Manageable{
    
    var identifier:String{return "BeautifulCell"}
    
    var type:AnyClass{return Content.self}
    
    func updateData(data:Any) {
        if let data = data as? Content {
            realData = data 
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        delegate.didSelectCell(indexPath)
    }
}

extension ContentCellVM:ContentCellDataSource {
    var title:String{return realData.content}
    var color:UIColor{return realData.color}
}
