//
// Created by Joseph Daniels on 6/4/16.
// Copyright (c) 2016 Joseph Daniels. All rights reserved.
//

import Foundation
import ReactiveCocoa
import CoreData
import MagicalRecord


//class DataSchedule {
//    var queueScheduler: QueueScheduler
//    var context: NSManagedObjectContext
//    init(scheduler: QueueScheduler) {
//        self.queueScheduler = scheduler
//        context = .MR_newPrivateQueueContext()
//    }
//
//    static var fg: QueueScheduler {
//        return QueueScheduler.mainQueueScheduler
//    }
//
//    func fetch<Model:NSManagedObject, E:ErrorType>(fetchFunction: NSManagedObjectContext -> Model) -> SignalProducer<Async<Model>, E> {
//        return SignalProducer<Async<Model>, E>(value: .Waiting).then(
//                mapModelToScheduler(self.queueScheduler)(
//                        SignalProducer(value: ())
//                        .observeOn(queueScheduler)
//                        .map {
//                            _ in .Filled(fetchFunction(self.context))
//                        })
//                )
//    }
//}
class CoreDataScheduler: SchedulerType {
    let managedObjectContext: NSManagedObjectContext
    init(managedObjectContext:NSManagedObjectContext){
        self.managedObjectContext = managedObjectContext
    }

    func schedule(action: () -> ()) -> Disposable? {
        let disposable = Disposable()
        self.managedObjectContext.performBlock({
            if disposable.disposed{
                return
            }
            action()
        })
        return disposable
    }
}

func mapModelToScheduler<Model:NSManagedObject, E:ErrorType>(queue: QueueScheduler) -> (signal:Signal<Async<Model>, E>) -> Signal<Async<Model>, E> {
    return {
        signal in signal.map {
            $0.map {
                $0.objectID
            }
        }.observeOn(queue).map {
            $0.map {
                let ctxt = NSManagedObjectContext.MR_contextForCurrentThread()
                return ctxt.objectWithID($0) as! Model
            }
        }
    }
}


