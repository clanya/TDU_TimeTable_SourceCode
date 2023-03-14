//
//  MainView.swift
//  Timetable
//
//  Created by 谷田和基 on 2022/06/26.
//

import SwiftUI

struct MainView: View {
    //ViewModelをEnvironmentObjectとして渡す
    @EnvironmentObject var timetableViewModel: TimetableViewModel
    @EnvironmentObject var timetableCellViewModel: TimetableCellViewModel
    
    var coordinator = Coordinator()
        var body: some View {
            NavigationView {
                List {
                    //ViewModelがtimetableCellsとして ResultsResults<TimetableCell>を返すので、freezeして使う。
                    ForEach(timetableCellViewModel.timetableCells.freeze()) {
                        cell in
                        NavigationLink(destination: {coordinator.nextView(cell)},
                                       label: {Text("\(cell.subjectName):\(cell.teacherName):\(cell.classroomName)")})
                        
                    }.onDelete { indexSet in
                        if let index = indexSet.first {
                            timetableCellViewModel.removeTimetableCell(timetableCellViewModel.timetableCells[index].id)
                        }
                    }
                }
                .navigationTitle("Test")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack{
                            #if os(iOS)
                            EditButton()
                            #endif
                            Text("#: \(timetableCellViewModel.timetableCells.count)")
                        }

                    }
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {}, label: {
                            Image(systemName: "plus")
                        })
                    }
                }
            }
        }
}
