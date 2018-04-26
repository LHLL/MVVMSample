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
    
    private var manager = TableViewManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myBeautifulTable.delegate = manager
        myBeautifulTable.dataSource = manager
        myBeautifulTable.register(UINib(nibName: "ContentCell", bundle: nil), forCellReuseIdentifier: "BeautifulCell")
        myBeautifulTable.estimatedRowHeight = 35
        myBeautifulTable.estimatedSectionHeaderHeight = 35
        automaticallyAdjustsScrollViewInsets = false
        
        let vm = manager.registerViewModel(vm: ContentCellVM()) as! ContentCellVM
        vm.delegate = self
        manager.register(data: [
            [
                Content(c: .red, str: "Hello World"),
                Content(c: .cyan, str: "This is message from first section")
            ],
            [
                Content(c: .yellow, str: "Hi there"),
                Content(c: .green, str: "This is message from second section")
            ]
        ],
                         for: myBeautifulTable)
        let header1 = Bundle.main.loadNibNamed("HeaderView", owner: nil, options: nil)?.last as! HeaderView
        header1.statusLabel.text = "This is first section"
        let header2 = Bundle.main.loadNibNamed("HeaderView", owner: nil, options: nil)?.last as! HeaderView
        header2.statusLabel.text = "This is second section"
        manager.register(headerView: [
            TableViewSectionHeader(headerView: header1, section: 0),
            TableViewSectionHeader(headerView: header2, section: 1)
        ],
                         for: myBeautifulTable)
        manager.registerViewModel(vm: HeaderVM())
    }

}

extension TableViewController:ContentCellVMDelegate {
    func didSelectCell(_ indexPath: IndexPath) {
        myBeautifulTable.cellForRow(at: indexPath)?.shrink()
    }
}

class Content{
    var color:UIColor
    var content:String
    
    init(c:UIColor,str:String) {
        color = c
        content = str
    }
}
