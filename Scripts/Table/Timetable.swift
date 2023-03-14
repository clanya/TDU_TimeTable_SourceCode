//
//  Timetable.swift
//  Timetable
//
//  Created by 谷田和基 on 2022/05/16.
//

import RealmSwift

class Timetable: Object, Identifiable{
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var cells = RealmSwift.List<TimetableCell>()
    @Persisted var name : String
    @Persisted var maxPeriod : Int
    @Persisted var isSaturday:Bool
    @Persisted var isSunday:Bool
    @Persisted var isUsed:Bool
}


