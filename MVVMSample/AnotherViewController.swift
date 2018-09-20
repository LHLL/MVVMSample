//
//  AnotherViewController.swift
//  MVVMSample
//
//  Created by 李玲 on 4/1/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit
import JXCollectionManager

class AnotherViewController: UIViewController {
    
    @IBOutlet weak var myBeautifulList: UICollectionView!

    private let manager = JXCollectionManager()
    //MARK:Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1. Register xib
        myBeautifulList.register(UINib(nibName: "ThirdCollectionViewCell", bundle: nil),
                                 forCellWithReuseIdentifier: "ImgCell")
        
        // 3. Register xib's associated view model
        let _ = manager.registerViewModel(vm: ThirdCellVM())
        
        // 4. Hook up
        myBeautifulList.dataSource = manager
        myBeautifulList.delegate = manager
        
        // 5. Bad Apple Code
        automaticallyAdjustsScrollViewInsets = false
        
        manager.register(data: [#imageLiteral(resourceName: "gg"),#imageLiteral(resourceName: "aa"),#imageLiteral(resourceName: "bb"),#imageLiteral(resourceName: "ss")], for: myBeautifulList)
    }
}
