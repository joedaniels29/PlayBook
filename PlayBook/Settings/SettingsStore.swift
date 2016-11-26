//
// Created by Joseph Daniels on 12/27/15.
// Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

var _instance = SettingsStore()

class SettingsStore {
    class func key(keyName:String)->String{
        return "d29.playbook.\(keyName)"
    }

    static var instance: SettingsStore {
        return _instance
    }
    class func defaultsValueOrDefault<T>(keyName: String, defaultValue: T) -> T {
        let key = self.key(keyName)
        Defaults[key] = defaultValue
        switch (defaultValue) {
        case is String:
            return Defaults[key].string as! T
        case is Double:
            return Defaults[key].double as! T
        case is Bool:
            return Defaults[key].bool as! T
        case is Int:
            return Defaults[key].int as! T
        default:
            print("no defaults type")
            exit(-1);
        }
    }

    class func updateDefault<T>(keyName: String, defaultValue: T) {
        let key = self.key(keyName)
        Defaults[key] = defaultValue
    }


    var mostRecentID: Int = SettingsStore.defaultsValueOrDefault("mostRecentID", defaultValue: 0) {
        didSet {
            SettingsStore.updateDefault("mostRecentID", defaultValue: mostRecentID)
        }
    }

}
