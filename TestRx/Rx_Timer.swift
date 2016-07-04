//
//  Rx_Timer.swift
//  TestRx
//
//  Created by xuyazhong on 16/7/4.
//  Copyright © 2016年 fishtrip. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class Rx_Timer: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var text: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scheduler = MainScheduler.instance
        let subscription = Observable<Int>.interval(1, scheduler: scheduler)
        .subscribe { (event) in
            self.label.text = String(event.element!)
        }

        text.rx_controlEvent(.EditingChanged).subscribe { (event) in
            print(self.text.text!)
        }
        
        
    }
}