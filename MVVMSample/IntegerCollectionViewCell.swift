//
//  IntegerCollectionViewCell.swift
//  MVVMSample
//
//  Created by 李玲 on 4/1/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

protocol IntegerCellProtocol {
    var number:Int{get}
    func viberateHandler(sender:UIButton)
}

class IntegerCollectionViewCell: WFCollectionCell {

    @IBOutlet weak var numBtn: UIButton!
    
    var handler:((_ sender:UIButton)->Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func configureCell<T>(t: T) {
        if t is IntegerCellVM {
            numBtn.setTitle("\((t as! IntegerCellVM).number)", for: .normal)
            handler = {
                (t as! IntegerCellVM).viberateHandler(sender:)
            }()
            numBtn.addTarget(self, action: #selector(getter: handler), for: .touchUpInside)
        }
    }
}
