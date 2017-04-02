//
//  CollectionGenerater.swift
//  MVVMSample
//
//  Created by 李玲 on 4/1/17.
//  Copyright © 2017 Jay. All rights reserved.
//


import UIKit

//Why VVVVVVVVVVVM? My mother taught me a long enough title will catch eyes.
//Why class? -----------------  You have to be a class to adopt UICollectionViewDataSource 🤷‍♀️
//                           🔝
protocol DataSource:class{
    var sectionNum:Int{get}
    var itemNum:Int{get}
    func shouldReloadCollectionView()
}

class CollectionGenerater:NSObject {
    static let shared = CollectionGenerater()
    //Why vms become private now? Because this can become super duper ugly if you have a lot of viewmodels
    //Thanks for keeping my factory clean
    var vms:[Bags] = []
    weak var delegate:DataSource?
    
    /*
     Why private? Educate your user, I create singlton, so you have to use it.
     Under protest? Sorry, I am psycho control freak.
     */
    private override init() {}
}

extension CollectionGenerater:UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //In case someone forget to set delegate, don't laugh, it could happen to anyone, not only baby dev.
        guard let _ = delegate else {return 0}
        return delegate!.sectionNum
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //In case someone forget to set delegate, don't laugh, it could happen to anyone, not only baby dev.
        guard let _ = delegate else {return 0}
        return delegate!.itemNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        for vm in vms {
            for range in vm.ranges {
                if range .contains(indexPath.row) {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: vm.identifier, for: indexPath)
                    (cell as! CollectionCell).configureCell(t: vm)
                }
            }
        }
        return UICollectionViewCell()
    }
}

extension CollectionGenerater:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        for vm in vms {
            for range in vm.ranges {
                if range .contains(indexPath.row) {
                    return vm.viewSize
                }
            }
        }
        return CGSize.zero
    }
}

typealias Bags = CollectionCellDataSource&CollectionCellDelegate

protocol CollectionCellDataSource{
    //This is your cell size
    var viewSize:CGSize{get}
    //This is your cell reuse identifier
    var identifier:String{get}
    
    var ranges:[Range<Int>]{get}
}

protocol CollectionCellDelegate {}

/*
 This class should be super class your cell instead of UICollectionViewCell
 I know some of you might think this retarded guy create a class intead of write an extension to UICollectionview?
 Yes, because you have to override this method. Because we don't have a binder.
 */
class CollectionCell:UICollectionViewCell {
    func configureCell<T>(t:T){}
}
