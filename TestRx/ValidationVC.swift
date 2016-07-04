//
//  ValidationVC.swift
//  TestRx
//
//  Created by xuyazhong on 16/7/3.
//  Copyright © 2016年 fishtrip. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa



class ValidationVC: UIViewController {
    
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var passwdTips: UILabel!
    @IBOutlet weak var usernameTips: UILabel!
    @IBOutlet weak var passwdTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let minNum = 5
        
        let dispose = DisposeBag()
        
        usernameTips.text = "至少\(minNum)位"
        passwdTips.text = "至少\(minNum)位"
        
        let usernameValidation = usernameTF.rx_text.map {
            $0.characters.count >= minNum
        }.shareReplay(1)
        
        let passwdValidation = passwdTF.rx_text.map{
            $0.characters.count >= minNum
        }.shareReplay(1)
        
        let allValidation = Observable.combineLatest(usernameValidation, passwdValidation) { (user, pass) -> Bool in
            return user && pass
        }
        
        usernameValidation.bindTo(usernameTips.rx_hidden)
        usernameValidation.bindTo(passwdTF.rx_enabled)
        
        
        passwdValidation.bindTo(passwdTips.rx_hidden)
        allValidation.bindTo(submit.rx_enabled)
        
        
        
        
        
    }

    @IBAction func clickAction(sender: AnyObject) {
        let alert = UIAlertView(title: "success", message: nil, delegate: nil, cancelButtonTitle: "ok")
        alert.show()
    }
}
