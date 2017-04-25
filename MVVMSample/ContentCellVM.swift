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
    fileprivate var realData:String!
}

extension ContentCellVM:CellTags{
    
    var viewHight:CGFloat{return UITableViewAutomaticDimension}
    
    var identifier:String{return "BeautifulCell"}
    
    var type:Any{return ""}
    
    func updateData(_ data:Any) {
        if data is String {
            realData = data as! String
        }
    }
    
    func selectionHandler(_ indexPath: IndexPath) {
        delegate.didSelectCell(indexPath)
    }
}

extension ContentCellVM:ContentCellDataSource {
    var title:String{return realData}
}
