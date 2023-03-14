//
//  TimetableCellSettingView.swift
//  Timetable
//
//  Created by 谷田和基 on 2022/06/27.
//

import SwiftUI

struct TimetableCellSettingView: View {
    @EnvironmentObject var timetableCellViewModel: TimetableCellViewModel
    @Environment(\.dismiss) var dismiss
    
    let timetableCell: TimetableCell
    @State private var subjectName :String = ""
    @State private var classroomName :String = ""
    @State private var teacherName :String = ""
    @State private var cellColor:Int = 0
    @State var isShowedDeleteAlert = false
    
    @State var isFirst = true
    @State var isFirstSubjectName = true
    @State var isFirstClassroomName = true
    @State var isFirstTeacherName = true
    @State var isFirstCellColor = true
    let cellColorList = CellColorList().cellColorList
    var coordinator = Coordinator()
    
    var body: some View {
        let _ = print("isFirst:%@",isFirst)
        VStack {
            Form {
                Section{
                    TextField("科目", text: $subjectName)
                        .onAppear{
                            if isFirstSubjectName == true{
                                self.subjectName = timetableCell.subjectName
                                isFirstSubjectName = false
                            }
                    }
                }footer: {
                    NavigationLink(destination: coordinator.nextView(day: ChangeIntToString(day: timetableCell.day), period: String(timetableCell.period+1),subjectName: $subjectName,classroomName: $classroomName,teacherName: $teacherName), label: {
                        Text("リストから選択")
                    })
                }
                Section{
                    TextField("教室", text: $classroomName)
                        .onAppear(){
                            if isFirstClassroomName == true{
                                self.classroomName = timetableCell.classroomName
                                isFirstClassroomName = false
                            }
                        }
                    TextField("教員", text: $teacherName)
                        .onAppear{
                            if isFirstTeacherName == true{
                                self.teacherName = timetableCell.teacherName
                                isFirstTeacherName = false
                            }
                        }
                    Picker("色",selection: $cellColor){
                        ForEach(0..<cellColorList.count){
                            index in
                            Circle().foregroundColor(cellColorList[index])//.tag(index)
                        }
                    }
                    .onAppear{
                        if isFirstCellColor == true{
                            self.cellColor = timetableCell.cellColor
                            isFirstCellColor = false
                        }
                        
                    }
                }
                Section{
                    Button("削除") {
                        self.isShowedDeleteAlert = true
                    }.alert("この授業を削除しますか？",isPresented: $isShowedDeleteAlert){
                        Button("削除",role: .destructive){
                            //timetableCellViewModel.removeTimetableCell(timetableCell.id)
                            //Note: 注意!!　削除と表示しているが実際は空文字等で初期化させているだけ
                            timetableCellViewModel.updateTimetableCellSubjectName(timetableCell.id, newSubjectName: "")
                            timetableCellViewModel.updateTimetableCellClassroomName(timetableCell.id, newClassroomName: "")
                            timetableCellViewModel.updateTimetableCellTeacherName(timetableCell.id, newTeacherName: "")
                            timetableCellViewModel.updateTimetableCellColor(timetableCell.id, newCellColor: 0)
                            dismiss()
                        }
                    }message:{
                        Text("この操作は取り消せません")
                    }
                    .foregroundColor(Color.red)
                }
                
                Section{
                    Button("登録"){
                        if subjectName != timetableCell.subjectName{
                            timetableCellViewModel.updateTimetableCellSubjectName(timetableCell.id, newSubjectName: subjectName)
                        }
                        if classroomName != timetableCell.classroomName{
                            timetableCellViewModel.updateTimetableCellClassroomName(timetableCell.id, newClassroomName: classroomName)
                        }
                        if teacherName != timetableCell.teacherName{
                            timetableCellViewModel.updateTimetableCellTeacherName(timetableCell.id, newTeacherName: teacherName)
                        }
                        if cellColor != timetableCell.cellColor{
                            timetableCellViewModel.updateTimetableCellColor(timetableCell.id, newCellColor: cellColor)
                        }
                        isFirst = true
                        dismiss()
                    }
                }
            }
            
        }
    }
    //とりあえず。体調がすごく悪いので許して。
    func ChangeIntToString(day:Int)-> String{
        var strTmp:String
        switch day{
        case 0:
            strTmp = "月"
        case 1:
            strTmp = "火"
        case 2:
            strTmp = "水"
        case 3:
            strTmp = "木"
        case 4:
            strTmp = "金"
        case 5:
            strTmp = "土"
        case 6:
            strTmp = "日"
        default:
            strTmp = "Error"
        }
        return strTmp
    }
}
