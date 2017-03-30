//
//  DataSource.swift
//  MVVMSample
//
//  Created by 李玲 on 3/29/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

class CollectionFactory:NSObject {
    
    var vms:[WFCollectionViewModule] = []
}

extension CollectionFactory:UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        for vm in vms {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath)
            cell.configureCell(t: vm)
            return cell
        }
        return UICollectionViewCell()
    }
}

typealias Tags = WFCollectionCellDataSource&WFCollectionCellDelegate
protocol WFCollectionCellDataSource {}
protocol WFCollectionCellDelegate {}
extension UICollectionViewCell {
    func configureCell<T:Tags>(t:T){}
}

class WFCollectionViewModule:Tags{}


/*
 https://www.natashatherobot.com/swift-2-0-protocol-oriented-mvvm/
 http://stackoverflow.com/questions/41876754/a-collection-view-with-multiple-prototype-cells-and-a-generic-way-of-handling-th
*/
