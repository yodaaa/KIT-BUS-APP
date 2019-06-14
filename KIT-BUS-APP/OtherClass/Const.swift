//
//  Const.swift
//  KIT-BUS-APP
//
//  Created by yodaaa on 2019/02/27.
//  Copyright © 2019 yodaaa. All rights reserved.
//

import Foundation

/// 定数定義するクラス
public struct Const {
    // 月から金(八束穂行き)
    let detime_goy: [String] = ["8:20", "8:40", "9:20", "9:40", "10:40", "12:00", "12:30", "13:20", "15:10", "16:30", "17:10", "17:50", "19:10"]
    let arrtime_goy: [String] = ["8:50", "9:10", "9:50", "10:10", "11:10", "12:30", "13:00", "13:50", "15:40", "17:00", "17:40", "18:20", "19:35"]
    
    // 土曜(八束穂行き)
    let detime_goy_sat: [String] = ["8:20", "13:20"]
    let arrtime_goy_sat: [String] = ["8:50", "13:50"]
    
    // 月から金(扇が丘行き)
    let detime_goo: [String] = ["10:20", "11:20", "12:40", "14:20", "15:10", "15:50", "17:10", "17:40", "18:30", "20:00", "21:00"]
    let arrtime_goo: [String] = ["10:50", "11:50", "13:10", "14:50", "15:40", "16:20", "17:40", "18:10", "19:00", "20:25", "21:25"]
    
    // 土曜(扇が丘行き)
    let detime_goo_sat: [String] = ["12:40", "14:40"]
    let arrtime_goo_sat: [String] = ["13:10", "15:10"]
    
    // 月から金(八束穂行き) 休み期間中
    let detime_goy_longh: [String] = ["8:20", "9:40", "10:40", "12:30", "15:10", "16:30", "17:50", "19:10"]
    let arrtime_goy_longh: [String] = ["8:50", "10:10", "11:10", "13:00", "15:40", "17:00", "18:20", "19:35"]
    
    // 月から金(扇が丘行き) 休み期間中
    let detime_goo_longh: [String] = ["11:20", "14:20", "15:50", "17:10", "18:30", "20:00", "21:00"]
    let arrtime_goo_longh: [String] = ["11:50", "14:50", "16:20", "17:40", "19:00", "20:25", "21:25"]
    
    let noBus: [[String]] = [[],[]]
    
    let longTermHolidayStart: String = "2019/08/01"
    let longTermHolidayEnd: String = "2019/09/13"
}
