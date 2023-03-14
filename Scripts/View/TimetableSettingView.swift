//
//  TimeTableSetting.swift
//  Timetable
//
//  Created by 谷田和基 on 2022/05/17.
//

import SwiftUI
import RealmSwift

struct TimetableSettingView: View {
    @EnvironmentObject var timetableViewModel: TimetableViewModel
    @Environment(\.dismiss) var dismiss
    
    let timetable: Timetable
    @State var cells = RealmSwift.List<TimetableCell>()
    @State var name : String = ""
    @State var maxPeriod:Int = 5
    @State var isSaturday:Bool = false
    @State var isSunday: Bool = false
    @Binding var selectedTimetable:Timetable
    @State var isFirst = true
    
    let day = WeekDay()
    
    @State var isShowedDeleteAlert = false

    
    var body: some View{
        ZStack{
            VStack{
                Form{
                    Section{
                        TextField("時間割名", text: $name)
                            .onAppear{
                                self.name = timetable.name
                            }
                        Picker(selection: $maxPeriod, label: Text("授業時間数")) {
                            ForEach(1..<9, id: \.self){
                                index in
                                Text(String(index)+"時間目まで")
                            }
                        }.onAppear{
                            if isFirst == true{
                                self.maxPeriod = timetable.maxPeriod
                                isFirst = false
                            }
                        }
                        HStack{
                            Text("土曜日を追加")
                            Spacer()
                            Toggle("", isOn:$isSaturday)
                                .onAppear{
                                    self.isSaturday = timetable.isSaturday
                                }
                        }
                        HStack{
                            Text("日曜日を追加")
                            Spacer()
                            Toggle("", isOn:$isSunday)
                                .onAppear{
                                    self.isSunday = timetable.isSunday
                                }
                        }
                    }
                    Section{
                        Text("この時間割を削除")
                            .foregroundColor(Color.red)
                            .onTapGesture {
                                self.isShowedDeleteAlert = true
                            }
                            .alert("この時間割を削除しますか？",isPresented: $isShowedDeleteAlert){
                                Button("削除",role: .destructive){
                                    selectedTimetable = timetableViewModel.timetables.first(where: {$0.id != timetable.id})!
                                    let _ = print("selectedTimetable:%@",selectedTimetable)
                                    timetableViewModel.updateTimetableIsUsed(timetable.id, newIsUsed: false)
                                    dismiss()
                                }
                            }message:{
                                Text("この操作は取り消せません")
                            }
                    }
                    
                    Section{
                        Button("登録"){
                            if self.name != timetable.name{
                                timetableViewModel.updateName(timetable.id, newName: name)
                            }
                            if self.maxPeriod != timetable.maxPeriod{
                                timetableViewModel.updateTimetableMaxPeriod(timetable.id, newMaxPeriod: maxPeriod)
                            }
                            if self.isSaturday != timetable.isSaturday{
                                timetableViewModel.updateTimetableIsSaturday(timetable.id, newIsSaturday: isSaturday)
                            }
                            if self.isSunday != timetable.isSunday{
                                timetableViewModel.updateTimetableIsSunday(timetable.id, newIsSunday: isSunday)
                            }

                            dismiss()
                        }
                    }
                }
            }
        }
    }
}
