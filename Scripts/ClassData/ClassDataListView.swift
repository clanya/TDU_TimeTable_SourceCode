//
//  ClassDa.swift
//  Timetable
//
//  Created by 谷田和基 on 2022/07/04.
//

import SwiftUI
import RealmSwift

func readFromFile(csv: String) -> [String] {//ファイル読み込み
    guard let fileURL = Bundle.main.url(forResource: csv, withExtension: "csv")  else {
        fatalError("Not Found File!!")
    }
     
    guard let fileContents = try? String(contentsOf: fileURL) else {
        fatalError("Can't Load Error!!")
    }
    let countries = fileContents.components(separatedBy: "\n")
    
    return countries;
}
struct ClassDataListView: View {
    @Environment(\.dismiss) var dismiss
    let p_day:String                    //曜日指定用変数
    let p_time:String                   //時間指定用変数
    @State var selectedClass = 0        //選ばれた科目
    
    @Binding var subjectName:String
    @Binding var classroomName:String
    @Binding var teacherName:String
    
    init(p_day:String,p_time:String,subjectName:Binding<String>,classroomName:Binding<String>,teacherName:Binding<String>){
        let realm = try! Realm()
        try! realm.write {}
        let datas = realm.objects(ClassData.self)       //データベースの読み込み
        
        if(datas.count==0){                             //データが何も入ってないときにファイルを読み込む
            let c_data = readFromFile(csv: "ClassList") //csvを読み込み配列化
            for data in c_data{
                if(!data.isEmpty){
                    ClassData().saveCsvValue(csvStr: data)
                }
            }
        }
        
        self.p_day = p_day
        self.p_time = p_time
        self._subjectName = subjectName
        self._classroomName = classroomName
        self._teacherName = teacherName
        print("p_day:%@",self.p_day)
        print("p_time:%@",self.p_time)
    }
    
   var body: some View {
       let realm = try! Realm()
        let data = realm.objects(ClassData.self).filter("id == 0 || (day CONTAINS %@ && time CONTAINS %@) || day CONTAINS '集中'", p_day,p_time)//データの絞り込み(選択用)
       let alldata = realm.objects(ClassData.self)//表示用データ

        Form {
            Section {
                Picker(selection: $selectedClass, label: Text("科目："+"\(alldata[selectedClass].name)"+"\(alldata[selectedClass].course)")){
                        ForEach(data,id: \.id){ Model in
                            Text("\(Model.name)"+"\(Model.course)"+"\n"+"\(Model.teacher)")
                        }
                }
                        Text("教室："+"\(alldata[selectedClass].loom)")
                        Text("教員："+"\(alldata[selectedClass].teacher)")
            }
            
            Button("保存する"){
                if subjectName != alldata[selectedClass].name{
                    subjectName = alldata[selectedClass].name
                }
                
                if classroomName != alldata[selectedClass].loom{
                    classroomName = alldata[selectedClass].loom
                }
                
                if teacherName != alldata[selectedClass].teacher{
                    teacherName = alldata[selectedClass].teacher
                }
                dismiss()
            }
        }
    }
}


