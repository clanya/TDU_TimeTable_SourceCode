//
//  TestTimetableView.swift
//  Timetable
//
//  Created by 谷田和基 on 2022/06/27.
//

import SwiftUI
import RealmSwift
struct TimetableView: View {
    @EnvironmentObject var timetableViewModel: TimetableViewModel
    @EnvironmentObject var timetableCellViewModel: TimetableCellViewModel
    
    let timetableTmp = Timetable()
    var coordinator = Coordinator()
    let cellColorList = CellColorList().cellColorList
    @State var selectedTimetable: Timetable = Timetable()
    @ObservedResults(Timetable.self) var timetables
    
    let predicate = NSPredicate(format: "isUsed == true")
    
    let dayCells:[DayCell] = [DayCell(id: "Mon", dayName: "月"),DayCell(id: "Tue", dayName: "火"),DayCell(id: "Wed", dayName: "水"),DayCell(id: "Thu", dayName: "木"),DayCell(id: "Fri", dayName: "金"),DayCell(id: "Sat", dayName: "土"),DayCell(id: "Sun", dayName: "日")]
    var body: some View {
        NavigationView {
            VStack{
                Picker("時間割選択",selection: $selectedTimetable){
                    ForEach(timetableViewModel.timetables.filter(predicate),id:\.self){
                        timetable in
                        Text(timetable.name)
                    }
                }
                let _ = print(selectedTimetable)
                ScrollView{
                    HStack{
                        VStack{
                            ZStack{
                                Rectangle()
                                    .foregroundColor(Color.white)
                                    .cornerRadius(2.0)
                                    .frame(width: 20, height: 65)
                            }
                            ForEach(0..<8){
                                period in
                                if period < selectedTimetable.maxPeriod{
                                    ZStack{
                                        Rectangle()
                                            .foregroundColor(Color.white)
                                            .cornerRadius(2.0)
                                            .frame(width: 20, height: 90)
                                            Text(String(period+1))
                                    }
                                }
                            }
                        }
                        ForEach(0..<6){
                            day in
                            VStack{
                                if day < 5 || selectedTimetable.isSaturday{
                                    dayCells[day]
                                    ForEach(0..<8){
                                        period in
                                        if period < selectedTimetable.maxPeriod{
                                            timetableCellView(day:day,period:period)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("時間割")        //selectedTimetable.name
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink(destination: {coordinator.nextView(timetable:selectedTimetable,
                                                                          selectedTimetable:$selectedTimetable)},label: {
                            Image(systemName: "gearshape")
                                .imageScale(.large)
                                .foregroundColor(Color.black)
                        }).navigationTitle("時間割設定")
                        .navigationBarTitleDisplayMode(.inline)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: {coordinator.nextView(timetable: timetableViewModel.timetables.first(where: {$0.isUsed == false})!)},label: {
                        Image(systemName: "plus")
                    }).navigationTitle("時間割を作成")
                        .navigationBarTitleDisplayMode(.inline)
                        
                }
            }
        }
    }
    
    func timetableCellView(day:Int ,period:Int) -> some View{
        NavigationLink(destination: {coordinator.nextView(selectedTimetable.cells.filter("day == %@ && period == %@", day,period).first!)}, label: {
            ZStack{
                Rectangle()
                    .foregroundColor(cellColorList[selectedTimetable.cells.filter("day == %@ && period == %@",day,period).first!.cellColor])
                    .cornerRadius(2.0)
                VStack{
                    Spacer()
                    Text(selectedTimetable.cells.filter("day == %@ && period == %@",day,period).first!.subjectName)
                        .font(Font.system(size: 12))
                    Text(selectedTimetable.cells.filter("day == %@ && period == %@",day,period).first!.classroomName)
                        .font(Font.system(size: 10.5))
                    Text(selectedTimetable.cells.filter("day == %@ && period == %@",day,period).first!.teacherName)
                        .font(Font.system(size: 10.5))
                    Spacer()
                }.foregroundColor(.black)
            }
        })
    }
}
