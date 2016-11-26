//
//  HomeViewModel.swift
//  PlayBook
//
//  Created by Joseph Daniels on 5/29/16.
//  Copyright © 2016 Joseph Daniels. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result

//sections:
// Current/Recently Played track
// AudioBooks >
// Podcasts >
// Settings >

enum HomeTableSection: Int {
    case Recent
    case Library
    case Preferences


    static var sections: Int {
        return 3
    }
    var text: String {
        switch (self) {
                //        case .Audiobooks: return "Audiobooks"
                //        case .Podcasts: return "Podcasts"
        case .Recent: return "Recently Played"
        case .Preferences: return "Preferences"

        }
    }
    var headerTitle: String {
        switch (self) {
                //        case .Audiobooks: return "Audiobooks"
                //        case .Podcasts: return "Podcasts"
        case .Recent: return "Recently Played"
        case .Preferences: return "Preferences"

        }
    }
}

enum TableHeaderFooter {
    case StaticText(String)
    case Custom(TableHeaderFooterViewModel)
    case None

    var viewModel: TableHeaderFooterViewModel {
        switch self {
        case let StaticText(text):
            let hfvm = TableHeaderFooterViewModel(title: .Constant(""))
            hfvm.titleText <~ SignalProducer(value: text)
            return hfvm
        case let Custom(hfvm):
            return hfvm
        case None:
            return TableHeaderFooterViewModel(title: .Constant(""))
        }

    }
}

class HomeViewModel: NSObject {
    override init() {
        let audiobooks = TableSectionViewModel(rows: .Variable(.fetch({
            _ in AudioBody.MR_findFirst()!
        }
                                                               .observeOn(QueueScheduler.mainQueueScheduler)
                                                               .map {
            TableRowViewModel(model: .Constant($0), titleTransform: { $0.title })
        }))
        let tableViewModel = TableViewModel(.Constant([audiobooks]))

    }
}


enum DynamicalContent<T> {
    case Constant(T)
    case Variable(SignalProducer<T, NoError>)
    var producer: SignalProducer<T, NoError> {
        switch self {
        case let .Constant(sections):
            return SignalProducer(value: sections)
        case let .Variable(sections):
            return sections
        }
    }
    func bindable(initial: T) -> MutableProperty<T> {
        switch self {
        case let .Constant(sections):
            return MutableProperty(sections)
        case let .Variable(sections):
            let p = MutableProperty(initial)
            p <~ sections
            return p
        }
    }
}

class TableViewModel<T>: NSObject {
    let sections: MutableProperty<[TableSectionViewModel<T>]>
    init(sections: DynamicalContent<[TableSectionViewModel<T>]>) {
        self.sections = sections.bindable([])
    }

}


class TableHeaderFooterViewModel: NSObject {
    var titleText: MutableProperty<String>
    init(title: DynamicalContent<String>) {
        titleText = title.bindable("")
    }

}

class TableRowViewModel<T>: NSObject {
    var model: MutableProperty<T>
    var title: MutableProperty<String>
    init(model: DynamicalContent<T>, titleTransform: T -> String) {
        switch model {
        case let .Variable(sig):
            self.model <~ sig
        case let .Constant(val):
            self.model <~ SignalProducer(value: val)
        }

        self.title = MutableProperty("")
        self.title <~ self.model.producer.map(titleTransform)
    }
}

class TableSectionViewModel<T>: NSObject {
    var rows: MutableProperty<[TableRowViewModel<T>]>
    var header: MutableProperty<TableHeaderFooter>
    var footer: MutableProperty<TableHeaderFooter>

    init(rows: DynamicalContent<[TableRowViewModel<T>]>, header: TableHeaderFooter = .None, footer: TableHeaderFooter = .None) {
        self.rows = rows.bindable([])
        self.header = MutableProperty(header)
        self.footer = MutableProperty(footer)
    }
}

