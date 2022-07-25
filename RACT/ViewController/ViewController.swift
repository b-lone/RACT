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
        
//        bindVersion1()
        bindVersion2()
    }
    
    private func bindVersion1() {
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
    
    private func bindVersion2() {
        let (signal, innerObserver) = Signal<Int, Never>.pipe()
        signal.observeValues { value in
            print("observeValues did received value: \(value)")
        }
        signal.observeValues { value in
            print("observeValues did received value: \(value)")
        }
        innerObserver.send(value: 1)
        innerObserver.sendCompleted()
    }
}

