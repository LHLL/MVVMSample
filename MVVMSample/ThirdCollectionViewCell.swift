//
//  ThirdCollectionViewCell.swift
//  MVVMSample
//
//  Created by 李玲 on 4/2/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit
import JXCollectionManager

protocol ThirdDataSource {
    var img:UIImage{get}
}

class ThirdCollectionViewCell: ManagedCollectionCell {

    @IBOutlet weak var thumbnail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configureCell<T>(t: T) {
        if t is ThirdCellVM {
            let i = (t as! ThirdCellVM).img
            thumbnail.image = i
        }
    }

}
