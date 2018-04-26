//
//  ContentCell.swift
//  MVVMSample
//
//  Created by 李玲 on 4/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

protocol ContentCellDataSource {
    var title:String{get}
    var color:UIColor{get}
}

class ContentCell: ManagedTableCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var indicator: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indicator.layer.cornerRadius = indicator.bounds.height/2
    }
    
    override func configureCell<T>(t: T) {
        if t is ContentCellVM {
            titleLabel.text = (t as! ContentCellVM).title
            indicator.backgroundColor = (t as! ContentCellVM).color
        }
    }
    
}
