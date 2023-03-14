//
//  DayCell.swift
//  Timetable
//
//  Created by 谷田和基 on 2022/05/19.
//

import SwiftUI

struct DayCell:View,Identifiable{
    var id: String
    let dayName:String
    let day = WeekDay()
    
    var body: some View{
        ZStack{
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(4.0)
                .scaledToFit()
            if day.GetDate(int:day.GetDateID()) == dayName{
                Circle()
                    .foregroundColor(Color(red: 0.8156, green: 0.9215, blue: 0.4313))
                    .scaledToFit()
            }
            Text(dayName)
                .aspectRatio(contentMode: .fit)
                .scaledToFit()
        }
    }
}
