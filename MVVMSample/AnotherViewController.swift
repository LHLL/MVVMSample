//
//  AnotherViewController.swift
//  MVVMSample
//
//  Created by 李玲 on 4/1/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

class AnotherViewController: UIViewController {
    
    @IBOutlet weak var myBeautifulList: UICollectionView!

    //MARK:Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1. Register xib
        myBeautifulList.register(UINib(nibName: "ThirdCollectionViewCell", bundle: nil),
                                 forCellWithReuseIdentifier: "ImgCell")
        
        // 2. Set Delegate
        CollectionFactory.shared.delegate = self
        
        // 3. Register xib's associated view model
        let _ = CollectionFactory.shared.registerViewModel(vm: ThirdCellVM())
        
        // 4. Hook up
        myBeautifulList.dataSource = CollectionFactory.shared
        myBeautifulList.delegate = CollectionFactory.shared
        
        // 5. Bad Apple Code
        automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension AnotherViewController:FactoryDataSource{
    var dataContainer:[Any]{return [#imageLiteral(resourceName: "gg"),#imageLiteral(resourceName: "aa"),#imageLiteral(resourceName: "bb"),#imageLiteral(resourceName: "ss")]}
}
