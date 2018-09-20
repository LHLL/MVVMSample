//
//  JXCollectionManager.swift
//  JXCollectionManager
//
//  Created by Jay, Xu on 4/2/17.
//  Copyright © 2017 Joker. All rights reserved.
//

import UIKit

public class JXCollectionManager:NSObject {
    
    internal var vms:[Manageable] = [Manageable]()
    internal var dataContainer: [UnsafeMutableRawPointer:[Any]] = [:]
    
    @discardableResult
    public func registerViewModel(vm: Manageable) -> Manageable {
        for viewModel in vms {
            guard vm.type == object_getClass(vm) else{continue}
            return viewModel
        }
        vms.append(vm)
        return vm
    }
    
    public func register(data:[Any],for collectionView:UICollectionView){
        dataContainer[Unmanaged.passUnretained(collectionView).toOpaque()] = data
    }
}

extension JXCollectionManager:UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let rows = dataContainer[Unmanaged.passUnretained(collectionView).toOpaque()] else{return 0}
        return rows.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell:UICollectionViewCell?
        for vm in vms {
            guard let rows = dataContainer[Unmanaged.passUnretained(collectionView).toOpaque()] else{continue}
            guard vm.type == object_getClass(rows[indexPath.row]) else{continue}
            vm.updateData(data: rows[indexPath.row])
            cell = collectionView.dequeueReusableCell(withReuseIdentifier:vm.identifier, for: indexPath)
            guard let managed = cell as? ManagedCollectionCell else{continue}
            managed.configureCell(t: vm)
            return managed
        }
        return cell ?? UICollectionViewCell()
    }
}

extension JXCollectionManager:UICollectionViewDelegateFlowLayout{
    
   public func collectionView(_ collectionView: UICollectionView,
                              layout collectionViewLayout: UICollectionViewLayout,
                              sizeForItemAt indexPath: IndexPath) -> CGSize {
        for vm in vms{
            guard let rows = dataContainer[Unmanaged.passUnretained(collectionView).toOpaque()] else{continue}
            guard vm.type == object_getClass(rows[indexPath.row]) else{continue}
            guard let size = vm.viewSize else{continue}
            return size
        }
        return CGSize.zero
    }
}

