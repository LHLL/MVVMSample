//
//  TableViewController.swift
//  MVVMSample
//
//  Created by 李玲 on 4/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak private var myBeautifulTable: UITableView!
    
    private let vm = TableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        vm.configTableView(myBeautifulTable)
    }

}

