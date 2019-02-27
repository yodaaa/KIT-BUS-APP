//
//  DetermineDayOfTheWeekdays.swift
//  KIT-BUS-APP
//
//  Created by yodaaa on 2019/02/27.
//  Copyright © 2019 yodaaa. All rights reserved.
//

import  Foundation

class DetermineDayOfTheWeekdays {
    
    
    
    /// 曜日判定
    func determineDayOfTheWeek() -> Bool {
        let nowDate = NSDate()
        let result = Calendar.current.isDateInWeekend(nowDate as Date)
        Logger.debugLog(result)
        return result
    }
    
    ///　曜日取得
    func getDayOfTheWeek() -> String {
        let nowDate = NSDate()
        let weekday = Calendar.current.component(.weekday, from: nowDate as Date)
        let resultWeekdaysSymbols = Calendar.current.shortStandaloneWeekdaySymbols[weekday - 1]
        Logger.debugLog(resultWeekdaysSymbols)
        return resultWeekdaysSymbols
    }
    
    func getpre10min() {
        let nowDate = NSDate()
        var comps = DateComponents(minute: -10)
        Logger.debugLog(Calendar.current.date(byAdding: comps, to: nowDate as Date))
    }
}
