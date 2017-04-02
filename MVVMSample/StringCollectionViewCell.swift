//
//  StringCollectionViewCell.swift
//  MVVMSample
//
//  Created by 李玲 on 4/1/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

/*
 Everytime you create one cell, make sure you follow steps:
    1. Make sure you use Space instead of Tab to insert space
    2. Instead of subclassing UICollectionViewCell, subclass WFColletionCell
    3. Everytime you create one cell, you should also create one associated protocol.
       Remember! YOU are the one who is responsible for guaranteeing your protocol has enough
       properties to populate UI and methods to handle User Interaction!!!
*/
protocol StringCellDataSource {
    var title:String{get}
}

class StringCollectionViewCell: WFCollectionCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //Don't forget to override this method! This method is where magic happens.
    override func configureCell<T>(t: T) {
        //Since we don't have a Binder class and Your leads (such as Tabari(Gaussian Blur applied) and Marc(Gaussian Blur applied)) don't beleive in "Binder"
        //You, again, become the one who is responsible for binding them together
        if t is StringCellVM {
            titleLabel.text = (t as! StringCellVM).title
        }
    }
}
