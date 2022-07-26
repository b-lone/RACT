//
//  ViewController.swift
//  RACT
//
//  Created by 尤坤 on 2022/7/25.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class ViewController: UIViewController {
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        bind()
//        bind2()
//        bindMap()
//        bindOn()
//        bindTake()
//        bindTake2()
//        bindMerge()
//        bindCombineLatest()
//        bindZip()
//        bindProducer()
//        bindProperty()
//        bindMutableProperty()
        bindInput()
    }
    
    private func bind() {
        let (signal, innerObserver) = Signal<Int, Never>.pipe()
        let outerObserver1 = Signal<Int, Never>.Observer(value: { value in
            print("did received value: \(value)")
        })
        let outerObserver2 = Signal<Int, Never>.Observer { event in
            switch event {
            case let .value(value):
                print("did received value: \(value)")
            default: break
            }
        }

        signal.observe(outerObserver1)
        signal.observe(outerObserver2)
        
        innerObserver.send(value: 1)
        innerObserver.sendCompleted()
    }
    
    private func bind2() {
        let (signal, innerObserver) = Signal<Int, Never>.pipe()
        signal.observeValues { value in
            print("did received value: \(value)")
        }
        signal.observeValues { value in
            print("did received value: \(value)")
        }
        innerObserver.send(value: 1)
        innerObserver.sendCompleted()
    }
    
    private func bindMap() {
        let (signal, innerObserver) = Signal<Int, Never>.pipe()
        signal.observeValues { value in
            print("did received value: \(value)")
        }
        signal.observeValues { value in
            print("did received value: \(value)")
        }
        
        signal.map { value in
            return "xxx \(value)"
        }.observeValues { string in
            print(string)
        }
        
        innerObserver.send(value: 1)
        innerObserver.sendCompleted()
    }
    
    private func bindOn() {
        let (signal, innerObserver) = Signal<Int, Never>.pipe()
        signal.observeValues { value in
            print("did received value: \(value)")
        }
        signal.observeValues { value in
            print("did received value: \(value)")
        }
        
        signal.on(value: { value in
            print("on value: \(value)")
        }).observeValues { value in
            print("did received value: \(value)")
        }

        innerObserver.send(value: 1)
        innerObserver.sendCompleted()
    }
    
    private func bindTake() {
        let (signal, innerObserver) = Signal<Int, Never>.pipe()
        let (takeSignal, takeObserver) = Signal<(), Never>.pipe()
        
        signal.take(until: takeSignal).observe { event in
            print("received value:\(event)")
        }

        innerObserver.send(value: 1)
        innerObserver.send(value: 2)
        
        takeObserver.send(value: ())
        innerObserver.send(value: 3)
        
        takeObserver.sendCompleted()
        innerObserver.sendCompleted()
    }
    
    private func bindTake2() {
        let (signal, innerObserver) = Signal<Int, Never>.pipe()
        //只取最初N次的Event
        signal.take(first: 2).observe { event in
            print("recceived value:\(event)")
        }
        
        innerObserver.send(value: 1)
        innerObserver.send(value: 2)
        innerObserver.send(value: 3)
        innerObserver.send(value: 4)
        
        innerObserver.sendCompleted()
    }
    
    private func bindMerge() {
        let (signal1, innerObserver1) = Signal<Int, Never>.pipe()
        let (signal2, innerObserver2) = Signal<Int, Never>.pipe()
        let (signal3, innerObserver3) = Signal<Int, Never>.pipe()
        
        Signal.merge(signal1, signal2, signal3).observeValues { value in
            print("received value:\(value)")
        }
        
        innerObserver1.send(value: 1)
        innerObserver1.sendCompleted()
        
        innerObserver2.send(value: 2)
        innerObserver2.sendCompleted()
        
        innerObserver3.send(value: 3)
        innerObserver3.sendCompleted()
    }
    
    private func bindCombineLatest() {
        let (signal1, innerObserver1) = Signal<Int, Never>.pipe()
        let (signal2, innerObserver2) = Signal<Int, Never>.pipe()
        let (signal3, innerObserver3) = Signal<Int, Never>.pipe()
        
        Signal.combineLatest(signal1, signal2, signal3).observeValues { tuple in
            print("received value:\(tuple)")
        }
        
        innerObserver1.send(value: 1)
        innerObserver2.send(value: 2)
        innerObserver3.send(value: 3)
        
        innerObserver1.send(value: 11)
        innerObserver2.send(value: 22)
        innerObserver3.send(value: 33)
        
        innerObserver1.sendCompleted()
        innerObserver2.sendCompleted()
        innerObserver3.sendCompleted()
    }
    
    private func bindZip() {
        let (signal1, innerObserver1) = Signal<Int, Never>.pipe()
        let (signal2, innerObserver2) = Signal<Int, Never>.pipe()
        let (signal3, innerObserver3) = Signal<Int, Never>.pipe()
        
        Signal.zip(signal1, signal2, signal3).observeValues { tuple in
            print("received value:\(tuple)")
        }
        
        innerObserver1.send(value: 1)
        innerObserver2.send(value: 2)
        innerObserver3.send(value: 3)
        
        innerObserver1.send(value: 11)
        innerObserver2.send(value: 22)
        innerObserver3.send(value: 33)
        
        innerObserver1.send(value: 111)
        innerObserver2.send(value: 222)
        
        innerObserver1.sendCompleted()
        innerObserver2.sendCompleted()
        innerObserver3.sendCompleted()
    }
    
    private func bindProducer() {
        let producer = SignalProducer<Int, Never> { (innerObserver, lifetime) in
            lifetime.observeEnded {
                print("信号无效了，你可以在这里进行一些清理工作")
            }
            
            innerObserver.send(value: 1)
            innerObserver.send(value: 2)
            innerObserver.send(value: 3)
        }
        
        let outObserver = Signal<Int, Never>.Observer(value: { value in
            print("did received value:\(value)")
        })
        
        producer.start(outObserver)
    }
    
    private func bindProperty() {
        let constant = Property(value: 1)
        print("initial value is: \(constant.value)")
        
        constant.producer.startWithValues { value in
            print("producer received: \(value)")
        }
        constant.signal.observeValues { value in
            print("signal received: \(value)")
        }
    }
    
    private func bindMutableProperty() {
        let mutableProperty = MutableProperty(1)
        print("initial value is: \(mutableProperty.value)")
        
        mutableProperty.producer.startWithValues {
            print("producer received \($0)")
        }
        
        mutableProperty.signal.observeValues {
            print("signal received \($0)")
        }
        
        mutableProperty.value = 2
        mutableProperty.value = 3
    }
    
    var backgroundColor = MutableProperty(UIColor.gray)
    var account = MutableProperty("")
    var password = MutableProperty("")
    private func bindInput() {
        loginButton.reactive.backgroundColor <~ backgroundColor
        accountTextField.reactive.text <~ account
        passwordTextField.reactive.text <~ password
        
        account <~ accountTextField.reactive.continuousTextValues
        password <~ passwordTextField.reactive.continuousTextValues
        
        account.value = "123"
    }
}

