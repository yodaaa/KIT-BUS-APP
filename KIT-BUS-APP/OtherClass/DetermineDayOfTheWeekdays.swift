//
//  DetermineDayOfTheWeekdays.swift
//  KIT-BUS-APP
//
//  Created by yodaaa on 2019/02/27.
//  Copyright © 2019 yodaaa. All rights reserved.
//

import  Foundation

class DetermineDayOfTheWeekdays {
    
    
    
    /// 週末判定
    func determineDayOfTheWeek() -> Bool {
        // 現在時刻取得
        let nowDate = NSDate()
        // 週末かどうか判定
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
    
    ///　祝日判定
    ///  let date = Date()
    ///  Logger.debugLog(DetermineDayOfTheWeekdays().judgeHoliday(date))
    func judgeHoliday(_ date: Date) -> Bool {
        //祝日判定用のカレンダークラスのインスタンス
        let tmpCalendar = Calendar(identifier: .gregorian)
        // 祝日判定を行う日にちの年、月、日を取得
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        
        // CalculateCalendarLogic()：祝日判定のインスタンスの生成
        let holiday = CalculateCalendarLogic()
        
        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    
    // date型 -> 年月日をIntで取得
    func getDay(_ date:Date) -> (Int,Int,Int){
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        return (year,month,day)
    }
    
    //曜日判定(日曜日:1 〜 土曜日:7)
    func getWeekIdx(_ date: Date) -> Int{
        let tmpCalendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }
    
    /// 土曜日かどうか
    /// sat -> true
    func judgeSaturday(_ date: Date) -> Bool {
        if getWeekIdx(date) == 7 {
            return true
        }
        return false
    }
    
    /// 日曜日かどうか
    /// sun -> true
    func judgeSunday(_ date: Date) -> Bool {
        if getWeekIdx(date) == 1 {
            return true
        }
        return false
    }
    
    /// 曜日に合わせて処理を分岐(時刻データを変える
    func changeTimelinebyWeekday(_ date: Date, _ goY: Bool) -> [[String]] {
        let const = Const()
        
        // 祝日
        if  judgeHoliday(date) {
            return const.noBus
        } else { //祝日以外
            if judgeSaturday(date) {
                return goY ? [const.detime_goy_sat, const.arrtime_goy_sat] : [const.detime_goo_sat, const.arrtime_goo_sat]
            } else if judgeSunday(date) {
                return const.noBus
            } else {
                // 夏季休業・春季休業期間中に関する処理
                var dateS = Date()
                var dateE = Date()
                let formatYMD:DateFormatter = DateFormatter()
                formatYMD.dateFormat = "yyyy/MM/dd"
                dateS = formatYMD.date(from: const.longTermHolidayStart)!
                dateE = formatYMD.date(from: const.longTermHolidayEnd)!
                
                if (dateS < date && date < dateE) {
                    // 夏季休業・春季休業期間中
                    // 平日
                    return goY ? [const.detime_goy_longh, const.arrtime_goy_longh] : [const.detime_goo_longh, const.arrtime_goo_longh]
                } else {
                    // 平日
                    return goY ? [const.detime_goy, const.arrtime_goy] : [const.detime_goo, const.arrtime_goo]
                }
            }
        }
    }
    
    
    /// 現在時刻の10分前を取得
    func getpre10min() {
        let nowDate = NSDate()
        var comps = DateComponents(hour: 9, minute: -10)
        
        Logger.debugLog(Calendar.current.date(byAdding: comps, to: nowDate as Date))
    }
}
