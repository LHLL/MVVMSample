//
//  ManagedComponents.swift
//  Manageable
//
//  Created by Xu, Jay on 4/26/18.
//  Copyright © 2018 Joker. All rights reserved.
//

import UIKit

public typealias Manageable = ManagedCellDataSource&ManagedCellDelegate

@objc
public protocol ManagedCellDataSource {
    
    var identifier: String { get }
    
    var type: AnyClass { get }
    
    @objc optional var rowHeight: CGFloat { get }
    @objc optional var viewSize:CGSize{get}
    
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
@objc
public protocol ManagedCellDelegate {
    
    
    /// Tells the delegate that the specified row is now selected.
    ///
    /// - Parameter indexPath: An index path locating the new selected row in tableView.
    @objc optional func didSelectRow(at indexPath: IndexPath)
    @objc optional func didScroll(at scrollView:UIScrollView)
    
}

/// Should be super class of Cell Instead of UITableViewCell
open class ManagedTableCell: UITableViewCell {
    open func configureCell<T>(t:T) {}
}

// MARK: - Utility
open class TableViewSectionHeader {
    
    /// Pass Class Of Cell Type so VM can Handle
    open var headerView: Any
    /// Section Header
    open var section: Int
    
    open var height = UITableView.automaticDimension
    
    public init(headerView: Any, section: Int) {
        self.headerView = headerView
        self.section = section
    }
}

open class TableViewCellEditActions {
    
    /// Pass Edit Actions to Display with Cell
    open var editAction = [UITableViewRowAction] ()
    /// IndexPath For Cell in TableFactory
    open var indexPath: IndexPath
    
    public init(editAction: [UITableViewRowAction], indexPath: IndexPath) {
        self.editAction = editAction
        self.indexPath = indexPath
    }
}

open class ManagedCollectionCell:UICollectionViewCell {
    open func configureCell<T>(t:T){}
}
