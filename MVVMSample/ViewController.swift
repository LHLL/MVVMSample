//
//  ViewController.swift
//  MVVMSample
//
//  Created by 李玲 on 3/29/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myBeautifulList: UICollectionView!

    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1. Register all xibs
        myBeautifulList.register(UINib(nibName: "StringCollectionViewCell", bundle: nil),
                                 forCellWithReuseIdentifier: "stringCell")
        myBeautifulList.register(UINib(nibName: "IntegerCollectionViewCell", bundle: nil),
                                 forCellWithReuseIdentifier: "IntCell")
        // 2. Set Delegate
        CollectionFactory.shared.delegate = self
        
        // 3. Register all xibs' associated view models
        CollectionFactory.shared.registerViewModel(vm: StringCellVM())
        CollectionFactory.shared.registerViewModel(vm: IntegerCellVM())
        
        // 4. Hook up
        myBeautifulList.dataSource = CollectionFactory.shared
        myBeautifulList.delegate = CollectionFactory.shared
        
        // 5. Bad Apple Code
        automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController:FactoryDataSource{
    //This is simulate data from server, so it can have different types of class coverted from Json
    var dataContainer:[Any]{return ["one",1,"two",2,"three",3,"Four",4,"five",5]}
}
