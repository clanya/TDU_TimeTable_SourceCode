//
//  TimetableModel.swift
//  Timetable
//
//  Created by 谷田和基 on 2022/06/26.
//

import RealmSwift
import SwiftUI

class TimetableModel: ObservableObject{
    var config: Realm.Configuration
       
    init() {
        config = Realm.Configuration()
    }
    
    var realm: Realm {
        return try! Realm(configuration: config)
    }
        
    var timetables: Results<Timetable> {
        realm.objects(Timetable.self)
    }
    
    func executeCommand(_ command: TimetableModelCommand) {
        command.execute(self)
    }
    
    func timetableFromID(_ id: Timetable.ID) -> Timetable? {
            timetables.first(where: {$0.id == id})
    }
}

extension TimetableModel {
    class CreateTimetableCommand : TimetableModelCommand{
        var name = "新しい時間割"
        var maxPeriod = 5
        var isSaturday = false
        var isSunday = false
        var isUsed = false
        init(name:String,maxPeriod:Int,isSaturday:Bool,isSunday:Bool,isUsed:Bool) {
            self.name = name
            self.maxPeriod = maxPeriod
            self.isSaturday = isSaturday
            self.isSunday = isSunday
            self.isUsed = isUsed
        }
        
        func execute(_ model: TimetableModel) {
            let timetable = Timetable()
            for day in 0..<7{
                for period in 0..<9{
                    let cell = TimetableCell()
                    cell.subjectName = ""
                    cell.classroomName = ""
                    cell.teacherName = ""
                    cell.day = day
                    cell.period = period
                    cell.timetable = timetable.id
                    timetable.cells.append(cell)
                }
            }
            timetable.id = UUID().uuidString
            timetable.name = name
            timetable.maxPeriod = maxPeriod
            timetable.isSaturday = isSaturday
            timetable.isSunday = isSunday
            timetable.isUsed = isUsed
            
            try! model.realm.write {
                model.realm.add(timetable)
            }
        }
    }
    
    class RemoveTimetableCommand : TimetableModelCommand{
        var id: String
        
        init(_ id: Timetable.ID) {
                self.id = id
        }
            
        func execute(_ model: TimetableModel) {
            guard let timetableToBeRemoved = model.timetableFromID(self.id) else { return } // no item
            try! model.realm.write {
                model.realm.delete(timetableToBeRemoved)
            }
        }
    }
    
    class UpdateTimetableProperty<T>: TimetableModelCommand {
            let id: Timetable.ID
            let keyPath: ReferenceWritableKeyPath<Timetable, T>
            let newValue: T
            var oldValue: T?
            init(_ id: Timetable.ID, keyPath: ReferenceWritableKeyPath<Timetable, T>,  newValue: T) {
                self.id = id
                self.keyPath = keyPath
                self.newValue = newValue
                self.oldValue = nil
            }
            
            func execute(_ model: TimetableModel) {
                guard let item = model.timetableFromID(id) else { return }
                try! model.realm.write {
                    self.oldValue = item[keyPath: keyPath]
                    item[keyPath: keyPath] = newValue
                }
            }
            
            func undo(_ model: TimetableModel) {
                guard let item = model.timetableFromID(id) else { return }
                guard let oldValue = oldValue else { return }
                try! model.realm.write {
                    item[keyPath: keyPath] = oldValue
                }
            }
        }
}


