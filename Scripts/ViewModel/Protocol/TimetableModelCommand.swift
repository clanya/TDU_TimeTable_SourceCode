//
//  TimetableModelCommand.swift
//  Timetable
//
//  Created by 谷田和基 on 2022/06/27.
//

import Foundation

protocol TimetableModelCommand: AnyObject {
    func execute(_ model: TimetableModel)
}
