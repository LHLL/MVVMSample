//
//  TableFactory.swift
//  MVVMSample
//
//  Created by 李玲 on 4/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

protocol TableDataSource:class{
    var dataContainer:Array<[Any]>{get}
    var headerContainer:[Any?]?{get}
}

final class TableFactory: NSObject {
    static let shared = TableFactory()
    
    fileprivate var vms:[CellTags] = [CellTags]()
    fileprivate var headers:[FactoryViewDataSource] = [FactoryViewDataSource]()
    
    weak var delegate:TableDataSource?
    
    private override init() {}
    
    func registerViewModel(vm:CellTags)->CellTags{
        let existed = vms.filter {object_getClassName($0.type) == object_getClassName(vm.type)}
        if existed.isEmpty {
            vms.append(vm)
            return vm
        }else {
            return existed.first!
        }
    }
    
    func registerHeader(header:FactoryViewDataSource) -> FactoryViewDataSource {
        let existed = headers.filter {object_getClassName($0.identifier) == object_getClassName(header.identifier)}
        if existed.isEmpty {
            headers.append(header)
            return header
        }else {
            return existed.first!
        }
    }
}

extension TableFactory:UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard delegate != nil else {return 0}
        return delegate!.dataContainer.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate!.dataContainer[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        for vm in vms {
            if object_getClassName(vm.type) == object_getClassName(delegate!.dataContainer[indexPath.section][indexPath.row]) {
                vm.updateData(delegate!.dataContainer[indexPath.section][indexPath.row])
                let cell = tableView.dequeueReusableCell(withIdentifier: vm.identifier, for: indexPath) as! GenericCell
                cell.configureCell(t: vm)
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension TableFactory:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        for vm in vms {
            if object_getClassName(vm.type) == object_getClassName(delegate!.dataContainer[indexPath.section][indexPath.row]) {
                vm.selectionHandler(indexPath)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        for vm in vms {
            if object_getClassName(vm.type) == object_getClassName(delegate!.dataContainer[indexPath.section][indexPath.row]) {
                return vm.viewHight
            }
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        for header in headers {
            guard delegate!.headerContainer != nil else {return UITableViewAutomaticDimension}
            if object_getClassName(header.type) == object_getClassName(delegate!.headerContainer![section]) {
                return header.viewHight
            }
        }
        //Line 98 will cause an empty gray header, if you dont want any headerView, set 0
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        for header in headers {
            guard delegate!.headerContainer![section] != nil else {return nil}
            header.updateData(delegate!.headerContainer![section]!)
            var hView = tableView.dequeueReusableHeaderFooterView(withIdentifier: header.identifier) as? GenericHeaderView
            if hView == nil {
                hView = UINib(nibName: header.identifier, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? GenericHeaderView
            }
            hView?.configureHeaderView(t: header)
            hView?.section = section
            hView?.updateHandler = { index in
                let temp = tableView.headerView(forSection: index) as! GenericHeaderView
                DispatchQueue.main.async {
                    tableView.beginUpdates()
                    temp.updateUI()
                    tableView.endUpdates()
                    
                }
            }
            return hView
        }
        return nil
    }
}

typealias CellTags = FactoryViewDataSource&FactoryDelegate

//MARK: Cell
protocol FactoryViewDataSource {
    
    var viewHight:CGFloat{get}
    
    var type:Any{get}
    
    func updateData(_ data:Any)
    
    var identifier:String{get}
}

protocol FactoryDelegate {
    func selectionHandler(_ indexPath:IndexPath)
}


class GenericCell:UITableViewCell {
    func configureCell<T>(t:T){}
}

//MARK: Header
class GenericHeaderView:UITableViewHeaderFooterView {
    var section = 0
    var updateHandler:((Int)->Void)!
    
    func configureHeaderView<T>(t:T){}
    func updateUI(){}
}
