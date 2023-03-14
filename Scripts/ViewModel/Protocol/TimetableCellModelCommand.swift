//
//  TimetableCellCommand.swift
//  Timetable
//
//  Created by 谷田和基 on 2022/06/27.
//

import Foundation

protocol TimetableCellModelCommand: AnyObject {
    func execute(_ model: TimetableCellModel)
}
