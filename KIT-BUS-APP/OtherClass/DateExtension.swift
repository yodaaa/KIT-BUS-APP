
//
//  DateExtension.swift
//  KIT-BUS-APP
//
//  Created by yodaaa on 2019/02/27.
//  Copyright © 2019 yodaaa. All rights reserved.
//
import Foundation


extension Date {
    
    func toStringWithCurrentLocale() -> String {
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return formatter.string(from: self)
    }
}
