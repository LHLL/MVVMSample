//
//  ThirdCellVM.swift
//  MVVMSample
//
//  Created by 李玲 on 4/2/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

class ThirdCellVM:Tags {
    var type: Any = UIImage()
    var viewSize:CGSize{return CGSize(width: UIScreen.main.bounds.width, height: 128)}
    var identifier:String{return "ImgCell"}
    fileprivate var realData:UIImage = UIImage()
    
    func updateData(_ data: Any) {
        if data is UIImage {
            self.realData = data as! UIImage
        }
    }
}

extension ThirdCellVM:ThirdDataSource {
    var img:UIImage{return realData}
}
