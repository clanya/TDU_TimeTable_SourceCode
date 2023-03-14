//
//  TimetableCellModel.swift
//  Timetable
//
//  Created by 谷田和基 on 2022/06/26.
//

import RealmSwift

class TimetableCellModel: ObservableObject{
    var config: Realm.Configuration
       
    init() {
        config = Realm.Configuration()
    }
    
    var realm: Realm {
        return try! Realm(configuration: config)
    }
        
    var timetableCells: Results<TimetableCell> {
        realm.objects(TimetableCell.self)
    }
    
    func executeCommand(_ command: TimetableCellModelCommand) {
        command.execute(self)
    }
    
    func timetableCellFromID(_ id: TimetableCell.ID) -> TimetableCell? {
            timetableCells.first(where: {$0.id == id})
    }
}

extension TimetableCellModel {
    class CreateTimetableCellCommand : TimetableCellModelCommand{
        var subjectName = "Subject" //仮置き、本来は ""
        var classroomName : String = "Classroom"
        var teacherName : String = "Teacher"
        var day : Int = 0
        var period : Int = 1
        var cellColor = 0
        
        init(subjectName:String,classroomName:String,teacherName:String,day:Int,period:Int,timetable:String,cellColor:Int) {
            self.subjectName = subjectName
            self.classroomName = classroomName
            self.teacherName = teacherName
            self.day = day
            self.period = period
            self.cellColor = cellColor
            
        }
        
        func execute(_ model: TimetableCellModel) {
            let timetableCell = TimetableCell()
            timetableCell.id = UUID()
            timetableCell.subjectName = subjectName
            timetableCell.classroomName = classroomName
            timetableCell.teacherName = teacherName
            timetableCell.day = day
            timetableCell.period = period
            timetableCell.cellColor = cellColor
            try! model.realm.write {
                model.realm.add(timetableCell)
            }
        }
    }
    
    class RemoveTimetableCellCommand : TimetableCellModelCommand{
        var id: UUID
        
        init(_ id: TimetableCell.ID) {
                self.id = id
        }
            
        func execute(_ model: TimetableCellModel) {
            guard let timetableCellToBeRemoved = model.timetableCellFromID(self.id) else { return } // no item
            try! model.realm.write {
                model.realm.delete(timetableCellToBeRemoved)
            }
        }
    }
    
    class UpdateTimetableCellProperty<T>: TimetableCellModelCommand {
            let id: TimetableCell.ID
            let keyPath: ReferenceWritableKeyPath<TimetableCell, T>
            let newValue: T
            var oldValue: T?
            init(_ id: TimetableCell.ID, keyPath: ReferenceWritableKeyPath<TimetableCell, T>,  newValue: T) {
                self.id = id
                self.keyPath = keyPath
                self.newValue = newValue
                self.oldValue = nil
            }
            
            func execute(_ model: TimetableCellModel) {
                guard let item = model.timetableCellFromID(id) else { return }
                try! model.realm.write {
                    self.oldValue = item[keyPath: keyPath]
                    item[keyPath: keyPath] = newValue
                }
            }
            
            func undo(_ model: TimetableCellModel) {
                guard let item = model.timetableCellFromID(id) else { return }
                guard let oldValue = oldValue else { return } // not executed yet?
                try! model.realm.write {
                    item[keyPath: keyPath] = oldValue
                }
            }
        }
}


