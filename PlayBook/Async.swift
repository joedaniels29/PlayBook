//
//  Async.swift
//  PlayBook
//
//  Created by Joseph Daniels on 5/30/16.
//  Copyright © 2016 Joseph Daniels. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result

enum Async<T> {
    case Filled(T)
    case Waiting


    func map<U>(f: (T) -> (U)) -> Async<U> {
        switch self {
        case let .Filled(t:T):
            return .Filled(f(T))
        default:
            return .Waiting
        }
    }

}


extension SignalProducerType where Value == Async<NSManagedObject> {
    func inSchedule<Model:NSManagedObject, E:ErrorType>(schedule: DataSchedule) -> SignalProducer<Async<Model>, E> {
         return self.lift(mapModelToScheduler(schedule.queue))

    }
}


