//
//  ViewController.swift
//  RACT
//
//  Created by 尤坤 on 2022/7/25.
//

import UIKit
//import ReactiveCocoa
//import ReactiveSwift
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let accountValid = accountTextField.rx.text.orEmpty.map {
            $0.count >= 5
        }.share(replay: 1)
        let passwordValid = passwordTextField.rx.text.orEmpty.map { $0.count >= 5 }.share(replay: 1)
        let everythingValid = Observable.combineLatest(accountValid, passwordValid) { $0 && $1 }.share(replay: 1)
        
        accountValid.bind(to: passwordTextField.rx.isEnabled).disposed(by: disposeBag)
        everythingValid.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        
        loginButton.rx.tap.subscribe { _ in
            print("loginButton tap")
        }.disposed(by: disposeBag)
        
//        let subject = ReplaySubject<String>.create(bufferSize: 2)
//        subject.subscribe(on: ConcurrentDispatchQueueScheduler(qos: .userInitiated)).subscribe{ print("Subscription:on \(Thread.current): 1 event: \($0)") }.disposed(by: disposeBag)
//
//        subject.onNext("🐶")
//        subject.onNext("🐱")
//        subject.subscribe{ print("Subscription: 2 event: \($0)") }.disposed(by: disposeBag)
//
//        subject.onNext("🦋")
        
//        let first = BehaviorSubject(value: "👦🏻")
//        let second = BehaviorSubject(value: "🅰️")
//        let subject = BehaviorSubject(value: first)
//
//        subject.asObservable()
//                .flatMapLatest { $0 }
//                .subscribe(onNext: { print($0) })
//                .disposed(by: disposeBag)
//
//        first.onNext("🐱")
//        subject.onNext(second)
//        second.onNext("🅱️")
//        first.onNext("🐶")
        
        let id = Observable.repeatElement(0)
        id.subscribe { print($0) }
    onError: { print($0) }
    onCompleted:{ print("onCompleted") }
    onDisposed: { print("onDisposed") }

        
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
//        bindInput()
//        bindAction()
//        bindAction2()
//        bindCocoaAction()
    }
    
//    private func bind() {
//        let (signal, innerObserver) = Signal<Int, Never>.pipe()
//        let outerObserver1 = Signal<Int, Never>.Observer(value: { value in
//            print("did received value: \(value)")
//        })
//        let outerObserver2 = Signal<Int, Never>.Observer { event in
//            switch event {
//            case let .value(value):
//                print("did received value: \(value)")
//            default: break
//            }
//        }
//
//        signal.observe(outerObserver1)
//        signal.observe(outerObserver2)
//
//        innerObserver.send(value: 1)
//        innerObserver.sendCompleted()
//    }
//
//    private func bind2() {
//        let (signal, innerObserver) = Signal<Int, Never>.pipe()
//        signal.observeValues { value in
//            print("did received value: \(value)")
//        }
//        signal.observeValues { value in
//            print("did received value: \(value)")
//        }
//        innerObserver.send(value: 1)
//        innerObserver.sendCompleted()
//    }
//
//    private func bindMap() {
//        let (signal, innerObserver) = Signal<Int, Never>.pipe()
//        signal.observeValues { value in
//            print("did received value: \(value)")
//        }
//        signal.observeValues { value in
//            print("did received value: \(value)")
//        }
//
//        signal.map { value in
//            return "xxx \(value)"
//        }.observeValues { string in
//            print(string)
//        }
//
//        innerObserver.send(value: 1)
//        innerObserver.sendCompleted()
//    }
//
//    private func bindOn() {
//        let (signal, innerObserver) = Signal<Int, Never>.pipe()
//        signal.observeValues { value in
//            print("did received value: \(value)")
//        }
//        signal.observeValues { value in
//            print("did received value: \(value)")
//        }
//
//        signal.on(value: { value in
//            print("on value: \(value)")
//        }).observeValues { value in
//            print("did received value: \(value)")
//        }
//
//        innerObserver.send(value: 1)
//        innerObserver.sendCompleted()
//    }
//
//    private func bindTake() {
//        let (signal, innerObserver) = Signal<Int, Never>.pipe()
//        let (takeSignal, takeObserver) = Signal<(), Never>.pipe()
//
//        signal.take(until: takeSignal).observe { event in
//            print("received value:\(event)")
//        }
//
//        innerObserver.send(value: 1)
//        innerObserver.send(value: 2)
//
//        takeObserver.send(value: ())
//        innerObserver.send(value: 3)
//
//        takeObserver.sendCompleted()
//        innerObserver.sendCompleted()
//    }
//
//    private func bindTake2() {
//        let (signal, innerObserver) = Signal<Int, Never>.pipe()
//        //只取最初N次的Event
//        signal.take(first: 2).observe { event in
//            print("recceived value:\(event)")
//        }
//
//        innerObserver.send(value: 1)
//        innerObserver.send(value: 2)
//        innerObserver.send(value: 3)
//        innerObserver.send(value: 4)
//
//        innerObserver.sendCompleted()
//    }
//
//    private func bindMerge() {
//        let (signal1, innerObserver1) = Signal<Int, Never>.pipe()
//        let (signal2, innerObserver2) = Signal<Int, Never>.pipe()
//        let (signal3, innerObserver3) = Signal<Int, Never>.pipe()
//
//        Signal.merge(signal1, signal2, signal3).observeValues { value in
//            print("received value:\(value)")
//        }
//
//        innerObserver1.send(value: 1)
//        innerObserver1.sendCompleted()
//
//        innerObserver2.send(value: 2)
//        innerObserver2.sendCompleted()
//
//        innerObserver3.send(value: 3)
//        innerObserver3.sendCompleted()
//    }
//
//    private func bindCombineLatest() {
//        let (signal1, innerObserver1) = Signal<Int, Never>.pipe()
//        let (signal2, innerObserver2) = Signal<Int, Never>.pipe()
//        let (signal3, innerObserver3) = Signal<Int, Never>.pipe()
//
//        Signal.combineLatest(signal1, signal2, signal3).observeValues { tuple in
//            print("received value:\(tuple)")
//        }
//
//        innerObserver1.send(value: 1)
//        innerObserver2.send(value: 2)
//        innerObserver3.send(value: 3)
//
//        innerObserver1.send(value: 11)
//        innerObserver2.send(value: 22)
//        innerObserver3.send(value: 33)
//
//        innerObserver1.sendCompleted()
//        innerObserver2.sendCompleted()
//        innerObserver3.sendCompleted()
//    }
//
//    private func bindZip() {
//        let (signal1, innerObserver1) = Signal<Int, Never>.pipe()
//        let (signal2, innerObserver2) = Signal<Int, Never>.pipe()
//        let (signal3, innerObserver3) = Signal<Int, Never>.pipe()
//
//        Signal.zip(signal1, signal2, signal3).observeValues { tuple in
//            print("received value:\(tuple)")
//        }
//
//        innerObserver1.send(value: 1)
//        innerObserver2.send(value: 2)
//        innerObserver3.send(value: 3)
//
//        innerObserver1.send(value: 11)
//        innerObserver2.send(value: 22)
//        innerObserver3.send(value: 33)
//
//        innerObserver1.send(value: 111)
//        innerObserver2.send(value: 222)
//
//        innerObserver1.sendCompleted()
//        innerObserver2.sendCompleted()
//        innerObserver3.sendCompleted()
//    }
//
//    private func bindProducer() {
//        let producer = SignalProducer<Int, Never> { (innerObserver, lifetime) in
//            lifetime.observeEnded {
//                print("信号无效了，你可以在这里进行一些清理工作")
//            }
//
//            innerObserver.send(value: 1)
//            innerObserver.send(value: 2)
//            innerObserver.send(value: 3)
//        }
//
//        let outObserver = Signal<Int, Never>.Observer(value: { value in
//            print("did received value:\(value)")
//        })
//
//        producer.start(outObserver)
//    }
//
//    private func bindProperty() {
//        let constant = Property(value: 1)
//        print("initial value is: \(constant.value)")
//
//        constant.producer.startWithValues { value in
//            print("producer received: \(value)")
//        }
//        constant.signal.observeValues { value in
//            print("signal received: \(value)")
//        }
//    }
//
//    private func bindMutableProperty() {
//        let mutableProperty = MutableProperty(1)
//        print("initial value is: \(mutableProperty.value)")
//
//        mutableProperty.producer.startWithValues {
//            print("producer received \($0)")
//        }
//
//        mutableProperty.signal.observeValues {
//            print("signal received \($0)")
//        }
//
//        mutableProperty.value = 2
//        mutableProperty.value = 3
//    }
//
//    var backgroundColor = MutableProperty(UIColor.gray)
//    var account = MutableProperty("")
//    var password = MutableProperty("")
//    private func bindInput() {
//        loginButton.reactive.backgroundColor <~ backgroundColor
//        accountTextField.reactive.text <~ account
//        passwordTextField.reactive.text <~ password
//
//        account <~ accountTextField.reactive.continuousTextValues
//        password <~ passwordTextField.reactive.continuousTextValues
//
//        loginButton.reactive.isEnabled <~ SignalProducer.combineLatest(account.producer, password.producer).map { (account, password) in
//            if !account.isEmpty, !password.isEmpty {
//                return true
//            }
//            return false
//        }
//    }
//
//    private func bindAction() {
//        let action = APIAction<Int> { (input) -> APIProducer<Int> in
//            print("input:", input as Any)
//            return APIProducer({ (innerObserver, _) in
//                innerObserver.send(value: 1)
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
//                    innerObserver.send(value: 2)
//                    innerObserver.sendCompleted()
//                })
//            })
//        }
//
//        action.events.observe {
//            print("did received Event:\($0)")
//        }
//        action.values.observeValues {
//            print("did received Value:\($0)")
//        }
//        action.apply(["1": "xxx"]).start()
//
//        for i in 0...10 {
//            action.apply([String(i): "xxx"]).start()
//        }
//    }
//
//    let enable = MutableProperty(false)
//    private func bindAction2() {
//        enable <~ accountTextField.reactive.continuousTextValues.map { !$0.isEmpty }
//
//        let action = APIAction<Int>(enabledIf: enable) { (input) -> APIProducer<Int> in
//            print("input:", input as Any)
//            return APIProducer({ (innerObserver, _) in
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
//                    innerObserver.send(value: 1)
//                    innerObserver.sendCompleted()
//                })
//            })
//        }
//
//        action.values.observeValues {
//            print("did received value:\($0)")
//        }
//
//        loginButton.reactive.controlEvents(.touchUpInside).observeValues { sender in
//            action.apply(["xxx": "xxx"]).start()
//        }
//    }
//
//    private func bindCocoaAction() {
//        enable <~ accountTextField.reactive.continuousTextValues.map { !$0.isEmpty }
//        let action = TextAction<Int>(enabledIf: enable) { input in
//            print("input:", input as Any)
//            return APIProducer { ( innerObserver, _ ) in
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
//                    innerObserver.send(value: 1)
//                    innerObserver.sendCompleted()
//                }
//            }
//        }
//
//        loginButton.reactive.pressed = CocoaAction(action) { [unowned self] _ in
//            return self.accountTextField.text
//        }
//
////        let cocoaAction1 = CocoaAction<UIButton>(action, input: self.accountTextField.text)
////
////        let cocoaAction2 = CocoaAction<UIButton>(action) { _ in
////            let input = "xxx"
////            return input
////        }
//    }
}

