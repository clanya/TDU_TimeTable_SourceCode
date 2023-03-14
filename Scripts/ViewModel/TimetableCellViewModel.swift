//
//  TimetableCellViewModel.swift
//  Timetable
//
//  Created by 谷田和基 on 2022/06/26.
//

import RealmSwift

class TimetableCellViewModel: ObservableObject {
    @Published var model: TimetableCellModel = TimetableCellModel()
    //Modelから受け取る Results<TimetableCell>をViewへ渡す
    var timetableCells: Results<TimetableCell> {
        model.timetableCells
    }
    //Viewからのリクエストで、プロパティに指定値を持つようにCell作成
    func addTimetableCell(subjectName:String,classroomName:String,teacherName:String,day:Int,period:Int,timetable:String,cellColor:Int) {
        let command = TimetableCellModel.CreateTimetableCellCommand(subjectName:subjectName,classroomName:classroomName,teacherName:teacherName,day:day,period:period,timetable: timetable, cellColor: cellColor)
        objectWillChange.send()
        model.executeCommand(command)
    }
    
    func removeTimetableCell(_ id: TimetableCell.ID) {
            let command = TimetableCellModel.RemoveTimetableCellCommand(id)
            objectWillChange.send()
            model.executeCommand(command)
    }
    
    func updateTimetableCellSubjectName(_ id: TimetableCell.ID, newSubjectName: String) {
            let command = TimetableCellModel.UpdateTimetableCellProperty(id, keyPath: \TimetableCell.subjectName, newValue: newSubjectName)
            objectWillChange.send()
            model.executeCommand(command)
        }
    
    func updateTimetableCellClassroomName(_ id: TimetableCell.ID, newClassroomName: String) {
            let command = TimetableCellModel.UpdateTimetableCellProperty(id, keyPath: \TimetableCell.classroomName, newValue: newClassroomName)
            objectWillChange.send()
            model.executeCommand(command)
        }
    
    func updateTimetableCellTeacherName(_ id: TimetableCell.ID, newTeacherName: String) {
            let command = TimetableCellModel.UpdateTimetableCellProperty(id, keyPath: \TimetableCell.teacherName, newValue: newTeacherName)
            objectWillChange.send()
            model.executeCommand(command)
        }
    
    func updateTimetableCellColor(_ id: TimetableCell.ID, newCellColor: Int) {
            let command = TimetableCellModel.UpdateTimetableCellProperty(id, keyPath: \TimetableCell.cellColor, newValue: newCellColor)
            objectWillChange.send()
            model.executeCommand(command)
        }
}
