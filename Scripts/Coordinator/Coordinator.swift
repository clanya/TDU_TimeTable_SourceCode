//
//  Coordinator.swift
//  Timetable
//
//  Created by 谷田和基 on 2022/06/27.
//

import SwiftUI

class Coordinator: ObservableObject {
    @ViewBuilder
    func nextView(_ cell: TimetableCell) -> some View {
        TimetableCellSettingView(timetableCell: cell)
    }
    
    func nextView( timetable: Timetable,selectedTimetable:Binding<Timetable>) -> some View{
        TimetableSettingView(timetable: timetable,selectedTimetable: selectedTimetable)
    }
    
    func nextView(timetable:Timetable)->some View{
        NewTimetableSettingView( timetable: timetable)
    }
    func nextView(day:String,period:String,subjectName:Binding<String>,classroomName:Binding<String>,teacherName:Binding<String>)->some View{
        ClassDataListView(p_day: day, p_time: period,subjectName: subjectName,classroomName: classroomName,teacherName: teacherName)
    }
}
