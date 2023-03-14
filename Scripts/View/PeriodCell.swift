//
//  PeriodCell.swift
//  Timetable
//
//  Created by 谷田和基 on 2022/05/19.
//

import SwiftUI


struct PeriodCell:View,Identifiable{
    var id: String
    let periodName:String
    var body: some View{
        ZStack{
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(4.0)
                .scaledToFit()
            VStack{
                Text(periodName)
            }
        }
    }
}
