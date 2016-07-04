//
//  ViewController.swift
//  TestRx
//
//  Created by xuyazhong on 16/7/2.
//  Copyright © 2016年 fishtrip. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa

enum Error:ErrorType {
    case Test
}

class ViewController: UIViewController{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        .addDisposableTo(DisposeBag())
        

//        ["🍏","🍎","🍐"].toObservable()
//        Observable.of(["🍏","🍎","🍐"])
//        .subscribe { (event) in
//            print(event)
//        }.addDisposableTo(DisposeBag())
//        
//        
//        create("🍓").subscribe { (event) in
//            print(event)
//        }.addDisposableTo(DisposeBag())
        
        /*
        testNet()
        submit.addTarget(self, action: #selector(ViewController.actionClick), forControlEvents: .TouchUpInside)
//        Observable.of(1,2,3)
//            .map{ $0 * 3 }
//        .subscribe { (event) in
//            print(event)
//        }.addDisposableTo(DisposeBag())
        
        
        
        let disposeBag = DisposeBag()
        
        let subject1 = BehaviorSubject(value: "🍎")
        let subject2 = BehaviorSubject(value: "🐶")
        
        let variable = Variable(subject1)
        
        variable.asObservable()
            .concat()
            .subscribe({ (event) in
                print(event)
            })
            .addDisposableTo(disposeBag)
        
        subject1.onNext("🍐")
        subject1.onNext("🍊")
        subject2.onNext("🚗")
        variable.value = subject2
        subject1.onNext("🎯")
        subject2.onNext("I would be ignored")
        subject2.onNext("🐱")
        
        subject1.onCompleted()
        
        subject2.onNext("🐭")
        

        
        /**
         empty
         只发送Completed消息
         */
        Observable<Int>.empty()
            .subscribe { event in
                print(event)
        }.addDisposableTo(DisposeBag())

        /**
         never
         没有任何元素、也不会发送任何消息
         */
        
        Observable<String>.never()
        .subscribe { (event) in
            print("this is never be exec")
        }.addDisposableTo(DisposeBag())
    

        /**
         *  just
         先发送Next,然后发送Completed
         */
        Observable.just("😄")
        .subscribe { (event) in
            print(event)
        }.addDisposableTo(DisposeBag())

        
        /**
         *  of
         把一系列元素转成事件
         */
        Observable.of("0","1","2","3")
        .subscribe { (event) in
            print(event)
        }.addDisposableTo(DisposeBag())
        
        
        /**
         *  toObservable
         把数组或者字典转成事件,最后发一个Complleted
         */
        ["🐶","🐱","🐭","🐹"].toObservable()
        .subscribe { (event) in
            print(event)
        }.addDisposableTo(DisposeBag())
        
        
        /**
         *  create
         通过 .on 添加事件
         */
        let subObser = create("😂")
        subObser.subscribe { (event) in
            print(event)
        }.addDisposableTo(DisposeBag())
        
        
        /**
         range
         
         */
        Observable.range(start: 1, count: 10)
        .subscribe { (event) in
            print(event)
        }.addDisposableTo(DisposeBag())
        
        
        /**
         *  repeatElement
         */
        Observable.repeatElement("😡")
            .take(3)
        .subscribe { (event) in
            print(event)
        }.addDisposableTo(DisposeBag())
        
        
        
        
        Observable.generate(initialState: 0, condition: { (ele) -> Bool in
            return ele < 3
            }) { (ele) -> Int in
                return ele + 1
        }.subscribe { (event) in
            print(event)
        }.addDisposableTo(DisposeBag())
        
        
        let def = deferred()
        def.subscribe { (event) in
            print(event)
        }.addDisposableTo(DisposeBag())
        
        let erred = deferred()
        erred.subscribe { (event) in
            print(event)
        }.addDisposableTo(DisposeBag())
        
        
        
        
        /**
         error
        */
        Observable<Int>.error(Error.Test)
        .subscribe { (event) in
            print(event)
        }.addDisposableTo(DisposeBag())
        
        */
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    
    
    
    
    func deferred() -> Observable<String> {
        debugPrint("creating")
        return Observable.create({ (observer) -> Disposable in
            observer.onNext("🐯")
            observer.onNext("🦁")
            observer.onNext("🐮")
            return NopDisposable.instance
        })
    }
    func create(ele:String) -> Observable<String> {
        return Observable.create { (observer) -> Disposable in
            observer.on(.Next(ele))
            observer.on(.Completed)
            return NopDisposable.instance
        }
    }
    
//    func testNet() {
//        let req = NSURLRequest(URL: NSURL(string: "http://www.baidu.com")!)
//        web.loadRequest(req)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

