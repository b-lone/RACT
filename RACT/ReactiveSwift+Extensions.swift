//
//  ReactiveCocoa+Extensions.swift
//  RACT
//
//  Created by 尤坤 on 2022/7/26.
//

import Foundation
import ReactiveSwift

struct APIError: Swift.Error {
    let code: Int
    var reason = ""
}
 
typealias NSignal<T> = ReactiveSwift.Signal<T, Never>
typealias APISignal<T> = ReactiveSwift.Signal<T, APIError>
 
typealias Producer<T> = ReactiveSwift.SignalProducer<T, Never>
typealias APIProducer<T> = ReactiveSwift.SignalProducer<T, APIError>

extension SignalProducer where Error == APIError {
    @discardableResult
    func startWithValues(_ action: @escaping (Value) -> Void) -> Disposable {
        return start(Signal.Observer(value: action))
    }
}

typealias APIAction<O> = ReactiveSwift.Action<[String: String]?, O, APIError>
typealias TextAction<O> = ReactiveSwift.Action<String?, O, APIError>
