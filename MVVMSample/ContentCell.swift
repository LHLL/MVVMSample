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
}

class ContentCell: GenericCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configureCell<T>(t: T) {
        if t is ContentCellVM {
            titleLabel.text = (t as! ContentCellVM).title
        }
    }
    
}
