//
//  ThirdCellVM.swift
//  MVVMSample
//
//  Created by 李玲 on 4/2/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit
import JXCollectionManager

class ThirdCellVM:Manageable {
    var type: AnyClass = UIImage.self
    var viewSize:CGSize{return CGSize(width: UIScreen.main.bounds.width, height: 128)}
    var identifier:String{return "ImgCell"}
    fileprivate var realData:UIImage = UIImage()
    func updateData(data: Any) {
        if data is UIImage {
            self.realData = data as! UIImage
        }
    }
}

extension ThirdCellVM:ThirdDataSource {
    var img:UIImage{return realData}
}
