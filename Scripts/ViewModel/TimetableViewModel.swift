//
//  TimetableViewModel.swift
//  Timetable
//
//  Created by 谷田和基 on 2022/06/27.
//

import RealmSwift

class TimetableViewModel: ObservableObject {
    @Published var model: TimetableModel = TimetableModel()
    init(){
        while timetables.count < 15{
            addTimetable(name: "新しい時間割", maxPeriod: 5, isSaturday: false, isSunday: false, isUsed: false)
        }
    }
    //Modelから受け取るResults<Timetable>をViewへ渡す
    var timetables: Results<Timetable> {
        model.timetables
    }
    //Viewからのリクエストで、プロパティに指定値を持つようにTimetable作成
    func addTimetable(name:String,maxPeriod:Int,isSaturday:Bool,isSunday:Bool,isUsed:Bool) {
        let command = TimetableModel.CreateTimetableCommand(name: name, maxPeriod: maxPeriod, isSaturday: isSaturday, isSunday: isSunday,isUsed: isUsed)
        //変更することを明示する
        self.objectWillChange.send()
        //Modelへ作成を依頼する
        model.executeCommand(command)
    }
    
    func removeTimetable(_ id: Timetable.ID) {
            let command = TimetableModel.RemoveTimetableCommand(id)
            objectWillChange.send()
            model.executeCommand(command)
    }
    
    func updateTimetableCells(_ id: Timetable.ID, newCells: RealmSwift.List<TimetableCell>) {
            let command = TimetableModel.UpdateTimetableProperty(id, keyPath: \Timetable.cells, newValue: newCells)
            objectWillChange.send()
            model.executeCommand(command)
        }
    
    func updateName(_ id: Timetable.ID, newName: String) {
            let command = TimetableModel.UpdateTimetableProperty(id, keyPath: \Timetable.name, newValue: newName)
            objectWillChange.send()
            model.executeCommand(command)
        }
    
    func updateTimetableMaxPeriod(_ id: Timetable.ID, newMaxPeriod: Int) {
            let command = TimetableModel.UpdateTimetableProperty(id, keyPath: \Timetable.maxPeriod, newValue: newMaxPeriod)
            objectWillChange.send()
            model.executeCommand(command)
        }
    
    func updateTimetableIsSaturday(_ id: Timetable.ID, newIsSaturday: Bool) {
            let command = TimetableModel.UpdateTimetableProperty(id, keyPath: \Timetable.isSaturday, newValue: newIsSaturday)
            objectWillChange.send()
            model.executeCommand(command)
        }
    
    func updateTimetableIsSunday(_ id: Timetable.ID, newIsSunday: Bool) {
            let command = TimetableModel.UpdateTimetableProperty(id, keyPath: \Timetable.isSunday, newValue: newIsSunday)
            objectWillChange.send()
            model.executeCommand(command)
        }
    
    func updateTimetableIsUsed(_ id: Timetable.ID, newIsUsed: Bool) {
            let command = TimetableModel.UpdateTimetableProperty(id, keyPath: \Timetable.isUsed, newValue: newIsUsed)
            objectWillChange.send()
            model.executeCommand(command)
        }
}
