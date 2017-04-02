//
//  DataSource.swift
//  MVVMSample
//
//  Created by 李玲 on 3/29/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

//Why VVVVVVVVVVVM? My mother taught me a long enough title will catch eyes.
//Why class? -----------------  You have to be a class to adopt UICollectionViewDataSource 🤷‍♀️
//                           🔝
protocol FactoryDataSource:class{
    var dataContainer:[Any]{get}
}

class CollectionFactory:NSObject {
    static let shared = CollectionFactory()
    //Why vms become private now? Because this can become super duper ugly if you have a lot of viewmodels
    //Thanks for keeping my factory clean
    fileprivate var vms:[Tags] = [Tags]()
    fileprivate var types:[AnyClass] = [AnyClass]()
    weak var delegate:FactoryDataSource?
    
    /*
     Why private? Educate your user, I create singlton, so you have to use it.
     Under protest? Sorry, I am psycho control freak.
     */
    private override init() {}
    
    //Hotel reception: please register your view model here, yes, all of them, "where is your ID?"
    func registerViewModel(vm:Tags,type:AnyClass){
        let exist = vms.contains {type(of: $0) == type(of:vm)}
        if !exist {
            vms.append(vm)
            types.append(type)
        }
    }
}

extension CollectionFactory:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //In case someone forget to set delegate, don't laugh, it could happen to anyone, not only baby dev.
        guard let _ = delegate else {return 0}
        return delegate!.dataContainer.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        for i in 0..<vms.count {
            guard types[i] === type(of: delegate!.dataContainer[indexPath.row]) as! AnyClass else{break}
            vms[i].updateData(delegate!.dataContainer[indexPath.row])
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:vms[i].identifier, for: indexPath)
            
            //As I said, you have to subclass WFCollectionCell
            guard cell is WFCollectionCell else {break}
            (cell as! WFCollectionCell).configureCell(t: vms[i])
            return cell
        }
        return UICollectionViewCell()
    }
}

extension CollectionFactory:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        for i in 0..<vms.count {
            guard types[i] === type(of: delegate!.dataContainer[indexPath.row]) as! AnyClass else{break}
            return vms[i].viewSize
        }
        return CGSize.zero
    }
}

typealias Tags = WFCollectionCellDataSource&WFCollectionCellDelegate

protocol WFCollectionCellDataSource{
    //This is your cell size
    var viewSize:CGSize{get}
    //This is your cell reuse identifier
    var identifier:String{get}
    /*
     Useage:
     class VM:Tags {
        private var realData:Int = 0
        func updateData(_ data: Any) {
            if data is Int {
            self.realData = data as! Int
        }
     }
     */
    func updateData(_ data:Any)
}

protocol WFCollectionCellDelegate {}

/*
 This class should be super class your cell instead of UICollectionViewCell
 I know some of you might think this retarded guy create a class intead of write an extension to UICollectionview?
 Yes, because you have to override this method. Because we don't have a binder.
 */
class WFCollectionCell:UICollectionViewCell {
    func configureCell<T>(t:T){}
}

