//
//  ClassData.swift
//  Timetable
//
//  Created by 谷田和基 on 2022/07/04.
//

import Foundation
import RealmSwift

func check(C :String)->Bool{                    //複数の,にまたがっているかの確認
    (C.contains("\"")) && !(C.hasSuffix("\""))
}
//Realmのクラス
class ClassData:Object{
    @objc dynamic var id:Int = 0;               //id
    @objc dynamic var department:String="";     //学系
    @objc dynamic var semester:String="";       //学期
    @objc dynamic var year:String="";           //学年
    @objc dynamic var day:String="";            //曜日
    @objc dynamic var time:String="";           //時限
    @objc dynamic var name:String="";           //名前
    @objc dynamic var course:String="";         //コース
    @objc dynamic var teacher:String="";        //教員
    @objc dynamic var loom:String="";           //教室
    
    func saveCsvValue(csvStr:String) {
        // CSVなのでカンマでセパレート
        var i=0,j=0,k=0;
        let splitStr = csvStr.components(separatedBy: ",")
        if(Int(splitStr[0])! == 0){//id:0のときの空データの作成
            self.id = 0
            self.department = ""
            self.semester = ""
            self.year = ""
            self.day = ""
            self.time = ""
            self.name = ""
            self.course = ""
            self.teacher = ""
            self.loom = ""
        }else{
            self.id = Int(splitStr[0])!
            self.department = splitStr[1]
            self.semester = splitStr[2]
            self.year = splitStr[3]
            while(check(C: self.year)){// ""で囲まれている要素の処理
                i = i+1;
                self.year = self.year+" "+splitStr[3+i];
            }
            self.day = splitStr[4+i]
            while(check(C: self.day)){
                j = j+1;
                self.day = self.day+" "+splitStr[4+i+j];
            }
            self.time = splitStr[5+i+j]
            while(check(C: self.time)){
                k = k+1;
                self.time = self.time+" "+splitStr[5+i+j+k];
            }
            self.name = splitStr[6+i+j+k]
            if(splitStr[7+i+j+k].isEmpty){
                self.course = ""
            }else{
                self.course = splitStr[7+i+j+k]
            }
            self.teacher = splitStr[8+i+j+k]
            if(splitStr.count>9+i+j+k){
                self.loom = splitStr[9+i+j+k]
            }
        }
        let realm = try! Realm()
        do {
            try realm.write{
                realm.add(self)
            }
        } catch {
        }
    }
}
