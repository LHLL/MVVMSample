//
//  TableViewManager.swift
//  TableViewManager
//
//  Created by ASAJ on 4/2/17.
//  Copyright © 2017 ASAJ. All rights reserved.
//

import UIKit

final class TableViewManager: NSObject {
    
    override init() {}
    
    private var vms: [Manageable] = [Manageable]()
    private var dataContainer: [UnsafeMutableRawPointer:[Array<Any>]] = [:]
    private var headerViews: [UnsafeMutableRawPointer:[TableViewSectionHeader]] = [:]
    private var cellEditActions: [UnsafeMutableRawPointer:[TableViewCellEditActions]] = [:]
    
    @discardableResult
    func registerViewModel(vm: Manageable) -> Manageable {
        for viewModel in vms {
            guard vm.type == object_getClass(vm) else{continue}
            return viewModel
        }
        vms.append(vm)
        return vm
    }
    
    func register(data:[Array<Any>],for tableView:UITableView){
        dataContainer[Unmanaged.passUnretained(tableView).toOpaque()] = data
    }
    
    func register(headerView:[TableViewSectionHeader],for tableView:UITableView){
        headerViews[Unmanaged.passUnretained(tableView).toOpaque()] = headerView
    }
    
    func register(editActions:[TableViewCellEditActions],for tableView:UITableView){
        cellEditActions[Unmanaged.passUnretained(tableView).toOpaque()] = editActions
    }
}

extension TableViewManager: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = dataContainer[Unmanaged.passUnretained(tableView).toOpaque()] else{return 0}
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = dataContainer[Unmanaged.passUnretained(tableView).toOpaque()] else{return 0}
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        for vm in vms {
            guard let count = dataContainer[Unmanaged.passUnretained(tableView).toOpaque()]?.count else{continue}
            guard indexPath.section < count else{continue}
            guard let sections = dataContainer[Unmanaged.passUnretained(tableView).toOpaque()] else{continue}
            let rowItems = sections[indexPath.section]
            guard indexPath.row < rowItems.count else{continue}
            guard vm.type == object_getClass(rowItems[indexPath.row]) else{continue}
            vm.updateData(data: rowItems[indexPath.row])
            guard let _ = tableView.dequeueReusableCell(withIdentifier: vm.identifier) else{continue}
            let cell = tableView.dequeueReusableCell(withIdentifier: vm.identifier, for: indexPath) as! ManagedTableCell
            cell.configureCell(t: vm)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        guard let sections = cellEditActions[Unmanaged.passUnretained(tableView).toOpaque()] else{
            return []
        }
        for action in sections {
            if action.indexPath == indexPath {
                return action.editAction
            }
        }
        return []
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let sections = cellEditActions[Unmanaged.passUnretained(tableView).toOpaque()] else{return false}
        for action in sections {
            if action.indexPath == indexPath {
                return true
            }
        }
        return false
    }
    
}

extension TableViewManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        for vm in vms {
            guard let count = dataContainer[Unmanaged.passUnretained(tableView).toOpaque()]?.count else{continue}
            guard indexPath.section < count else{continue}
            guard let sections = dataContainer[Unmanaged.passUnretained(tableView).toOpaque()] else{continue}
            let rowItems = sections[indexPath.section]
            guard indexPath.row < rowItems.count else{continue}
            guard vm.type == object_getClass(rowItems[indexPath.row]) else{continue}
            guard let rowHeight = vm.rowHeight else{continue}
            return rowHeight
        }
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for vm in vms {
            guard let count = dataContainer[Unmanaged.passUnretained(tableView).toOpaque()]?.count else{continue}
            guard indexPath.section < count else{continue}
            guard let sections = dataContainer[Unmanaged.passUnretained(tableView).toOpaque()] else{continue}
            let rowItems = sections[indexPath.section]
            guard indexPath.row < rowItems.count else{continue}
            guard vm.type == object_getClass(rowItems[indexPath.row]) else{continue}
            vm.didSelectRow?(at: indexPath)
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let headers = headerViews[Unmanaged.passUnretained(tableView).toOpaque()] else{return 0}
        for header in headers {
            if header.section == section {
                return UITableViewAutomaticDimension
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headers = headerViews[Unmanaged.passUnretained(tableView).toOpaque()] else{return nil}
        for header in headers {
            if header.section == section {
                return header.headerView as? UIView
            }
        }
        return nil
    }
    
}

typealias Manageable = ManagedTableCellDataSource&ManagedTableCellDelegate

@objc protocol ManagedTableCellDataSource {
    
    var identifier: String { get }
    
    var type: AnyClass { get }
    
    @objc optional var rowHeight: CGFloat { get }
    
    /*
     Useage:
     class VM: Tags {
        private var realData: Int = 0
        func updateData(_ data: Any) {
            if data is Int {
            self.realData = data as! Int
         }
     }
    */
    func updateData(data: Any)
}

/// Empty Protocol here for you to add any methods you need.
@objc protocol ManagedTableCellDelegate {
    
    
    /// Tells the delegate that the specified row is now selected.
    ///
    /// - Parameter indexPath: An index path locating the new selected row in tableView.
    @objc optional func didSelectRow(at indexPath: IndexPath)

}

/// Should be super class of Cell Instead of UITableViewCell
class ManagedTableCell: UITableViewCell {
    func configureCell<T>(t:T) {}
}

// MARK: - Utility
class TableViewSectionHeader {
    
    /// Pass Class Of Cell Type so VM can Handle
    var headerView: Any
    /// Section Header
    var section: Int
    
    init(headerView: Any, section: Int) {
        self.headerView = headerView
        self.section = section
    }
}

class TableViewCellEditActions {
    
    /// Pass Edit Actions to Display with Cell
    var editAction = [UITableViewRowAction] ()
    /// IndexPath For Cell in TableFactory
    var indexPath: IndexPath
    
    init(editAction: [UITableViewRowAction], indexPath: IndexPath) {
        self.editAction = editAction
        self.indexPath = indexPath
    }
}
