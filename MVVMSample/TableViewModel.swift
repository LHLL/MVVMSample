//
//  TableViewModel.swift
//  MVVMSample
//
//  Created by 李玲 on 4/25/18.
//  Copyright © 2018 Jay. All rights reserved.
//

import UIKit

class TableViewModel{
    
    private var manager = TableViewManager()
    private weak var table:UITableView?
    
    func configTableView(_ tableview:UITableView) {
        table = tableview
        tableview.delegate = manager
        tableview.dataSource = manager
        tableview.register(UINib(nibName: "ContentCell", bundle: nil), forCellReuseIdentifier: "BeautifulCell")
        tableview.estimatedRowHeight = 35
        tableview.estimatedSectionHeaderHeight = 35
        
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
                         for: tableview)
        let header1 = Bundle.main.loadNibNamed("HeaderView", owner: nil, options: nil)?.last as! HeaderView
        header1.statusLabel.text = "This is first section"
        let header2 = Bundle.main.loadNibNamed("HeaderView", owner: nil, options: nil)?.last as! HeaderView
        header2.statusLabel.text = "This is second section"
        manager.register(headerView: [
            TableViewSectionHeader(headerView: header1, section: 0),
            TableViewSectionHeader(headerView: header2, section: 1)
            ],
                         for: tableview)
        manager.registerViewModel(vm: HeaderVM())
    }
    
}

extension TableViewModel:ContentCellVMDelegate {
    func didSelectCell(_ indexPath: IndexPath) {
        table?.cellForRow(at: indexPath)?.shrink()
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
