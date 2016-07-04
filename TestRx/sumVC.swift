//
//  sumVC.swift
//  TestRx
//
//  Created by xuyazhong on 16/7/3.
//  Copyright © 2016年 fishtrip. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa



class sumVC: UIViewController {

    @IBOutlet weak var num1: UITextField!
    @IBOutlet weak var num2: UITextField!
    @IBOutlet weak var num3: UITextField!
    
    @IBOutlet weak var result: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ok")
        Observable.combineLatest(num1.rx_text, num2.rx_text, num3.rx_text) { (TextValue1, TextValue2, TextValue3) -> Int in
            return (Int(TextValue1) ?? 0) + (Int(TextValue2) ?? 0) + (Int(TextValue3) ?? 0)
            }
            .map { $0.description }
            .bindTo(result.rx_text)

    }
}
