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

    override func viewDidLoad() {
        super.viewDidLoad()
        myBeautifulList.register(UINib(nibName: "ThirdCollectionViewCell", bundle: nil),
                                 forCellWithReuseIdentifier: "ImgCell")
        CollectionFactory.shared.delegate = self
        CollectionFactory.shared.registerViewModel(vm: ThirdCellVM())
        myBeautifulList.dataSource = CollectionFactory.shared
        myBeautifulList.delegate = CollectionFactory.shared
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
