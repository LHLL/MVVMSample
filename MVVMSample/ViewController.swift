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

    override func viewDidLoad() {
        super.viewDidLoad()
        myBeautifulList.register(UINib(nibName: "StringCollectionViewCell", bundle: nil),
                                 forCellWithReuseIdentifier: "stringCell")
        myBeautifulList.register(UINib(nibName: "IntegerCollectionViewCell", bundle: nil),
                                 forCellWithReuseIdentifier: "IntCell")
        CollectionFactory.shared.delegate = self
        CollectionFactory.shared.registerViewModel(vm: StringCellVM())
        CollectionFactory.shared.registerViewModel(vm: IntegerCellVM())
        myBeautifulList.dataSource = CollectionFactory.shared
        myBeautifulList.delegate = CollectionFactory.shared
        automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController:FactoryDataSource{
    var dataContainer:[Any]{return ["one",1,"two",2,"three",3,"Four",4,"five",5]}
}
