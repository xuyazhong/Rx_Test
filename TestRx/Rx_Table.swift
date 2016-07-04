//
//  Rx_Table.swift
//  TestRx
//
//  Created by xuyazhong on 16/7/3.
//  Copyright © 2016年 fishtrip. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


class Rx_Table: UIViewController,UITableViewDelegate {
    
    let dataSource = Variable([BasicModel]())
    
    
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        
        let initialValue = [ BasicModel(name: "Jack", age: 18), BasicModel(name: "Tim", age: 20), BasicModel(name: "Andy", age: 24) ]
        dataSource.asObservable()
            .bindTo(table.rx_itemsWithCellIdentifier(String(UITableViewCell), cellType: UITableViewCell.self)) { (_,element,cell) in
                cell.textLabel?.text = "name:\(element.name) age:\(element.age)"
        }
        dataSource.value.appendContentsOf(initialValue)
        
        table.registerClass(UITableViewCell.self, forCellReuseIdentifier: String(UITableViewCell))
        let item = Observable.just(["🍏","🍎","🍐","🍊"])
        table.rx_itemSelected.subscribeNext { (indexPath) in
            let model = initialValue[indexPath.row]
            debugPrint("index:\(indexPath.row) model:\(model)")
        }
        
        
    }
    
    
}