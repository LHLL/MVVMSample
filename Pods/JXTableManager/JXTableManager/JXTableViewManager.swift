//
//  JXTableViewManager.swift
//  JXTableViewManager
//
//  Created by Jay, Xu on 4/2/17.
//  Copyright © 2017 Joker. All rights reserved.
//

import UIKit

public class JXTableViewManager: NSObject {
    
    internal var vms: [Manageable] = [Manageable]()
    internal var dataContainer: [UnsafeMutableRawPointer:[Array<Any>]] = [:]
    internal var headerViews: [UnsafeMutableRawPointer:[TableViewSectionHeader]] = [:]
    internal var cellEditActions: [UnsafeMutableRawPointer:[TableViewCellEditActions]] = [:]
    
    @discardableResult
    public func registerViewModel(vm: Manageable) -> Manageable {
        for viewModel in vms {
            guard vm.type == object_getClass(vm) else{continue}
            return viewModel
        }
        vms.append(vm)
        return vm
    }
    
    public func register(data:[Array<Any>],for tableView:UITableView){
        dataContainer[Unmanaged.passUnretained(tableView).toOpaque()] = data
    }
    
    public func register(headerView:[TableViewSectionHeader],for tableView:UITableView){
        headerViews[Unmanaged.passUnretained(tableView).toOpaque()] = headerView
    }
    
    public func register(editActions:[TableViewCellEditActions],for tableView:UITableView){
        cellEditActions[Unmanaged.passUnretained(tableView).toOpaque()] = editActions
    }
}

extension JXTableViewManager: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = dataContainer[Unmanaged.passUnretained(tableView).toOpaque()] else{return 0}
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = dataContainer[Unmanaged.passUnretained(tableView).toOpaque()] else{return 0}
        return sections[section].count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        for vm in vms {
            guard let count = dataContainer[Unmanaged.passUnretained(tableView).toOpaque()]?.count else{continue}
            guard indexPath.section < count else{continue}
            guard let sections = dataContainer[Unmanaged.passUnretained(tableView).toOpaque()] else{continue}
            let rowItems = sections[indexPath.section]
            guard indexPath.row < rowItems.count else{continue}
            guard vm.type == object_getClass(rowItems[indexPath.row]) else{continue}
            vm.updateData(data: rowItems[indexPath.row])
            guard let cell = tableView.dequeueReusableCell(withIdentifier: vm.identifier, for: indexPath) as? ManagedTableCell else{continue}
            cell.configureCell(t: vm)
            return cell
        }
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
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
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let sections = cellEditActions[Unmanaged.passUnretained(tableView).toOpaque()] else{return false}
        for action in sections {
            if action.indexPath == indexPath {
                return true
            }
        }
        return false
    }
    
}

extension JXTableViewManager: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
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
        
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let headers = headerViews[Unmanaged.passUnretained(tableView).toOpaque()] else{return UITableView.automaticDimension}
        for header in headers {
            if header.section == section {
                return header.height
            }
        }
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headers = headerViews[Unmanaged.passUnretained(tableView).toOpaque()] else{return nil}
        for header in headers {
            if header.section == section {
                return header.headerView as? UIView
            }
        }
        return nil
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for vm in vms {
            vm.didScroll?(at: scrollView)
        }
    }
}
