//
//  Date.swift
//  Timetable
//
//  Created by 谷田和基 on 2022/05/20.
//

import SwiftUI


struct WeekDay{
    func GetDateID()->Int{
        let currentDate = Date()
        let weekDay = Calendar.current.component(.weekday, from: currentDate)
        print(weekDay)
        return weekDay
    }
    //引数名もっといいのにしたいね〜
    func GetDate(int:Int)->String{
        switch int{
        case 1:
            return "日"
        case 2:
            return "月"
        case 3:
            return "火"
        case 4:
            return "水"
        case 5:
            return "木"
        case 6:
            return "金"
        case 7:
            return "土"
        default:
            return "Error"
        }
    }
}
