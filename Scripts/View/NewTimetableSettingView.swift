//
//  NewTimetableSettingView.swift
//  Timetable
//
//  Created by 谷田和基 on 2022/07/04.
//

import SwiftUI
import RealmSwift

struct NewTimetableSettingView: View {
    @EnvironmentObject var timetableViewModel: TimetableViewModel
    @Environment(\.dismiss) var dismiss
    
    let timetable: Timetable
    @State var name : String = "新しい時間割"
    @State var maxPeriod:Int = 5
    @State var isSaturday:Bool = false
    @State var isSunday: Bool = false
    var body: some View{
        ZStack{
            VStack{
                Form{
                    Section{
                        TextField("時間割名", text: $name)

                        Picker(selection: $maxPeriod, label: Text("授業時間数")) {
                            ForEach(1..<9){
                                index in
                                Text(String(index)+"時間目まで").tag(index)
                            }
                        }
                        HStack{
                            Text("土曜日を追加")
                            Spacer()
                            Toggle("", isOn:$isSaturday)
                        }
                        HStack{
                            Text("日曜日を追加")
                            Spacer()
                            Toggle("", isOn:$isSunday)
                        }
                    }
                    
                    Section{
                        Button("登録"){
                            timetableViewModel.updateName(timetable.id, newName: name)
                            timetableViewModel.updateTimetableMaxPeriod(timetable.id, newMaxPeriod: maxPeriod)
                            timetableViewModel.updateTimetableIsSaturday(timetable.id, newIsSaturday: isSaturday)
                            timetableViewModel.updateTimetableIsSunday(timetable.id, newIsSunday: isSunday)
                            timetableViewModel.updateTimetableIsUsed(timetable.id, newIsUsed: true)
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}
