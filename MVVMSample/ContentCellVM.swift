//
//  ContentCellVM.swift
//  MVVMSample
//
//  Created by 李玲 on 4/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

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
        if data is Content {
            realData = data as! Content
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
