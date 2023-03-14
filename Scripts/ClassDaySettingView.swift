//
//  ClassDaySettingView.swift
//  Timetable
//
//  Created by 谷田和基 on 2022/06/26.
//

import SwiftUI

struct ClassDaySettingView :View{
    @State var showedDays = ""
    @Binding var selectedDays:Set<Int>
    let day = WeekDay()
    
    var body: some View{
        List(selection: $selectedDays){
            ForEach(1..<8){
                index in
                Text(day.GetDate(int: index)).tag(index)
            }
        }.environment(\.editMode, .constant(.active))
    }
    
    func ShowSelectedDays()->String{
        selectedDays.forEach{
            showedDays += day.GetDate(int: $0)
        }
        return showedDays
    }
}
