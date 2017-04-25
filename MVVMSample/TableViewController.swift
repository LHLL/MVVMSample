//
//  TableViewController.swift
//  MVVMSample
//
//  Created by 李玲 on 4/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var myBeautifulTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableFactory.shared.delegate = self
        myBeautifulTable.delegate = TableFactory.shared
        myBeautifulTable.dataSource = TableFactory.shared
        myBeautifulTable.register(UINib(nibName: "ContentCell", bundle: nil), forCellReuseIdentifier: "BeautifulCell")
        myBeautifulTable.estimatedRowHeight = 35
        myBeautifulTable.estimatedSectionHeaderHeight = 35
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let vm = TableFactory.shared.registerViewModel(vm: ContentCellVM()) as! ContentCellVM
        vm.delegate = self
        
        let _ = TableFactory.shared.registerHeader(header: HeaderVM())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension TableViewController:ContentCellVMDelegate {
    func didSelectCell(_ indexPath: IndexPath) {
        myBeautifulTable.cellForRow(at: indexPath)?.shrink()
    }
}

extension TableViewController:TableDataSource {
    var dataContainer:Array<[Any]>{
        return [
            ["Love Love Love","YoYoYo\nNoNoNo\nHoHoHo"],
            ["Love Love Love","YoYoYo\nNoNoNo\nHoHoHo"],
            ["Love Love Love","YoYoYo\nNoNoNo\nHoHoHo"]
        ]
    }
    var headerContainer:[Any?]?{
        return [
            "Nightmare Trigger",
            nil,
            "Good Dream Trigger"
        ]
    }
}
