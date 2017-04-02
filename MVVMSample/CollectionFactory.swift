//
//  DataSource.swift
//  MVVMSample
//
//  Created by ASAJ on 3/29/17.
//  Copyright © 2017 ASAJ. All rights reserved.
//

import UIKit

//Why VVVVVVVVVVVM? My mother taught me a long enough title will catch eyes.
//Why class? -----------------  You have to be a class to adopt UICollectionViewDataSource 🤷‍♀️
//                           🔝
protocol FactoryDataSource:class{
    //This holds data coming from each controller.
    var dataContainer:[Any]{get}
}

class CollectionFactory:NSObject {
    static let shared = CollectionFactory()
    //Why vms become private now? Because this can become super duper ugly if you have a lot of viewmodels
    //Thanks for keeping my factory clean
    fileprivate var vms:[Tags] = [Tags]()
    //Why weak?
    //Come on, if you really asked this question, please resign.
    weak var delegate:FactoryDataSource?
    
    /*
     Why private? Educate your user, I create singlton, so you have to use it.
     Under protest? Sorry, I am psycho control freak.
     */
    private override init() {}
    
    //Hotel reception: please register your view model here, yes, all of them, "where is your ID?"
    func registerViewModel(vm:Tags){
        let existed = vms.contains {object_getClassName($0.type) == object_getClassName(vm.type)}
        if !existed {
            vms.append(vm)
        }
    }
}

extension CollectionFactory:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //In case someone forgets to set delegate, don't laugh, it could happen to anyone, not only baby dev.
        guard let _ = delegate else {return 0}
        return delegate!.dataContainer.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        for vm in vms {
            if object_getClassName(vm.type) == object_getClassName(delegate!.dataContainer[indexPath.row]) {
                vm.updateData(delegate!.dataContainer[indexPath.row])
                //If you forget to subclassWFCollectionCell, App will crash because of next line!!!!
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier:vm.identifier, for: indexPath) as! WFCollectionCell
                cell.configureCell(t: vm)
                return cell
            }
        }
        return UICollectionViewCell()
    }
}

extension CollectionFactory:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        for vm in vms{
            if object_getClassName(vm.type) == object_getClassName(delegate!.dataContainer[indexPath.row]){
                return vm.viewSize
            }
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
    //This is your cell's associated type
    //I know there is AssociatedType for protocol, it just doesn't work
    var type:Any{get}
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

//I have this empty protocol here for you to add any methods you need for p164 here.
//Why we have two separate protocols when we can just have one?
//Because I like separating them, bite me?
protocol WFCollectionCellDelegate {}

/*
 This class should be super class your cell instead of UICollectionViewCell
 I know some of you might think this retarded guy create a class intead of write an extension to UICollectionview?
 Yes, because you have to override this method. Because we don't have a binder.
 */
class WFCollectionCell:UICollectionViewCell {
    func configureCell<T>(t:T){}
}

