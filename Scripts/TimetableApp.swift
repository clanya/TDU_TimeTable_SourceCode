//
//  TimetableApp.swift
//  Timetable
//
//  Created by 谷田和基 on 2022/04/25.
//

import SwiftUI

@main
struct TimetableApp: App {
    @StateObject var timetableViewModel: TimetableViewModel = TimetableViewModel()
    @StateObject var timetableCellViewModel: TimetableCellViewModel = TimetableCellViewModel()
    var body: some Scene {
        WindowGroup {
            TimetableView()
                .environmentObject(timetableViewModel)
                .environmentObject(timetableCellViewModel)
        }
    }
}
