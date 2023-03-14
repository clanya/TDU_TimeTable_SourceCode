//
//  TimetableCell.swift
//  Timetable
//
//  Created by 谷田和基 on 2022/05/16.
//

import SwiftUI
import RealmSwift

class TimetableCell: Object, Identifiable {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var subjectName: String
    @Persisted var classroomName : String
    @Persisted var teacherName : String
    @Persisted var day : Int
    @Persisted var period : Int
    @Persisted var timetable : String
    @Persisted var cellColor : Int
}




