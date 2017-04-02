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
        CollectionFactory.shared.delegate = self
        CollectionFactory.shared.registerViewModel(vm: StringCellVM(),type: String.self as! AnyClass)
        CollectionFactory.shared.registerViewModel(vm: IntegerCellVM(),type: Int.self as! AnyClass)
        myBeautifulList.dataSource = CollectionFactory.shared
        myBeautifulList.delegate = CollectionFactory.shared
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        myBeautifulList.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController:FactoryDataSource{
    //I told you it should be Anyclass instead of Any
    var dataContainer:[Any]{return ["one",1,"two","2","three",3,"Four","4","five",5]}
}
