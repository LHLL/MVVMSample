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
    
    private var vm:IntegerCellVM!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func vibrate(_ sender: UIButton) {
        vm.viberateHandler(sender: sender)
    }
    
    override func configureCell<T>(t: T) {
        if t is IntegerCellVM {
            numBtn.setTitle("\((t as! IntegerCellVM).number)", for: .normal)
            vm = (t as! IntegerCellVM)
        }
    }
}
