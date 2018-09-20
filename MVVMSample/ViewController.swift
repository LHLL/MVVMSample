//
//  ViewController.swift
//  MVVMSample
//
//  Created by 李玲 on 3/29/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit
import JXCollectionManager

class ViewController: UIViewController {
    
    @IBOutlet weak var myBeautifulList: UICollectionView!
    
    private var manager = CollectionManager()
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1. Register all xibs
        myBeautifulList.register(UINib(nibName: "StringCollectionViewCell", bundle: nil),
                                 forCellWithReuseIdentifier: "stringCell")
        
        // 3. Register all xibs' associated view models
        let _ = manager.registerViewModel(vm: StringCellVM())
        
        // 4. Hook up
        myBeautifulList.dataSource = manager
        myBeautifulList.delegate = manager
        
        // 5. Bad Apple Code
        automaticallyAdjustsScrollViewInsets = false
        manager.register(data: [Account(n:"One"),Account(n:"Two"),Account(n:"Three"),Account(n:"Four"),Account(n:"Five")],
                         for: myBeautifulList)
    }

}
